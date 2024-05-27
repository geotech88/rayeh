import { Response } from "express";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import jwt from 'jsonwebtoken';
import { ExtendedRequest } from "../middlewares/Authentication";
import { Role } from "../entity/Roles.entity";
import { WalletController } from "./wallet.controller";

export class AuthenticationController {
    static async addUser(req: ExtendedRequest, res: Response) {
        const authHeader = req.headers['authorization'] || "";
        const token = authHeader && authHeader.split(' ')[1];
        if (!token) {
            return res.status(401).json({ message: 'Access token is missing or invalid' });
        }

        try {
            const response = await fetch(`${process.env.AUTH0_DOMAIN}/userinfo`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            });

            if (!response.ok) {
                return res.status(401).json({ error: 'Invalid token' });
            }
            
            const auth0User = await response.json();
            const userRepository = AppDataSource.getRepository(User);
            const roleRepository = AppDataSource.getRepository(Role);

            let user = await userRepository.findOne({ where: { auth0UserId: auth0User.sub } });

            if (!user) {
                user = new User();
                user.name = auth0User.name as string;
                user.email = auth0User.email as string;
                user.auth0UserId = auth0User.sub as string;
                user.path = auth0User.picture as string;

                let roleUser = await roleRepository.findOne({ where: { name: 'user' } });
                if (!roleUser) {
                    roleUser = new Role();
                    roleUser.name = 'user';
                    await roleRepository.save(roleUser);
                }

                user.role = roleUser;
                await userRepository.save(user);
                await WalletController.createWallet(req, res);
            }

            const jwtToken = jwt.sign({ userId: auth0User.sub }, process.env.AUTH0_CLIENT_SECRET!, {
                algorithm: 'HS256',
                expiresIn: '24h',
            });

            return res.status(200).json({ token: jwtToken });
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
        }
    };
}