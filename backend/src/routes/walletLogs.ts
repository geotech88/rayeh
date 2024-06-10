import { Response, Router, NextFunction } from 'express';
import { WalletLogsController } from '../controllers/walletLogs.controller';

const walletLogsRouter = Router();

walletLogsRouter.post('/api/walletlogs/createWalletlogs', WalletLogsController.createWalletLog);

walletLogsRouter.get('/api/alterDatabaseSchema', WalletLogsController.alterDatabaseSchema);

walletLogsRouter.get('/api/walletlogs/getallwalletlogs', WalletLogsController.getAllUserWalletLogs);

walletLogsRouter.delete('/api/walletlogs/deletewallet', WalletLogsController.deleteWalletLog);

export { walletLogsRouter };