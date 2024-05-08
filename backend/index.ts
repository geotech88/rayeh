import 'reflect-metadata';
require('dotenv').config();
import express from 'express';
import cors from 'cors';
import { auth } from 'express-openid-connect';
import { requestRouter, router, usersRouter, offerRouter, invoiceRouter, walletRouter, walletLogsRouter } from './routes/routes';
import { config } from './config/auth-config';
import { AppDataSource } from './config/ormconfig';


AppDataSource.initialize().then(async () => {
    const app = express();
    app.use(express.json());

    // app.use(cors());

    app.use(auth(config));
    app.use(express.json());
    // app.use(express.urlencoded({ extended: true }));
    app.use(router);
    app.use(usersRouter);
    app.use(offerRouter);
    app.use(requestRouter);
    app.use(invoiceRouter);
    app.use(walletRouter);
    app.use(walletLogsRouter);

    app.listen(process.env.PORT || 3000, () => {
        console.log(`Server is running on port ${process.env.PORT || 3000}`);
    });
}).catch((err) => {
    console.error('Error while initializing the app:', err);
});
