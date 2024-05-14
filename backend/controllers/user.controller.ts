import { NextFunction, Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { encrypt, getToken } from "../helpers/helpers";
import { User } from "../entity/Users.entity";
import { Not } from "typeorm";
import axios from "axios";
import { WalletController } from "./wallet.controller";
import { Role } from "../entity/Roles.entity";

export class UserController {
    static async getAllUsers(req: ExtendedRequest, res: Response) {
        try {
            console.log('the user information in req:', req.user, ', the auth0UserId:', req.user?.sub, req.oidc.user);
            const UserRepository = AppDataSource.getRepository(User);
            const users = await UserRepository.find();
            return res.status(200).json({message:"All users fetched successfully", data: users});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getMyInfo(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
            return res.status(200).json({ message:"User fetched successfully", data: user});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getUser(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.find({where: {auth0UserId: req.params.id}});
            return res.status(200).json({data: user});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    //TODO: Still an issue with the auth0 update patch request: To fix
    static async updateUserInfo(req: ExtendedRequest, res: Response, next: NextFunction) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            if (req.body?.email) {
                const checkMail = await UserRepository.findOne({where: {email: req.body?.email, id: Not(user.id)}});
                if (checkMail) {
                    return res.status(400).json({message: "Email already in use"});
                }
            }
            user.name = req.body.name;
            user.email = req.body.email;
            user.path = req.body.path;
            await UserRepository.save(user);
            let token = await getToken();
            
            axios.patch(`${process.env.AUTH0_DOMAIN}/api/v2/users/${user.auth0UserId}`, {name: user.name, picture: user.path},{
                headers: {
                    "Content-Type": "application/json",
                    authorization: `Bearer ${token.access_token}`
                }
            })
            .then(async (response) => {
                res.status(200).json({message: "User updated successfully", data: user});
            })
            .catch((error: any)=> {
                // console.log('the error:', error);
                return res.status(500).json({error: error.message});
            })

        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async changePassword(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            
            let token = await getToken();
            let dataObj = JSON.stringify({"password": req.body.password, "connection": "Username-Password-Authentication"});
            axios.patch(`${process.env.AUTH0_DOMAIN}/api/v2/users/${user.auth0UserId}`, dataObj,{
                headers: {
                    "content-type": "application/json",
                    authorization: `Bearer ${token.access_token}`
                }
            })
            .then((response) => {
                return res.status(200).json({message: "Password changed successfully", data: user});
            })
            .catch((error: any)=> {
                return res.status(500).json({error: error.message});
            })
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async changePhoto(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            // const path = await uploadFile(req.file);
            // user.path = path;
            await UserRepository.save(user);
            return res.status(200).json({message: "Profile picture updated successfully"});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async deleteUser(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            await WalletController.deleteWallet(req);
            const role = await AppDataSource.getRepository(Role).findOne({relations: {user: true}, where: {user: {id: user.id}}});
            if (role) {
                await AppDataSource.getRepository(Role).delete(role);
            }
            await UserRepository.delete(user.id);
            let token = await getToken();
            let options = {
                method: 'DELETE',
                url: `${process.env.AUTH0_DOMAIN}/api/v2/users/${user.auth0UserId}`,
                headers: {
                    'content-type': 'application/json',
                    'authorization': `Bearer ${token.access_token}`
                }
            };

            await axios.request(options).then((response) => {
                console.log(response.data);
            }).catch((error: any)=> {
                return res.status(500).json({error: error.message});
            })
            return res.status(200).json({message: "User deleted successfully"});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
}