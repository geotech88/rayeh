import { Response, NextFunction } from "express";
import { ExtendedRequest } from "./Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";

export const authorized = (roles: Array<string>) => {
    return async (req: ExtendedRequest, res: Response, next: NextFunction) => {
        const user = await AppDataSource.getRepository(User).findOne({ where: { auth0UserId: req.user?.userId }, relations: ['role'] });

        if (user && roles.includes(user?.role?.name)) {
            next();
        } else {
            res.status(403).send({ exception: "Forbidden", message: "You're not authorized to access this resource" });
        }
    }
}