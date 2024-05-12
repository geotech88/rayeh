import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { User } from "../entity/Users.entity";
import { Tracker } from "../entity/Tracker.entity";
import { Trips } from "../entity/Trips.entity";
import { TransactionsController } from "./transactions.controller";

export class TrackersController {
    static async createTracker(req: ExtendedRequest, res: Response) {
        try {
            const { receiverUserId, senderUserId, name, date, timing, tripId } = req.body;
            const receiverUser = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: receiverUserId}});
            const senderUser = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: senderUserId}});
            const trip = await AppDataSource.getRepository(Trips).findOne({where: {id: tripId}});
            if (!receiverUser || !senderUser) {
                return res.status(404).json({message: "User not found"});
            }
            if (!trip) {
                return res.status(404).json({message: "Trip not found"});
            }
            const TrackerRepository = AppDataSource.getRepository(Tracker);
            const tracker = new Tracker();
            tracker.receiverUser = receiverUser;
            tracker.senderUser = senderUser;
            tracker.name = name;
            tracker.date = date;
            tracker.timing = timing;
            tracker.trip = trip;
            await TrackerRepository.save(tracker);
            await TransactionsController.createTransaction(req, tracker);
            return res.status(201).json({message:'Tracker updated successfully', data: tracker});
        } catch (error:any){
            return res.status(500).json({error: error.message});
        }
    }

    static async getTrackersByUserId(req: ExtendedRequest, res: Response) {
        try {
            const { userId } = req.params
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const trackers = await AppDataSource.getRepository(Tracker).find({relations: {receiverUser: true, senderUser: true, trip: true},
                                                                            where: [{receiverUser: {id: user.id}}, {senderUser: {id: user.id}}]});
            if (!trackers.length) {
                return res.status(404).json({message: "No trackers were found"});
            }
            return res.status(200).json({message:'Trackers received succefully', data: trackers});
        } catch (error:any) {
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

    static async updateTracker(req: ExtendedRequest, res: Response) {
        try {
            const { id } = req.params;
            const {name, date, timing } = req.body;
            let tracker = await AppDataSource.getRepository(Tracker).findOne({where: {id: Number(id)}});
            if (!tracker) {
                return res.status(404).json({message: "Tracker not found"});
            }
            tracker.name = name;
            tracker.date = date;
            tracker.timing = timing;
            await AppDataSource.getRepository(Tracker).save(tracker);
            tracker = await AppDataSource.getRepository(Tracker).findOne({where: {id: Number(id)}});
            return res.status(200).json({message: 'Tracker updated successfully', data: tracker});
        } catch (error:any) {
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