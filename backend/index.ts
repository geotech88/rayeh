import 'reflect-metadata';
import dotenv from 'dotenv';
import express from 'express';
import { auth } from 'express-openid-connect';
import { requestRouter, router, usersRouter, tripsRouter, invoiceRouter, walletRouter, walletLogsRouter, reviewRouter, trackerRouter, transactionRouter } from './Routes/routes';
import { config } from './config/auth-config';
import { AppDataSource } from './config/ormconfig';
// import http from 'http';
// import { Server as SocketIOServer, Socket } from 'socket.io';
// import { MessagesController } from './controllers/messages.controller';

dotenv.config();

AppDataSource.initialize().then(async () => {
    const app = express();
    // const server = http.createServer(app);
    // const io = new SocketIOServer(server, {
    //     cors: {
    //         origin: 'http://localhost:3000',
    //         methods: ['GET', 'POST'],
    //     }
    // });
    app.use(express.json());

    // app.use(cors());

    app.use(auth(config));
    app.use(express.json());
    // app.use(express.urlencoded({ extended: true }));
    app.use(router);
    app.use(usersRouter);
    app.use(tripsRouter);
    app.use(requestRouter);
    app.use(invoiceRouter);
    app.use(walletRouter);
    app.use(walletLogsRouter);
    app.use(reviewRouter);
    app.use(trackerRouter);
    app.use(transactionRouter);

    // const messagesController = new MessagesController();
    // const listSocket: Map<string, Socket> = new Map<string, Socket>();

    // io.use((socket: Socket, next: any) => {
    //     const request = socket.request;
    //     if (request?.oidc) {
    //         listSocket.set(socket.id, socket);
    //     }
    //     next();
    // });

    // io.on('connection', (socket: Socket) => {
    //     console.log('User connected:', socket.id);

    //     socket.on('user_identification', (userId: string) => {
    //         listSocket.set(userId, socket);
    //     });

    //     messagesController.handleSocketEvents(socket, listSocket);
        
    //     socket.on('disconnect', () => {
    //         console.log('User disconnected:', socket.id);
    //     });
    // });

    app.listen(process.env.PORT || 3000, () => {
        console.log(`Server is running on port ${process.env.PORT || 3000}`);
    });
}).catch((err) => {
    console.error('Error while initializing the app:', err);
});
