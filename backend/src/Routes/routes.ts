import { Router, NextFunction, Response } from 'express';
import { checkIsLoggedIn, ExtendedRequest } from '../middlewares/Authentication';
import { usersRouter } from './users';
import { AppDataSource } from '../config/ormconfig';
import { User } from '../entity/Users.entity';
import { authorized } from '../middlewares/Authorization';
import { tripsRouter } from './trips';
import { requestRouter } from './request';
import { invoiceRouter } from './invoices';
import { walletRouter } from './wallet';
import { walletLogsRouter } from './walletLogs';
import { reviewRouter } from './reviews';
import { trackerRouter } from './tracker';
import { transactionRouter } from './transactions';
import { authRouter } from './authentication';

const router = Router();

const checkOnDatabase = async (req: ExtendedRequest , res: Response, next: NextFunction) => {
    try {
        const UserRepository = AppDataSource.getRepository(User);
        const findUser = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
        if (!findUser) {
            return res.status(403).json({message: 'the user is not authenticated in server'});
        }
        next();
    } catch (err: any) {
        return res.status(403).json({message: 'the user is not authenticated in server'});
    }
}

router.get('/', (req, res) => {
    res.send("Welcome in the backend part");
});

router.use('/api/admin', authorized(['admin']));

router.use('/api', checkIsLoggedIn, 
        checkOnDatabase, //temporary solution, until https domain is set to use the callback instead
        authorized(['user', 'admin']));


export { router, usersRouter, requestRouter, tripsRouter, invoiceRouter, walletRouter, walletLogsRouter, reviewRouter, trackerRouter, transactionRouter, authRouter  };