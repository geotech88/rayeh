import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Wallet } from "../entity/Wallet.entity";
import { conversionCurrency } from "../helpers/helpers";
import { Operations } from "../entity/Operations.entity";
require('dotenv').config();

const HYPERPAY_URL = process.env.HYPERPAY_URL;
const HYPERPAY_ENTITY_VISA_MASTERCARD_ID = process.env.HYPERPAY_ENTITY_VISA_MASTERCARD;
const HYPERPAY_ENTITY_MADA_ID = process.env.HYPERPAY_ENTITY_MADA;
const HYPERPAY_AUTH_TOKEN = process.env.HYERPAY_AUTH_TOKEN;

export class WalletController {
    static async createWallet(userInfo: User) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId:  userInfo?.auth0UserId}});
            if (!user) {
                return {message: "User not found"};
            }
            const WalletRepository = AppDataSource.getRepository(Wallet);
            const wallet = new Wallet();
            wallet.user = user;
            await WalletRepository.save(wallet);
            return {message: "Wallet created!", data: wallet};
        } catch(error: any) {
            return {error: error.message};
        }
    }

    static async createRedraw(req: ExtendedRequest, res: Response) {
        try {
            const { amount, accountNumber } = req.body;
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.userId}});
            if (!amount || !accountNumber) {
                return res.status(400).json({message: "Missing parameters in the request!"});
            }
            if (!user) {
                return res.status(404).json({message: "User not found!"});
            }
            const redraw = new Operations();
            redraw.amount = Number(amount);
            redraw.accountNumber = accountNumber.toString();
            redraw.user = user;
            await AppDataSource.getRepository(Operations).save(redraw);
            return redraw;
        } catch (error: any) {
            return res.status(500).json({message: error.message});
        }
    }

    static async payment(req: ExtendedRequest, res: Response) {
        try {
            const { amount, currency, paymentType } = req.body;
            const WalletRepository = AppDataSource.getRepository(Wallet);
            const wallet = await WalletRepository.findOne({where: { user: { auth0UserId: req.user?.userId }}});
            if (!amount || !currency || !paymentType) {
                return res.status(400).json({message: "Missing parameters in the request!"});
            }
            console.log('the payment method:', HYPERPAY_ENTITY_MADA_ID )
            if (!wallet) {
                return res.status(404).json({message: 'Wallet not found'});
            }
            let entityId = '';

            if (paymentType === 'VISA_MASTERCARD') {
                entityId = HYPERPAY_ENTITY_VISA_MASTERCARD_ID || "";
            } else if (paymentType === 'MADA') {
                entityId = HYPERPAY_ENTITY_MADA_ID || "";
            } else {
                return res.status(400).json({ message: 'Invalid payment type' });
            }
            const response = await fetch(`${HYPERPAY_URL}/v1/checkouts`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${HYPERPAY_AUTH_TOKEN}`,
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    entityId: entityId,
                    amount: amount.toString(),
                    currency: currency,
                    paymentType: 'DB'
                })
            });
            
            const data = await response.json();
            if (!response.ok) {
                return res.status(response.status).json({ message: data.result });
            }

            const checkoutId = data.id;

            return res.json({
                checkoutId,
                paymentUrl: `${HYPERPAY_URL}/v1/paymentWidgets.js?checkoutId=${checkoutId}`
            });
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async paymentCallbackVisaMasterCard(req: ExtendedRequest, res: Response) {
        try {
            const { id, resourcePath } = req.body;
            const response = await fetch(`${HYPERPAY_URL}${resourcePath}?entityId=${HYPERPAY_ENTITY_VISA_MASTERCARD_ID}`, {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${HYPERPAY_AUTH_TOKEN}`
                }
            });

            const data = await response.json();

            if (!response.ok) {
                return res.status(response.status).json({ message: data.result.description });
            }

            const paymentStatus = data.result.code;

            if (paymentStatus === '000.000.000' || paymentStatus === '000.000.100') {
                const walletRepository = AppDataSource.getRepository(Wallet);
                const wallet = await walletRepository.findOne({ where: { user: { auth0UserId: id } } });

                if (!wallet) {
                    return res.status(404).json({ message: 'Wallet not found' });
                }

                wallet.balance += parseFloat(data.amount);
                await walletRepository.save(wallet);

                return res.json({ message: 'Payment successful' });
            } else {
                return res.status(400).json({ message: 'Payment failed', details: data.result.description });
            }

        } catch (error) {
            console.error(error);
            return res.status(500).json({ message: 'Internal server error' });
        }
    }

    static async paymentCallbackMADA(req: ExtendedRequest, res: Response) {
        try {
            const { id, resourcePath } = req.body;
            const response = await fetch(`${HYPERPAY_URL}${resourcePath}?entityId=${HYPERPAY_ENTITY_MADA_ID}`, {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${HYPERPAY_AUTH_TOKEN}`
                }
            });

            const data = await response.json();

            if (!response.ok) {
                return res.status(response.status).json({ message: data.result.description });
            }

            const paymentStatus = data.result.code;

            if (paymentStatus === '000.000.000' || paymentStatus === '000.000.100') {
                const walletRepository = AppDataSource.getRepository(Wallet);
                const wallet = await walletRepository.findOne({ where: { user: { auth0UserId: id } } });

                if (!wallet) {
                    return res.status(404).json({ message: 'Wallet not found' });
                }

                wallet.balance += parseFloat(data.amount);
                await walletRepository.save(wallet);

                return res.json({ message: 'Payment successful' });
            } else {
                return res.status(400).json({ message: 'Payment failed', details: data.result.description });
            }

        } catch (error) {
            console.error(error);
            return res.status(500).json({ message: 'Internal server error' });
        }
    }

    static async getWallet(req: ExtendedRequest, res: Response) {
        try {
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const wallet = await AppDataSource.getRepository(Wallet).findOne({where: {user: {auth0UserId: req.user?.userId}}});
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
            const { balance, type } = req.body;
            const wallet = await AppDataSource.getRepository(Wallet).findOne({where: {id: Number(req.params.id)}});
            if (!wallet) {
                return res.status(404).json({message: "Wallet not found"});
            }
            if (type.toLowerCase() === "credit") {
                wallet.balance = balance + Number(wallet.balance);
            } else if (type.toLowerCase() === "debit") {
                wallet.balance =  Number(wallet.balance) - balance;
            }
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
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.userId}});
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