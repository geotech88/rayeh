import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Tracker } from "../entity/Tracker.entity";

export class TrackersController {
    static async createTracker(req: ExtendedRequest, res: Response) {
        try {
            const { receiverUserId, senderUserId, name, status, delivered } = req.body;
            const receiverUser = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: receiverUserId}});
            const senderUser = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: senderUserId}});
            if (!receiverUser || !senderUser) {
                return res.status(404).json({message: "User not found"});
            }
            const TrackerRepository = AppDataSource.getRepository(Tracker);
            const tracker = new Tracker();
            tracker.receiverUser = receiverUser;
            tracker.senderUser = senderUser;
            tracker.name = name;
            tracker.status = status;
            tracker.delivered = delivered;
            await TrackerRepository.save(tracker);
            return res.status(201).json({message:'Tracker updated successfully', data: tracker});
        } catch (error:any){
            return res.status(500).json({error: error.message});
        }
    }

    static async getAllTrackers(req: ExtendedRequest, res: Response) {
        try {
            const TrackerRepository = AppDataSource.getRepository(Tracker);
            const trackers = await TrackerRepository.find();
            if (!trackers.length) {
                return res.status(404).json({message: "No trackers were found"});
            }
            return res.status(200).json({message:'Trackers received succefully', data: trackers});
        } catch (error:any){
            return res.status(500).json({error: error.message});
        }
    }

    static async deleteTracker(req: ExtendedRequest, res: Response) {
        try {
            const tracker = await AppDataSource.getRepository(Tracker).findOne({where: {id: Number(req.params.id)}});
            if (!tracker) {
                return res.status(404).json({message: "Tracker not found"});
            }
            await AppDataSource.getRepository(Tracker).delete(tracker);
            return res.status(200).json({message: 'Tracker deleted successfully'});
        } catch(error: any) {
            return res.status(500).json({error: error.message});
        }
    }
}