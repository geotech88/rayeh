import { Response } from "express";
import { AppDataSource } from "../config/ormconfig";
import { Tracker } from "../entity/Tracker.entity";
import { Transaction } from "../entity/Transaction.entity";
import { ExtendedRequest } from "../middlewares/Authentication";
import { Invoice } from "../entity/Invoices.entity";

export class TransactionsController {
    static async createTransaction(req: ExtendedRequest, trackerData: Tracker) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = new Transaction();
            transaction.name = trackerData.name;
            transaction.status = 0;
            transaction.sender = trackerData.senderUser;
            transaction.receiver = trackerData.receiverUser;
            transaction.trip = trackerData.trip;
            return await transactionRepository.save(transaction);
        } catch (error: any) {
            throw new Error(error.message);
        }
    }

    static async getAllTransactions(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            return await transactionRepository.find({relations: {sender: true, receiver: true, trip: true}
                                                    , where: [{sender: {auth0UserId: req.body.id}, receiver: {auth0UserId: req.body.id}}]});
            
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

    static async getTransactionById(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            return await transactionRepository.findOneBy({id : Number(req.params)});
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

    static async updateTransactionInvoice(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = await transactionRepository.findOneBy({ id: Number(req.params) });
            if (!transaction) {
                return res.status(404).json({ message: "Transaction not found" });
            }
            const invoice = await AppDataSource.getRepository(Invoice).findOneBy({id : req.body.invoiceId})
            if (!invoice) {
                return res.status(404).json({ message: "Invoice not found" });
            }
            transaction.invoice = invoice;
            return await transactionRepository.save(transaction);
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

    static async updateTransactionStatus(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = await transactionRepository.findOneBy({id : Number(req.params)});
            if (!transaction) {
                return res.status(404).json({message: "Transaction not found"});
            }
            transaction.status = 1;
            return await transactionRepository.save(transaction);
        } catch (error : any) {
            return res.status(500).json({message: error.message})
        }
    }

    static async deleteTransaction(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = await transactionRepository.findOneBy({id : Number(req.params)});
            if (!transaction) {
                return res.status(404).json({message: "Transaction not found"});
            }
            return await transactionRepository.delete(transaction);
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

}

