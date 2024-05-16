import { Response, Router, NextFunction } from 'express';
import { WalletController } from '../controllers/wallet.controller';

const walletRouter = Router();

walletRouter.get('/api/wallet/info', WalletController.getWallet);

walletRouter.patch('/api/wallet/updatebalance/:id', WalletController.updateWalletBalance);

walletRouter.patch('/api/wallet/updatecurrency/:id', WalletController.updateWalletCurrency);

export { walletRouter };