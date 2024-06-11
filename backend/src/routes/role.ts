import { Response, Router, NextFunction } from 'express';
import { RoleController } from '../controllers/role.controller';

const roleRouter = Router();

roleRouter.get('/checkRole/role', RoleController.getRole);

export { roleRouter };