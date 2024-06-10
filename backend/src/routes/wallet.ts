import { Response, Router, NextFunction } from 'express';
import { WalletController } from '../controllers/wallet.controller';

const walletRouter = Router();

walletRouter.get('/api/wallet/info', WalletController.getWallet);

walletRouter.post('/api/wallet/withdraw', WalletController.createwithdraw);

walletRouter.post('/api/wallet/payment', WalletController.payment);

walletRouter.post('/api/wallet/payment/visaMasterCard/callback', WalletController.paymentCallbackVisaMasterCard);

walletRouter.post('/api/wallet/payment/MADA/callback', WalletController.paymentCallbackMADA);

walletRouter.patch('/api/wallet/updatebalance/:id', WalletController.updateWalletBalance);

walletRouter.patch('/api/wallet/updatecurrency/:id', WalletController.updateWalletCurrency);

export { walletRouter };