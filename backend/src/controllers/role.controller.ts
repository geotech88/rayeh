import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { Role } from "../entity/Roles.entity";

export class RoleController {
    static async getRole(req: ExtendedRequest, res: Response) {
        try {
            const role = await AppDataSource.getRepository(Role).findOne({where: {user: {auth0UserId: req.user?.userId}}});
            if (!role) {
                return res.status(404).json({message: "Role of user not found!"});
            }
            return res.status(200).json({message: "Role retrieved successefully!", data: role});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
}