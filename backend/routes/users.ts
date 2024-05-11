import { Response, Router, NextFunction } from 'express';
import { UserController } from '../controllers/user.controller';

const usersRouter = Router();

usersRouter.get('/api/users/', UserController.getAllUsers);

usersRouter.get('/api/users/me', UserController.getMyInfo);

usersRouter.get('/api/users/:id', UserController.getUser);

usersRouter.patch('/api/users/update/all', UserController.updateUserInfo);

usersRouter.patch('/api/users/update/password', UserController.changePassword)

usersRouter.patch('/api/users/photo', UserController.changePhoto);

usersRouter.delete('/api/users/delete', UserController.deleteUser);

export { usersRouter };