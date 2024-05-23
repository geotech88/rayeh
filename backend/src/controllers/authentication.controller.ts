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
        const { role } = req.body;
        if (!token) {
            return res.status(401).json({ message: 'Access token is missing or invalid' });
        }
        if (!role) {
            return res.status(400).json({message: 'missing parameter!'})
        }

      
        try {
          const response = await fetch(`${process.env.AUTH0_DOMAIN}/userinfo`, {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          });
          
          if (!response.ok) {
            res.status(401).json({ error: 'Invalid token' });
          }
          const auth0User = await response.json();
          const userRepository = AppDataSource.getRepository(User);
      
          let user = await userRepository.findOne({ where: { auth0UserId: auth0User.sub } });
      
          if (!user) {
            const newUser = new User();
            const RoleRepository = AppDataSource.getRepository(Role);
            const roleUser = new Role();
            roleUser.name = req.body.role;
            await RoleRepository.save(roleUser);
            newUser.name = auth0User.name as string;
            newUser.email = auth0User.email as string;
            newUser.auth0UserId = auth0User.sub as string;
            newUser.path = auth0User.picture as string;
            newUser.role = roleUser;
            await userRepository.save(newUser);
            await WalletController.createWallet(req, res);
          }
      
          const jwtToken = jwt.sign({ userId: auth0User.sub }, process.env.AUTH0_CLIENT_SECRET!, {
            algorithm: 'HS256',
            expiresIn: '24h',
          });
      
          res.status(200).json({ token: jwtToken });
        } catch (error: any) {
          console.error('Error authenticating user:', error);
          res.status(401).json({ error: error.message });
        }
      };
}