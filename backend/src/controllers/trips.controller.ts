import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { Trips } from "../entity/Trips.entity";
import { User } from "../entity/Users.entity";
import { MoreThanOrEqual } from "typeorm";

export class TripsController {
    static async createTrips(req: ExtendedRequest, res: Response) {
        try {
            const { from, to, date, description } = req.body;
            const TripsRepository = AppDataSource.getRepository(Trips);
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const trips = new Trips();
            trips.from = from;
            trips.to = to;
            trips.date = typeof(date) == "string"? new Date(date): date; //receive string as "yyyy-mm-dd"
            trips.description = description;
            trips.user = user;
            await TripsRepository.save(trips);
            return res.status(201).json({message:'Trips updated successfully', data: trips});

        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async getAllTrips(req: ExtendedRequest, res: Response) {
        try {
            const TripsRepository = AppDataSource.getRepository(Trips);
            const trips = await TripsRepository.find();
            if (!trips) {
                return res.status(404).json({message: "No Trips were found"});
            }
            return res.status(200).json({message:'Trips received succefully', data: trips});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    //add user in response, rating, time remaining for the trip
    static async getTripsBySearch(req: ExtendedRequest, res: Response) {
        try {
            const { from, to } = req.body;
            const fromDate = new Date() as Date;
            const trips = await AppDataSource.getRepository(Trips).find({
                relations: {user: true},
                where: {
                  date: MoreThanOrEqual(fromDate),
                  to: to,
                  from: from
                }
              });
            if (!trips) {
                return res.status(404).json({message: "No Trips were found"});
            }
            return res.status(200).json({message:'Trips retrieved succefully', data: trips});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async getTripsById(req: ExtendedRequest, res: Response) {
        try {
            const TripsRepository = AppDataSource.getRepository(Trips);
            const trips = await TripsRepository.findOne({relations: {user: true}, where: {id: Number(req.params.id)}});
            if (!trips) {
                return res.status(404).json({message: "Trips not found"});
            }
            return res.status(200).json({message: 'Trips received succefully', data: trips});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    //add reviews to each trip, transaction, and invoice
    static async getTripsByUserId(req: ExtendedRequest, res: Response) {
        try {
            const TripsRepository = AppDataSource.getRepository(Trips);
            const trips = await TripsRepository.find({where: {user: {auth0UserId: req.params.id}}});
            if (!trips) {
                return res.status(404).json({message: "Trips not found"});
            }
            return res.status(200).json({message: 'Trips received succefully', data: trips});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async updateTrips(req: ExtendedRequest, res: Response) {
        try {
            const { from, to, date, description } = req.body;
            const TripsRepository = AppDataSource.getRepository(Trips);
            let trips = await TripsRepository.findOne({where: {id: Number(req.params.id)}});
            if (!trips) {
                return res.status(404).json({message: "Trips not found"});
            }
            trips.from = from;
            trips.to = to;
            trips.description = description;
            trips.date = typeof(date) == "string"? new Date(date): date;
            await TripsRepository.save(trips);
            trips = await TripsRepository.findOne({where: {id: Number(req.params.id)}});
            return res.status(200).json({message:'Trips updated successfully', data: trips});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async deleteTrips(req: ExtendedRequest, res: Response) {
        try {
            const TripsRepository = AppDataSource.getRepository(Trips);
            const trips = await TripsRepository.findOne({where: {id: Number(req.params.id)}});
            if (!trips) {
                return res.status(404).json({message: "Trips not found"});
            }
            await TripsRepository.delete(trips);
            return res.status(200).json({message:'Trips deleted successfully'});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }
}