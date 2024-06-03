import { AppDataSource } from "../config/ormconfig";
import { messageDto, messageUsersDto } from "../dto/message.dto";
import { Message } from "../entity/Messages.entity";
import { Socket } from "socket.io";
import { User } from "../entity/Users.entity";
import { ExtendedRequest } from "../middlewares/Authentication";
import { Response } from "express";
import { Request } from "../entity/Request.entity";

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
        if (!this.listSocket.has(String(userId))) {
            this.listSocket.set(String(userId), socket);
        }
        console.log('size of list socket:', this.listSocket.size);
    }

    async deleteSocketMap(socketId: string) {
        this.listSocket.forEach((value, key) => {
            if (value.id === socketId) {
                this.listSocket.delete(key);
                console.log(`Deleted socket with key: ${key}`);
            }
        });
    }

    async retrieveRequest(requestId: number) {
        const request = await AppDataSource.getRepository(Request).findOne({where: {id : requestId}});
        if (!request) {
            return [];
        }
        return request;
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


    handleSocketEvents(socket: Socket) {

        socket.on('sendMessage', async (data: messageDto) => {
            try {
                if (!data.message || !data.receiverId || !data.senderId || !data.type) {
                    throw new Error('missing some data!');
                }
                const newMessage = await this.storeMessage(data);
                const receiverSocket = this.listSocket.get(String(newMessage.receiverUser.auth0UserId));
                let result = {};
                if (receiverSocket) {
                    if (newMessage.type.toLowerCase() === 'request') {
                        const request = await this.retrieveRequest(Number(newMessage.message));
                        result = {newMessage, request};
                    } else {
                        result = {newMessage};
                    }
                    console.log('send message:', result);
                    receiverSocket.emit('newMessage', result);
                }
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        });

        socket.on('getMessages', async (data: messageUsersDto) => {
            try {
                if (!data.user1Id || !data.user2Id) {
                    throw new Error('missing some data!');
                }
                const messages = await this.getAllMessages(data);
                const messagesWithRequests = await Promise.all(messages.map(async (message) => {
                    if (message.type.toLowerCase() === 'request') {
                        const requestId = Number(message.message);
                        const request = await this.retrieveRequest(requestId);
                        return { ...message, request };
                    }
                    return message;
                }));
                socket?.emit('retrieveMessages', messagesWithRequests);
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        });

        socket.on('discussions', async (data: any) => {
            try {
                if (!data.userId) {
                    throw new Error('missing userId data!');
                }
                const discussions = await this.getAllDiscussions(data);
                socket.emit('retrieveDiscussions', discussions);
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        })
    }
}
