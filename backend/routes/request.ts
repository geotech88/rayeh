import { Response, Router, NextFunction } from 'express';
import { RequestController } from '../controllers/request.controller';

const requestRouter = Router();

requestRouter.post('/api/request/', RequestController.createRequest);

requestRouter.delete('/api/request/delete/:id', RequestController.deleteRequest);

export { requestRouter };