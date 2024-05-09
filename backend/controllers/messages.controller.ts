import { AppDataSource } from "../config/ormconfig";
import { messageDto, messageUsersDto } from "../dto/message.dto";
import { Message } from "../entity/Messages.entity";
import { Socket } from "socket.io";

export class MessagesController {
    private messageRepository = AppDataSource.getRepository(Message);

    async storeMessage(message: messageDto): Promise<Message> {
        try {
            const newMessage = this.messageRepository.create(message);
            await this.messageRepository.save(newMessage);
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
                    {senderUser: {auth0UserId: messageUsers.user1Id, receiverUser: {auth0UserId: messageUsers.user2Id}}},
                    {senderUser: {auth0UserId: messageUsers.user2Id, receiverUser: {auth0UserId: messageUsers.user1Id}}},
                ]
            };
            return await this.messageRepository.find(queryCriteria);
        } catch (error: any) {
            throw new Error('Failed to retrieve messages from database');
        }
    }


    handleSocketEvents(socket: Socket) {
        socket.on('sendMessage', async (data: messageDto) => {
            try {
                const newMessage = await this.storeMessage(data);
                socket.emit('newMessage', newMessage);
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        });

        socket.on('getMessages', async (data: messageUsersDto) => {
            try {
                const messages = await this.getAllMessages(data);
                socket.emit('getMessages', messages);
            } catch (error: any) {
                socket.emit('error', error.message);
            }
        });
    }
}