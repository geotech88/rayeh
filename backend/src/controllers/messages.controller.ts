import { AppDataSource } from "../config/ormconfig";
import { messageDto, messageUsersDto } from "../dto/message.dto";
import { Message } from "../entity/Messages.entity";
import { Socket } from "socket.io";
import { User } from "../entity/Users.entity";
import { ExtendedRequest } from "../middlewares/Authentication";
import { Response } from "express";
import { Request } from "../entity/Request.entity";
import { Conversation } from "../entity/Conversation.entity";
import { Trips } from "../entity/Trips.entity";

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

    async retrieveRequest(messageId: number) {
        const request = await AppDataSource.getRepository(Request).findOne({where: {message: { id: messageId } }});
        if (!request) {
            return [];
        }
        return request;
    }

    async retrieveLastTrip(tripId: number) {
        try {
            const trip = await AppDataSource.getRepository(Trips).findOne({where: {id: tripId}});
            return trip;
        } catch(error:any) {
            throw new Error("Something wrong in retrieving the last trip!");
        }
    }

    async storeMessage(message: messageDto): Promise<any> {
        try {
            if (message.senderId === message.receiverId) {
                throw new Error('Should not be the same user');
            }
            if (!message.type || (!message.message && message.type.toLowerCase() !== "request")) {
                throw new Error("Something wrong with the received data");
            }
            const senderUser = await AppDataSource.getRepository(User).findOneBy({ auth0UserId: message.senderId });
            const receiverUser = await AppDataSource.getRepository(User).findOneBy({ auth0UserId: message.receiverId });
            if (!senderUser || !receiverUser) {
                throw new Error('User not found');
            }
            let getConversation = await AppDataSource.getRepository(Conversation).findOne({relations: ['receiverUser' , 'senderUser', 'messages', 'trips'], where: [{senderUser: {auth0UserId: senderUser?.auth0UserId}, receiverUser: {auth0UserId: receiverUser?.auth0UserId}},
                                                                                                    {senderUser: {auth0UserId: receiverUser?.auth0UserId}, receiverUser: {auth0UserId: senderUser?.auth0UserId}}
                                                                                            ]});
            const Trip = await AppDataSource.getRepository(Trips).findOne({where: {id: message.tripId}});
            if (!Trip) {
                throw new Error('The trip is not available');
            }
            if (!getConversation) {
                getConversation = new Conversation();
                getConversation.senderUser = senderUser;
                getConversation.receiverUser = receiverUser;
                getConversation.trips = [];
                getConversation.messages = [];
            }
            getConversation.lastTripId = message.tripId;
            const tripExists = getConversation.trips.some(trip => trip.id === Trip.id);
            if (!tripExists) {
                getConversation.trips.push(Trip);
            }
            if (message.type.toLowerCase() !== 'request') {
                const newMessage = new Message();
                newMessage.message = message.message;
                newMessage.type = message.type;
                newMessage.user = senderUser;
                await AppDataSource.getRepository(Message).save(newMessage);
                getConversation.messages.push(newMessage);
                await AppDataSource.getRepository(Conversation).save(getConversation);
                return {newMessage: newMessage, conversation: getConversation};
            }
            const newMessage = await AppDataSource.getRepository(Message).findOne({relations: { request: true, user: true }, where: {request: {id: message.requestId}}});
            if (!newMessage) {
                throw new Error('Request not available');
            }
            return {newMessage: newMessage, conversation: getConversation};
        } catch (error: any) {
            throw new Error(`Failed to store message in database: ${error.message}`);
        }
    }

    async getAllMessages(messageUsers: messageUsersDto): Promise<Conversation> {

        try {
            let getConversation = await AppDataSource.getRepository(Conversation).findOne({relations: {messages: {user: true}, senderUser: true, receiverUser: true}, where: [{senderUser: {auth0UserId: messageUsers.user1Id}, receiverUser: {auth0UserId: messageUsers.user2Id}},
                                                                                            {senderUser: {auth0UserId: messageUsers.user2Id}, receiverUser: {auth0UserId: messageUsers.user1Id}}
                                                                                    ]});
            return getConversation as Conversation;
        } catch (error: any) {
            throw new Error(`Failed to retrieve messages from database: ${error.message}`);
        }
    }

    async removeMessages(messageUsers: messageUsersDto): Promise<void> {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const requestRepository = AppDataSource.getRepository(Request);
            const messageRepository = AppDataSource.getRepository(Message);
            const user1 = await UserRepository.findOne({where: {auth0UserId: messageUsers.user1Id}});
            const user2 = await UserRepository.findOne({where: {auth0UserId: messageUsers.user2Id}});
            if (user1?.auth0UserId !== messageUsers.user1Id || user2?.auth0UserId !== messageUsers.user2Id) {
                throw new Error('user not available!');
            }
            const conversation = await AppDataSource.getRepository(Conversation).findOne({
                where: [
                    {senderUser: {auth0UserId: messageUsers.user1Id}, receiverUser: {auth0UserId: messageUsers.user2Id}},
                    {senderUser: {auth0UserId: messageUsers.user2Id}, receiverUser: {auth0UserId: messageUsers.user1Id}}
                ],
                relations: {messages: true}
            })
            if (!conversation) {
                throw new Error('conversation not available');
            }
            for (const message of conversation.messages) {
                // If message type is 'request', delete related requests
                if (message.type === 'request') {
                    await requestRepository.createQueryBuilder()
                        .delete()
                        .where("messageId = :messageId", { messageId: message.id })
                        .execute();
                }
            }
            await messageRepository.createQueryBuilder()
                .delete()
                .where("conversationId = :conversationId", { conversationId: conversation.id })
                .execute();
        } catch (error: any) {
            throw new Error(`Failed to remove message in database: ${error.message}`);
        }
    }

    async getAllDiscussions(data: any) {
        try {
            let getDiscussions = await AppDataSource.getRepository(Conversation).find({relations: ['senderUser', 'receiverUser', 'trips'],
                                                                                where: [{senderUser: {auth0UserId: data.userId}},
                                                                                        {receiverUser: {auth0UserId: data.userId}}
                                                                                ],
                                                                                order: {createdAt: 'ASC' as const}
                                                                            });
            for (let conversation of getDiscussions) {
                const latestMessage = await AppDataSource.getRepository(Message).findOne({
                    relations: {user: true},
                    where: { conversation: { id: conversation.id } },
                    order: { createdAt: 'DESC' }
                });
                conversation.messages = latestMessage ? [latestMessage] : [];
                const lastTrip = await AppDataSource.getRepository(Trips).findOne({
                    where: { id: conversation.lastTripId }
                });
                conversation.trips = lastTrip ? [lastTrip] : [];
            }
            return getDiscussions;
        } catch (error: any) {
            throw new Error(`Failed to get all discussion: ${error.message}`);
        }
    }


    handleSocketEvents(socket: Socket) {

        socket.on('sendMessage', async (data: messageDto) => {
            try {
                if (!data.receiverId || !data.senderId || !data.type || !data.tripId) {
                    throw new Error('missing some data!');
                }
                const {newMessage, conversation}  = await this.storeMessage(data);
                let receiverSocket = this.listSocket.get(String(conversation.receiverUser.auth0UserId));
                if (receiverSocket === socket) {
                    receiverSocket = this.listSocket.get(String(conversation.senderUser.auth0UserId));
                }
                let result = {};
                if (receiverSocket) {
                    result = {newMessage, conversation_id: conversation.id};
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
                const conversation = await this.getAllMessages(data);
                const messagesWithRequests = await Promise.all(conversation.messages.map(async (message) => {
                    if (message.type.toLowerCase() === 'request') {
                        const messageId = Number(message.id);
                        const request = await this.retrieveRequest(messageId);
                        return { ...message, request };
                    }
                    return message;
                }));
                const lastTrip = await this.retrieveLastTrip(conversation.lastTripId);
                socket?.emit('retrieveMessages', {messagesWithRequests, conversation_id: conversation.id, lastTrip: lastTrip});
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        });

        socket.on('removeMessages', async (data: messageUsersDto) => {
            try {
                if (!data.user1Id || !data.user2Id) {
                    throw new Error('missing some data!');
                }
                await this.removeMessages(data);
                socket?.emit('removeMessages', {message: "The message deleted successufully!"});
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        })

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
