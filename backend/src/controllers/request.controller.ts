import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { Request } from "../entity/Request.entity";
import { Message } from "../entity/Messages.entity";

export class RequestController {
    static async createRequest(req: ExtendedRequest, res: Response) {
        try {
            const { from, to, price, cost, messageId } = req.body;
            const RequestRepository = AppDataSource.getRepository(Request);
            const message = await AppDataSource.getRepository(Message).findOne({where: {id: messageId}});
            if (!message) {
                return res.status(404).json({message: "Message not found"});
            }
            const request = new Request();
            request.from = from;
            request.to = to;
            request.price = price;
            request.cost = cost;
            request.message = message;
            await RequestRepository.save(request);
            return res.status(201).json({message: 'Request created successfully', data: request});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
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
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }
}