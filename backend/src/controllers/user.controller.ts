import { NextFunction, Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Not } from "typeorm";
import { WalletController } from "./wallet.controller";
import { Role } from "../entity/Roles.entity";
import { GenralCDNController } from "./generalCDN.controller";

export class UserController {

    static async getAllUsers(req: ExtendedRequest, res: Response) {
        try {
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
            const user = await UserRepository.findOne({relations: {role: true}, where: {auth0UserId: req.user?.userId}});
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

    static async updateUserInfo(req: ExtendedRequest, res: Response, next: NextFunction) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            if (req.body?.email) {
                const checkMail = await UserRepository.findOne({where: {email: req.body?.email, id: Not(user.id)}});
                if (checkMail) {
                    return res.status(401).json({message: "Email already in use"});
                }
            }
            user.name = req.body.name;
            if (req.user?.userId?.startsWith("auth0")) {
                // return res.status(401).json({message: `Cannot update email for ${req.user?.userId?.split("|")[0]}`})
                user.email = req.body.email;
            }
            user.path = req.body.picture;
            user.profession = req.body.profession;
            await UserRepository.save(user);

            res.status(200).json({message: "User updated successfully", data: user});

        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async changePassword(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            return res.status(200).json({message: "Password changed successfully", data: user});
            // })
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async changePhoto(req: ExtendedRequest, res: Response) {
        try {
            const CDNController = new GenralCDNController();
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const result = await CDNController.uploadFile(req);
            if (result.message) {
                return res.status(400).json({message: result.message});
            }
            const path = result.file_url;
            user.path = path;
            await UserRepository.save(user);
            return res.status(200).json({message: "Profile picture updated successfully", data: {url: path}});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async deleteUser(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            await WalletController.deleteWallet(req);
            const role = await AppDataSource.getRepository(Role).findOne({relations: {user: true}, where: {user: {id: user.id}}});
            if (role) {
                await AppDataSource.getRepository(Role).delete(role);
            }
            await UserRepository.delete(user.id);

            return res.status(200).json({message: "User deleted successfully"});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
}