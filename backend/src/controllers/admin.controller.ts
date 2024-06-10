import { Not } from "typeorm";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Wallet } from "../entity/Wallet.entity";
import { ExtendedRequest } from "../middlewares/Authentication";
import { Response } from 'express';
import { Invoice } from "../entity/Invoices.entity";
import { Operations } from "../entity/Operations.entity";
import { Reviews } from "../entity/Reviews.entity";
import { calculateReviewsAverage } from "../helpers/helpers";
import { Role } from "../entity/Roles.entity";
import { Transaction } from "../entity/Transaction.entity";

const HYPERPAY_URL = process.env.HYPERPAY_URL as string;
const HYPERPAY_ENTITY_VISA_MASTERCARD_ID = process.env.HYPERPAY_ENTITY_VISA_MASTERCARD as string;
const HYPERPAY_ENTITY_MADA_ID = process.env.HYPERPAY_ENTITY_MADA as string;
const HYPERPAY_AUTH_TOKEN = process.env.HYERPAY_AUTH_TOKEN as string;

export class AdminController {

    static async acceptPayments(req: ExtendedRequest, res: Response){
        try {
            const { amount, bankAccountDetails, operationId } = req.query;
            if (!amount || !bankAccountDetails || operationId) {
                return res.status(400).json({message: "Missing parameters in query!"})
            }
            const walletRepository = AppDataSource.getRepository(Wallet);
            const wallet = await walletRepository.findOne({ where: { user: { id: req.user?.userId } } });
    
            if (!wallet) {
                return res.status(404).json({ message: 'Wallet not found' });
            }
    
            const operation = await AppDataSource.getRepository(Operations).findOne({where: {id: Number(operationId)}});
            if (!operation) {
                return res.status(404).json({message: "The operation is not available"});
            }
            // Ensure the wallet has sufficient balance
            if (wallet.balance < Number(amount)) {
                return res.status(400).json({ message: 'Insufficient balance' });
            }
    
            const formattedAmount = parseFloat(String(amount)).toFixed(2);
    
            const params = new URLSearchParams({
                entityId: HYPERPAY_ENTITY_VISA_MASTERCARD_ID,
                amount: formattedAmount,
                currency: wallet.currency,
                paymentType: 'RF', // Refund transaction
                bankAccount: JSON.stringify(bankAccountDetails)
            });
    
            console.log("Withdrawal request parameters:", params.toString());
    
            const response = await fetch(`${HYPERPAY_URL}/payments`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${HYPERPAY_AUTH_TOKEN}`,
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            });
    
            const data = await response.json();
    
            if (!response.ok) {
                console.error(`Error response from Hyperpay: ${JSON.stringify(data)}`);
                return res.status(response.status).json({ message: `Error: ${data.result.description}` });
            }
    
            wallet.balance -= parseFloat(String(amount));
            await walletRepository.save(wallet);
            operation.pending = false;
            operation.status = 'accepted';
            await AppDataSource.getRepository(Operations).save(operation);
    
            return res.json({ message: 'Withdrawal successful', data: {transactionId: data.id, wallet} });
        } catch (error: any) {
            return res.status(500).json({message: error.message})
        }
    }

    static async updateRole(req: ExtendedRequest, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({relations: ['role'], where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: 'User not found!'});
            }
            let newRole;
            if (user.role.name === 'admin') {
                const RoleRepository = AppDataSource.getRepository(Role);
                const roleUser = await RoleRepository.findOne({where: {id: user.role.id}});
                if (!roleUser) {
                    return res.status(400).json({message: "Something wrong with role of user"});
                }
                newRole = 'user';
                roleUser.name = 'user';
                await RoleRepository.save(roleUser);
            } else {
                
                const RoleRepository = AppDataSource.getRepository(Role);
                const roleUser = await RoleRepository.findOne({where: {id: user.role.id}});
                if (!roleUser) {
                    return res.status(400).json({message: "Something wrong with role of user"});
                }
                newRole = 'admin';
                roleUser.name = 'admin';
                await RoleRepository.save(roleUser);
            }
            return res.status(200).json({message: `Role updated successfully to ${newRole}`});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getInfos(req: ExtendedRequest, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({relations: {role: true}, where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: 'User not found!'});
            }
            const wallet = await AppDataSource.getRepository(Wallet).findOne({where: {user: {auth0UserId: req.user?.userId}}});
            if (!wallet) {
                return res.status(404).json({message: "The wallet not found!"});
            }
            const numberOfUsers = (await AppDataSource.getRepository(User).find({where: {auth0UserId: Not(req.user?.userId)}})).length;
            const amountOfGain = await AppDataSource.getRepository(Invoice)
                .createQueryBuilder("invoice")
                .select("SUM(invoice.amount)", "total")
                .getRawOne();
            const amountOfWithdraw = await AppDataSource.getRepository(Operations)
                .createQueryBuilder("operation")
                .select("SUM(operation.amount)", "total")
                .getRawOne();
            return res.status(200).json({message: 'Information retrived successfully', data: {
                    user,
                    wallet: wallet,
                    numberOfUsers: numberOfUsers,
                    totalAmount: amountOfGain.total - amountOfWithdraw.total
            }});
        } catch (error: any) {
            return res.status(500).json({message: error.message})
        }
    }

    //to get all request of redraw and previous accepted withdraw
    static async getAllTransactionRequest(req: ExtendedRequest, res: Response) {
        try {
            let pendingOperations = await AppDataSource.getRepository(Operations).find({relations: {user: true}, where: {pending: true}});
            const previousOperations = await AppDataSource.getRepository(Operations).find({relations: {user: true}, where: {pending: false}});
            if (pendingOperations) {
                pendingOperations = await Promise.all(pendingOperations.map(async (operation: Operations) => {
                    const reviews = await AppDataSource.getRepository(Reviews).find({
                        where: { user: {auth0UserId: operation.user.auth0UserId} }
                    });
                    const wallet = await AppDataSource.getRepository(Wallet).find({
                        where: {user: {auth0UserId: operation.user.auth0UserId}}
                    })
                    const averageRating = calculateReviewsAverage(reviews);
                    return { ...operation, averageRating: averageRating || 0 , wallet: wallet};
                }));
            }

            return res.status(200).json({message: 'retrieved succussfully!', data: {pendingOperations: pendingOperations, previousOperations: previousOperations}});
        } catch (error: any) {
            return res.status(500).json({message: error.message})
        }
    }

    static async getAllTrips(req: ExtendedRequest, res: Response) {
        try {
            const transactions = await AppDataSource.getRepository(Transaction).find({
                relations: {invoice: true, sender: true, receiver: true},
                order: {
                    id: 'DESC' as const
                },
                take: 20
            });

            return res.status(200).json({message: "Retrieved successfully!", data: transactions});
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }


}