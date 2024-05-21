import { Router, NextFunction, Response } from 'express';
import { checkIsLoggedIn, ExtendedRequest } from '../middlewares/Authentication';
import { usersRouter } from './users';
import { AppDataSource } from '../config/ormconfig';
import { User } from '../entity/Users.entity';
import { Role } from '../entity/Roles.entity';
import { authorized } from '../middlewares/Authorization';
import { tripsRouter } from './trips';
import { requestRouter } from './request';
import { invoiceRouter } from './invoices';
import { WalletController } from '../controllers/wallet.controller';
import { walletRouter } from './wallet';
import { walletLogsRouter } from './walletLogs';
import { reviewRouter } from './reviews';
import { trackerRouter } from './tracker';
import { transactionRouter } from './transactions';
import { authRouter } from './authentication';

const router = Router();

const checkOnDatabase = async (req: ExtendedRequest , res: Response, next: NextFunction) => {
    const UserRepository = AppDataSource.getRepository(User);
    const findUser = await UserRepository.findOne({where: {auth0UserId: req.user?.sub}});
    if (!findUser) {
        return res.status(403).json({message: 'the user is not authenticated in backend'});
    }
    next();
}

router.get('/', (req, res) => {
    res.send("Welcome in the backend part");
});

router.use('/api/admin', authorized(['admin']))

router.use('/api', checkIsLoggedIn, 
        checkOnDatabase, //temporary solution, until https domain is set to use the callback instead
        authorized(['user', 'admin']));


export { router, usersRouter, requestRouter, tripsRouter, invoiceRouter, walletRouter, walletLogsRouter, reviewRouter, trackerRouter, transactionRouter, authRouter  };