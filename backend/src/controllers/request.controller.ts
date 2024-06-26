import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { Request } from "../entity/Request.entity";
import { Message } from "../entity/Messages.entity";
import { Conversation } from "../entity/Conversation.entity";
import { User } from "../entity/Users.entity";

export class RequestController {
    static async createRequest(req: ExtendedRequest, res: Response) {
        try {
            const { from, to, price, cost, date, service, conversationId } = req.body;
            console.log('the informations:',from, to, price, cost, conversationId )
            if (!from || !to || String(price) === 'undefined' || String(cost) === 'undefined' || !date || !service || !conversationId) {
                return res.status(400).json({message: "Missing parameters in the body"});
            }
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.userId}});
            const RequestRepository = AppDataSource.getRepository(Request);
            const conversation = await AppDataSource.getRepository(Conversation).findOne({relations: {messages: true},where: {id: conversationId}});
            if (!conversation) {
                return res.status(404).json({message: "Conversation not found"});
            }
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const message = new Message();
            message.message = '';
            message.type = 'request';
            message.user = user;
            await AppDataSource.getRepository(Message).save(message);
            if (!conversation.messages) {
                conversation.messages = [];
            }
            conversation.messages.push(message);
            await AppDataSource.getRepository(Conversation).save(conversation);
            const request = new Request();
            request.from = from;
            request.to = to;
            request.price = String(price);
            request.cost = String(cost);
            request.service = service;
            request.message = message;
            request.date = new Date(date);
            await RequestRepository.save(request);
            return res.status(201).json({message: 'Request created successfully', data: request});
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
        }
    }

    static async deleteRequest(req: ExtendedRequest, res: Response) {
        try {
            const RequestRepository = AppDataSource.getRepository(Request);
            const request = await RequestRepository.findOne({where: {id: Number(req.params.id)}});
            if (!request) {
                return res.status(404).json({message: "Request not found"});
            }
            await RequestRepository.delete(request);
            return res.status(200).json({message: 'Request deleted successfully'});
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
        }
    }
}