import { Response, Router, NextFunction } from 'express';
import { RequestController } from '../controllers/request.controller';

const requestRouter = Router();

requestRouter.get('/api/request/', RequestController.createRequest);

requestRouter.delete('/api/request/delete', RequestController.deleteRequest);

export { requestRouter };