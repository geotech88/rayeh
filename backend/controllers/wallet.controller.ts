import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Wallet } from "../entity/Wallet.entity";
import { conversionCurrency } from "../helpers/helpers";

export class WalletController {
    static async createWallet(req: ExtendedRequest, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.sub}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const WalletRepository = AppDataSource.getRepository(Wallet);
            const wallet = new Wallet();
            wallet.user = user;
            await WalletRepository.save(wallet);
            return {message: "Wallet created!", data: wallet};
        } catch(error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getWallet(req: ExtendedRequest, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.sub}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const wallet = await AppDataSource.getRepository(Wallet).findOne({where: {user: user}});
            if (!wallet) {
                return res.status(404).json({message: "Wallet not found"});
            }
            return res.status(200).json({message: "Wallet retrieved successfully", data: wallet});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async updateWalletBalance(req: ExtendedRequest, res: Response) {
        try {
            const { balance } = req.body;
            const wallet = await AppDataSource.getRepository(Wallet).findOne({where: {id: Number(req.params.id)}});
            if (!wallet) {
                return res.status(404).json({message: "Wallet not found"});
            }
            wallet.balance = balance;
            await AppDataSource.getRepository(Wallet).save(wallet);
            return res.status(200).json({message: "Wallet balance updated successfully", data: wallet});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async updateWalletCurrency(req: ExtendedRequest, res: Response) {
        try {
            const { currency } = req.body;
            const wallet = await AppDataSource.getRepository(Wallet).findOne({where: {id: Number(req.params.id)}});
            if (!wallet) {
                return res.status(404).json({message: "Wallet not found"});
            }
            //TODO: Add currency conversion logic here
            const conversion: number = await conversionCurrency(wallet.currency, currency, wallet.balance);
            wallet.currency = currency;
            wallet.balance = conversion;
            await AppDataSource.getRepository(Wallet).save(wallet);
            return res.status(200).json({message: "Wallet currency updated successfully", data: wallet});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async deleteWallet(req: ExtendedRequest) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.sub}});
            const wallet = await AppDataSource.
                    getRepository(Wallet).findOne(
                        {
                            relations: {user: true},
                            where: {user: 
                                {id: user?.id}
                            }
                        }
                    );
            if (!wallet) {
                return {message: "Wallet not found"};
            }
            await AppDataSource.getRepository(Wallet).delete(wallet);
            return {message: "Wallet retrieved successfully", data: wallet};
        } catch (error: any) {
            return {error: error.message};
        }
    }
}