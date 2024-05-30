import express from 'express';
// import cors from 'cors';
import { auth } from 'express-openid-connect';
import { requestRouter, router, usersRouter, tripsRouter, invoiceRouter, walletRouter, walletLogsRouter, reviewRouter, trackerRouter, transactionRouter, authRouter } from './routes/routes';
// import { config } from './config/auth-config';
import { AppDataSource } from './config/ormconfig';
import http from 'http';
import { Server as SocketIOServer, Socket } from 'socket.io';
import { MessagesController } from './controllers/messages.controller';

AppDataSource.initialize().then(async () => {
    const app = express();
    const server = http.createServer(app);
    const io = new SocketIOServer(server, {
        cors: {
            origin: '*',
            methods: ['GET', 'POST'],
            credentials: true
        },
    });
    app.use(express.json());

    // app.use(cors());

    // app.use(auth(config));
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
    app.use(authRouter);

    const messagesController = new MessagesController();
    const listSocket: Map<string, Socket> = new Map<string, Socket>();

    // io.use((socket: Socket, next: any) => {
    //     const request = socket.request;
    //     if (request?.oidc) {
    //         listSocket.set(socket.id, socket);
    //     }
    //     next();
    // });

    io.on('connection', (socket: Socket) => {
        console.log('User connected:', socket.id);

        socket.on('user_identification', (userId: string) => {
            console.log('user id:', userId);
            //check if the userId is already set with this socket id
            // listSocket.set(userId, socket);
            messagesController.storeSocketMap(userId, socket);
        });

        messagesController.handleSocketEvents(socket, listSocket);
        
        socket.on('disconnect', () => {
            const deleteByValue = (targetValue: string) => {
                const keysToDelete: string[] = [];
              
                listSocket.forEach((value, key) => {
                  if (value.id === targetValue) {
                    keysToDelete.push(key);
                  }
                });
              
                keysToDelete.forEach(key => {
                    listSocket.delete(key);
                });
            };
            deleteByValue(socket.id);
            console.log('User disconnected:', socket.id);
        });
    });

    server.listen(process.env.PORT || 3000, () => {
        console.log(`Server is running on port ${process.env.PORT || 3000}`);
    });
}).catch((err) => {
    console.error('Error while initializing the app:', err);
});
