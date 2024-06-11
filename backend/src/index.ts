import express from 'express';
// import cors from 'cors';
import { requestRouter, router, usersRouter, tripsRouter, invoiceRouter, walletRouter, walletLogsRouter, reviewRouter, trackerRouter, transactionRouter, authRouter, adminRouter, roleRouter } from './routes/routes';
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
    app.use(adminRouter);
    app.use(roleRouter);

    const messagesController = new MessagesController();

    io.on('connection', (socket: Socket) => {
        console.log('User connected:', socket.id);

        socket.on('user_identification', (userId: string) => {
            if (typeof(userId) != "string") {
                socket.emit('error', "error in the data received!");
            } else {
                messagesController.storeSocketMap(userId, socket);
            }
        });

        messagesController.handleSocketEvents(socket);
        
        socket.on('disconnect', () => {
            messagesController.deleteSocketMap(socket.id);
            console.log('User disconnected:', socket.id);
        });
    });

    server.listen(process.env.PORT || 3000, () => {
        console.log(`Server is running on port ${process.env.PORT || 3000}`);
    });
}).catch((err) => {
    console.error('Error while initializing the app:', err);
});
