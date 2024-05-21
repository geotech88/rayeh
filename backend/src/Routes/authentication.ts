import { Router } from 'express';
import { AuthenticationController } from '../controllers/authentication.controller';

const authRouter = Router();

authRouter.post('/api/auth', AuthenticationController.addUser);

export { authRouter };