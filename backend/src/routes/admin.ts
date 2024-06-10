import { Router } from 'express';
import { AdminController } from '../controllers/admin.controller';

const adminRouter = Router();

adminRouter.get('/admin/getInfo', AdminController.getInfos);

adminRouter.get('/admin/getAllTrips', AdminController.getAllTrips);

adminRouter.patch('/admin/updateRole', AdminController.updateRole);

adminRouter.get('/admin/getPaymentRequest', AdminController.getAllTransactionRequest);

adminRouter.post('/admin/acceptTransaction', AdminController.acceptPayments);

export { adminRouter };
