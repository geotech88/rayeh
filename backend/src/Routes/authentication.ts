import { Router } from 'express';
import { AuthenticationController } from '../controllers/authentication.controller';

const authRouter = Router();

authRouter.post('/auth', AuthenticationController.addUser);

export { authRouter };