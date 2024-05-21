import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Role } from "../entity/Roles.entity";
import { WalletController } from "./wallet.controller";

export class AuthenticationController {
    static async addUser(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const findUser = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
            if (!findUser) {
                return res.status(403).json({message: 'User already added in database!'});
            }
            if (!req.body.role || (req.body.role && !['admin', 'user'].includes(req.body.role))) {
                return res.status(400).json({message: 'something wrong with the body parameter!'});
            }
            const user = new User();
            const RoleRepository = AppDataSource.getRepository(Role);
            const roleUser = new Role();
            roleUser.name = req.body.role;
            await RoleRepository.save(roleUser);
            user.name = req.user?.name as string;
            user.email = req.user?.email as string;
            user.auth0UserId = req.user?.sub as string;
            user.path = req.user?.picture as string;
            user.role = roleUser;
            await UserRepository.save(user);
            await WalletController.createWallet(req, res);
            const auth = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.sub}});
            return res.status(200).json({message: 'User saved in database and authenticated!', data: auth})
        }catch (err: any) {
            return res.status(500).json({message: 'Internal Server error'})
        }
    }
}