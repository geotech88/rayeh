import { Response, Router, NextFunction } from 'express';
import { WalletController } from '../controllers/wallet.controller';

const walletRouter = Router();

walletRouter.post('/api/wallet/updatebalance/:id', WalletController.updateWalletBalance);

walletRouter.post('/api/wallet/updatecurrency/:id', WalletController.updateWalletCurrency);

export { walletRouter };