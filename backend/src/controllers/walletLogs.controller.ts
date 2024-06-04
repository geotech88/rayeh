import { Response } from 'express';
import { WalletLogs } from '../entity/WalletLogs.entity';
import { AppDataSource } from '../config/ormconfig';
import { User } from '../entity/Users.entity';
import { alterColumns } from "../helpers/alterDatabase"; 
import { ExtendedRequest } from "../middlewares/Authentication";

export class WalletLogsController {
    static async alterDatabaseSchema(req: ExtendedRequest, res: Response) {
        try {
            await alterColumns();
            return res.status(200).json({ message: "Database schema altered successfully." });
        } catch (error: any) {
            return res.status(500).json({ error: error.message });
        }
    }
    static async createWalletLog(req: any, res: Response) {
        try {
            const { balance, currency, amount } = req.body;
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.userId}})
            if (!user) {
                return res.status(404).send({message: "user not found"})
            }
            const WalletLogsRepository = AppDataSource.getRepository(WalletLogs);
            const walletLog = new WalletLogs();
            walletLog.user = user;
            walletLog.balance = balance;
            walletLog.currency = currency;
            walletLog.amount = amount;
            await WalletLogsRepository.save(walletLog);
            return res.status(200).json({message: "Wallet log created", data: walletLog});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getAllUserWalletLogs(req: any, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).find({where: {auth0UserId: req.user?.userId}})
            if (!user) {
                return res.status(404).send({message: "user not found"})
            }
            const walletLogs = await AppDataSource.getRepository(WalletLogs).find({relations:{user: true}, where: {user: user}});
            if (!walletLogs.length) {
                return res.status(404).json({message: "No wallet logs found"});
            }
            return res.status(200).json({message: 'All wallet logs retrieved', data: walletLogs});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
    
    static async deleteWalletLog(req: any, res: Response) {
        try {
            const walletLog = await AppDataSource.getRepository(WalletLogs).findOne({where: {id: Number(req.params?.id)}});
            if (!walletLog) {
                return res.status(404).json({message: "Wallet log not found"});
            }
            await AppDataSource.getRepository(WalletLogs).delete(walletLog);
            return res.status(200).json({message: 'Wallet log deleted successfully'});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
}