import { Router } from 'express';
import { AdminController } from '../controllers/admin.controller';

const adminRouter = Router();

adminRouter.get('/api/admin/getInfo', AdminController.getInfos);

adminRouter.get('/api/admin/getPaymenentRequest', AdminController.getAllTransactionRequest);

adminRouter.post('/api/admin/acceptTransaction', AdminController.acceptPayments);

export { adminRouter };