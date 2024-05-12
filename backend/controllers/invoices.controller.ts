import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Invoice } from "../entity/Invoices.entity";

export class InvoicesController {
    
    static async createInvoice(req: ExtendedRequest, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({where: {email: req.user?.email}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const { amount, paymentMethod, currency, status, issueDate, dueDate } = req.body;
            const InvoiceRepository = AppDataSource.getRepository(Invoice);
            const invoice = new Invoice();
            invoice.amount = amount;
            invoice.paymentMethod = paymentMethod;
            invoice.currency = currency;
            invoice.status = status;
            invoice.issueDate = new Date(issueDate) as Date;
            invoice.dueDate = new Date(dueDate) as Date;
            invoice.user = user;
            await InvoiceRepository.save(invoice);
            return res.status(200).json({message: "Invoice created", data: invoice});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getAllUserInvoices(req: ExtendedRequest, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({where: {email: req.user?.email}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const invoices = await AppDataSource.getRepository(Invoice).find({relations: {user: true },where: {user: {id: user.id}}});
            if (!invoices.length) {
                return res.status(404).json({message: "No invoices found"});
            }
            return res.status(200).json({message: 'All invoices retrieved', data: invoices});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
    
    static async deleteInvoice(req: ExtendedRequest, res: Response) {
        try {
            const invoice = await AppDataSource.getRepository(Invoice).findOne({where: {id: Number(req.params.id)}});
            if (!invoice) {
                return res.status(404).json({message: "Invoice not found"});
            }
            await AppDataSource.getRepository(Invoice).delete(invoice);
            return res.status(200).json({message: 'Invoice deleted successfully'});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
}