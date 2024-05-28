import { Response } from "express";
import { AppDataSource } from "../config/ormconfig";
import { Tracker } from "../entity/Tracker.entity";
import { Transaction } from "../entity/Transaction.entity";
import { ExtendedRequest } from "../middlewares/Authentication";
import { Invoice } from "../entity/Invoices.entity";
import { User } from "../entity/Users.entity";

export class TransactionsController {
    static async createTransaction(req: ExtendedRequest, trackerData: Tracker, invoice: Invoice) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = new Transaction();
            transaction.name = trackerData.name;
            transaction.status = 0;
            transaction.sender = trackerData.senderUser;
            transaction.receiver = trackerData.receiverUser;
            transaction.trip = trackerData.trip;
            if (!invoice) {
                transaction.invoice = invoice;
            }
            return await transactionRepository.save(transaction);
        } catch (error: any) {
            throw new Error(error.message);
        }
    }

    static async getAllTransactions(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            if (!req.body.id) {
                return res.status(400).json({message: 'Missing the id of the user'});
            }
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.body.id}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            } 
            const result = await transactionRepository.find({
                                                    relations: {sender: true, receiver: true, trip: true}
                                                    , where: [
                                                        {   sender:     {   id: user.id   } },
                                                        {   receiver:   {   id: user.id   } }
                                                    ]});
            return res.status(200).json({mesage: 'Transactions retrieved successfully!', data: result});
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

    static async getTransactionById(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const result = await transactionRepository.findOne({relations: {sender: true, receiver: true, trip: true}, 
                                                                where: {id : Number(req.params.id)}});
            return res.status(200).json({mesage: 'Transaction retrieved successfully!', data: result})
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

    static async updateTransactionInvoice(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = await transactionRepository.findOneBy({ id: Number(req.params.id) });
            if (!transaction) {
                return res.status(404).json({ message: "Transaction not found" });
            }
            if (!req.body.invoiceId) {
                return res.status(400).json({messgae: "Missing invoice id"});
            }
            const invoice = await AppDataSource.getRepository(Invoice).findOneBy({id : req.body.invoiceId})
            if (!invoice) {
                return res.status(404).json({ message: "Invoice not found" });
            }
            transaction.invoice = invoice;
            const result = await transactionRepository.save(transaction);
            return res.status(200).json({mesage: 'Transaction update successfully!', data: result})
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

    static async updateTransactionStatus(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = await transactionRepository.findOne({relations: {sender: true, receiver: true, trip: true}, 
                                                                    where : {id : Number(req.params.id)}});
            if (!transaction) {
                return res.status(404).json({message: "Transaction not found"});
            }
            transaction.status = 1;
            const result = await transactionRepository.save(transaction);
            return res.status(200).json({mesage: 'Transaction update successfully!', data: result})
        } catch (error : any) {
            return res.status(500).json({message: error.message})
        }
    }

    static async deleteTransaction(req: ExtendedRequest, res: Response) {
        try {
            const transactionRepository = AppDataSource.getRepository(Transaction);
            const transaction = await transactionRepository.findOneBy({id : Number(req.params.id)});
            if (!transaction) {
                return res.status(404).json({message: "Transaction not found"});
            }
            await transactionRepository.delete(transaction);
            return res.status(200).json({message: "Transaction deleted successufully!"});
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

}

