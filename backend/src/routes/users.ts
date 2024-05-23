import { Router } from 'express';
// import multer from 'multer';
import { UserController } from '../controllers/user.controller';

const usersRouter = Router();
// const upload = multer();


usersRouter.get('/api/users', UserController.getAllUsers);

usersRouter.get('/api/users/me', UserController.getMyInfo);

usersRouter.get('/api/users/:id', UserController.getUser);

usersRouter.patch('/api/users/update/all', UserController.updateUserInfo);

usersRouter.patch('/api/users/update/password', UserController.changePassword);

// usersRouter.post('/api/users/photo', upload.single('file'), UserController.changePhoto);

usersRouter.delete('/api/users/delete', UserController.deleteUser);

export { usersRouter };