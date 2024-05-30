import { AppDataSource } from "../config/ormconfig";
import { messageDto, messageUsersDto } from "../dto/message.dto";
import { Message } from "../entity/Messages.entity";
import { Socket } from "socket.io";
import { User } from "../entity/Users.entity";
import { ExtendedRequest } from "../middlewares/Authentication";
import { Response } from "express";

export class MessagesController {
    private listSocket: Map<string, Socket> = new Map<string, Socket>();
    // static async createMessage(req: ExtendedRequest, res: Response){
    //     try {
    //         const {senderId, receiverId, message, type} = req.body;
    //         const senderUser = await AppDataSource.getRepository(User).findOneBy({ auth0UserId: senderId });
    //         const receiverUser = await AppDataSource.getRepository(User).findOneBy({ auth0UserId: receiverId });
    //         if (!senderUser || !receiverUser) {
    //             return res.status(500).send({message: 'User not found'});
    //         }
    //         console.log({senderId, receiverId, message, type})
    //         const newMessage = new Message();
    //         newMessage.senderUser = senderUser;
    //         newMessage.receiverUser = receiverUser;
    //         newMessage.message = message;
    //         newMessage.type = type;
    //         await AppDataSource.getRepository(Message).save(newMessage);
    //         return res.status(200).send({message: 'message stored', data: newMessage});
    //     } catch (error: any) {
    //         return res.status(500).send({message: 'Failed to store message in database'});
    //     }
    // }

    async storeSocketMap(userId:string, socket: Socket) {
        this.listSocket.set(String(userId), socket);
        console.log('counter:', this.listSocket.size);
    }

    async storeMessage(message: messageDto): Promise<Message> {
        try {
            const senderUser = await AppDataSource.getRepository(User).findOneBy({ auth0UserId: message.senderId });
            const receiverUser = await AppDataSource.getRepository(User).findOneBy({ auth0UserId: message.receiverId });
            if (!senderUser || !receiverUser) {
                throw new Error('User not found');
            }
            const newMessage = new Message();
            newMessage.senderUser = senderUser;
            newMessage.receiverUser = receiverUser;
            newMessage.message = message.message;
            newMessage.type = message.type;
            await AppDataSource.getRepository(Message).save(newMessage);
            return newMessage;
        } catch (error: any) {
            throw new Error('Failed to store message in database');
        }
    }

    async getAllMessages(messageUsers: messageUsersDto): Promise<Message[]> {

        try {
            const queryCriteria = {
                relation: {senderUser: true, receiverUser: true},
                where: [
                    {senderUser: {auth0UserId: messageUsers.user1Id}, receiverUser: {auth0UserId: messageUsers.user2Id}},
                    {senderUser: {auth0UserId: messageUsers.user2Id}, receiverUser: {auth0UserId: messageUsers.user1Id}},
                ],
                order: {
                    createdAt: 'ASC' as const,
                }
            };
            return await AppDataSource.getRepository(Message).find(queryCriteria);
        } catch (error: any) {
            throw new Error('Failed to retrieve messages from database');
        }
    }

    async getAllDiscussions(data: any) {
        const messages = await AppDataSource.getRepository(Message).find({
            where: [
                { senderUser: { auth0UserId: data.userId } },
                { receiverUser: { auth0UserId: data.userId } }
            ],
            order: {
                createdAt: 'ASC' as const,
            },
            relations: ['senderUser', 'receiverUser']
        });

        const lastMessages = messages.reduce((acc:any, message:any) => {
            const key = message.senderUser.auth0UserId < message.receiverUser.auth0UserId ?
                `${message.senderUser.auth0UserId}-${message.receiverUser.auth0UserId}` :
                `${message.receiverUser.auth0UserId}-${message.senderUser.auth0UserId}`;

            if (!acc.has(key) || acc.get(key).createdAt < message.createdAt) {
                acc.set(key, message);
            }

            return acc;
        }, new Map<string, Message>());

        return Array.from(lastMessages.values());
    }


    handleSocketEvents(socket: Socket, listSocket: Map<string, Socket>) {
        socket.on('sendMessage', async (data: messageDto) => {
            const newMessage = await this.storeMessage(data);
            const receiverSocket = this.listSocket.get(String(newMessage.receiverUser.auth0UserId));
            if (receiverSocket) {
                receiverSocket.emit('newMessage', newMessage);
            } else {
                socket.emit('error', `No socket found for userId: ${newMessage.receiverUser.auth0UserId}`);
            }
        });

        socket.on('getMessages', async (data: messageUsersDto) => {
            try {
                const messages = await this.getAllMessages(data);
                socket?.emit('retrieveMessages', messages);
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        });

        socket.on('discussions', async (data: any) => {
            try {
                const discussions = await this.getAllDiscussions(data);
                socket.emit('retrieveDiscussions', discussions);
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        })
    }
}
