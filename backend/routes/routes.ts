import { Router, NextFunction, Response } from 'express';
import { checkIsLoggedIn, ExtendedRequest } from '../middlewares/Authentication';
import { usersRouter } from './users';
import { AppDataSource } from '../config/ormconfig';
import { User } from '../entity/Users.entity';
import { Role } from '../entity/Roles.entity';
import { authorized } from '../middlewares/Authorization';
import { offerRouter } from './offers';
import { requestRouter } from './request';
import { invoiceRouter } from './invoices';
import { WalletController } from '../controllers/wallet.controller';
import { walletRouter } from './wallet';
import { walletLogsRouter } from './walletLogs';

const router = Router();

const checkOnDatabase = async (req: ExtendedRequest , res: Response, next: NextFunction) => {
    const UserRepository = AppDataSource.getRepository(User);
    const findUser = await UserRepository.findOne({where: {email: req.user?.email}});
    if (!findUser) {
        const user = new User();
        const RoleRepository = AppDataSource.getRepository(Role);
        const roleUser = new Role();
        roleUser.name = 'user';
        await RoleRepository.save(roleUser);
        user.name = req.user?.name as string;
        user.email = req.user?.email as string;
        user.auth0UserId = req.user?.sub as string;
        user.path = req.user?.picture as string;
        user.role = roleUser;
        await UserRepository.save(user);
        await WalletController.createWallet(req, res);
    }
    next();
}

router.get('/', (req, res) => {
    res.send("Welcome in the backend part");
});

// router.get('/callback', checkOnDatabase); //will use later, when https domain is set
router.get('/callback', (req, res, next) => {
    console.log('Welcome in the callback function');
})

router.use('/api', checkIsLoggedIn, 
        checkOnDatabase, //temporary solution, until https domain is set to use the callback instead
        authorized(['user', 'admin']));


export { router, usersRouter, requestRouter, offerRouter, invoiceRouter, walletRouter, walletLogsRouter };