import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { Trips } from "../entity/Trips.entity";
import { User } from "../entity/Users.entity";
import { MoreThanOrEqual, Not } from "typeorm";
import { Reviews } from "../entity/Reviews.entity";
import { calculateReviewsAverage } from "../helpers/helpers";
import { Transaction } from "../entity/Transaction.entity";

interface TripWithReviews extends Trips {
    reviews: Reviews[];
    average_rating: number;
}

interface TripWithTransaction extends Trips {
    transaction: Transaction;
    reviews: Reviews[];
}

export class TripsController {

    static async createTrips(req: ExtendedRequest, res: Response) {
        try {
            const { from, to, date, description } = req.body;
            const TripsRepository = AppDataSource.getRepository(Trips);
            const user = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: req.user?.userId}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const getAllTrips = await AppDataSource.getRepository(Trips).find({ relations: {user: true, review: true}, where: { user: {auth0UserId: req.user?.userId} },take: 5});
            const trips = new Trips();
            trips.from = from;
            trips.to = to;
            trips.date = typeof(date) == "string"? new Date(date): date; //receive string as "yyyy-mm-dd"
            trips.description = description;
            trips.user = user;
            await TripsRepository.save(trips);
            const userReviews = await AppDataSource.getRepository(Reviews).find({ relations: {user: true}, where: { reviewedUser: {auth0UserId: req.user?.userId} } }); //shows previous_trips 5
            const average_rating = calculateReviewsAverage(userReviews);
            return res.status(201).json({message:'Trips updated successfully', data: {new_trip: trips, previous_trips: getAllTrips, average_rating: average_rating}});

        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
        }
    }

    static async getAllTrips(req: ExtendedRequest, res: Response) {
        try {
            const TripsRepository = AppDataSource.getRepository(Trips);
            const trips = await TripsRepository.find({take: 15});
            if (!trips) {
                return res.status(404).json({message: "No Trips were found"});
            }
            return res.status(200).json({message:'Trips received succefully', data: trips});
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
        }
    }

    //do not retrieve the trips of the logged user
    static async getTripsBySearch(req: ExtendedRequest, res: Response) {
        try {
            const { from, to } = req.query;
            if (!from || !to) {
                return res.status(400).json({message: "missing parameters in body!"});
            }
            const fromDate = new Date() as Date;
            const trips = await AppDataSource.getRepository(Trips).find({
                relations: {user: true, review: true},
                where: {
                  date: MoreThanOrEqual(fromDate),
                  to: to as string,
                  from: from as string,
                  user: {auth0UserId: Not(req.user?.userId)}
                },
                take: 14
              });
            if (!trips) {
                return res.status(404).json({message: "No Trips were found"});
            }

            
            for (const trip of trips  as TripWithReviews[]) {
                const userReviews = await AppDataSource.getRepository(Reviews).find({ relations: {user: true}, where: { reviewedUser: {auth0UserId: trip.user.auth0UserId} } });
                const average_rating = calculateReviewsAverage(userReviews);
                trip['average_rating'] = average_rating;
            }
            return res.status(200).json({message:'Trips retrieved succefully', data: trips});
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
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
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
        }
    }

    //add reviews to each trip, transaction, and invoice
    static async getTripsByUserId(req: ExtendedRequest, res: Response) {
        try {
            const TripsRepository = AppDataSource.getRepository(Trips);
            const trips = await TripsRepository.find({relations: { user: true, review: true } ,where: {user: {auth0UserId: req.params.id}}, take: 14});
            if (!trips) {
                return res.status(404).json({message: "Trips not found"});
            }
            for (const trip of trips  as TripWithTransaction[]) {
                trip['transaction'] = await AppDataSource.getRepository(Transaction).findOne({relations: {invoice: true}, where: { trip: {id: trip.id}}}) as Transaction;
            }
            const userReviews = await AppDataSource.getRepository(Reviews).find({ relations: {user: true}, where: { reviewedUser: {auth0UserId: req.user?.userId} } });
            const average_rating = calculateReviewsAverage(userReviews);
            return res.status(200).json({message: 'Trips received succefully', data: {trips, average_rating: average_rating}});
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
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
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
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
        } catch (error: any) {
            return res.status(500).json({error: {message: error.message}});
        }
    }
}