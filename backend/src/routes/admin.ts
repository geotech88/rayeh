import { Router } from 'express';
import { AdminController } from '../controllers/admin.controller';

const adminRouter = Router();

adminRouter.get('/admin/getInfo', AdminController.getInfos);

adminRouter.get('/admin/getPaymenentRequest', AdminController.getAllTransactionRequest);

adminRouter.post('/admin/acceptTransaction', AdminController.acceptPayments);

export { adminRouter };