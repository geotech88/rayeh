import { Response, Router, NextFunction } from 'express';
import { UserController } from '../controllers/user.controller';

const usersRouter = Router();

usersRouter.get('/api/users/', UserController.getAllUsers);

usersRouter.get('/api/users/me', UserController.getMyInfo);

usersRouter.get('/api/users/:id', UserController.getUser);

usersRouter.post('/api/users/update', UserController.updateUserInfo);

usersRouter.delete('/api/users/delete', UserController.deleteUser);

export { usersRouter };