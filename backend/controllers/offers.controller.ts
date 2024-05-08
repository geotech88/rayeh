import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { Offer } from "../entity/Offers.entity";
import { User } from "../entity/Users.entity";

export class OffersController {
    static async createOffer(req: ExtendedRequest, res: Response) {
        try {
            const { from, to, date, description } = req.body;
            const OfferRepository = AppDataSource.getRepository(Offer);
            const user = await AppDataSource.getRepository(User).findOne({where: {email: req.user?.email}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            const offer = new Offer();
            offer.from = from;
            offer.to = to;
            offer.date = new Date(date) as Date; //receive string as "yyyy-mm-dd"
            offer.description = description;
            offer.user = user;
            await OfferRepository.save(offer);
            return res.status(201).json({message:'Offer updated successfully', data: offer});

        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async getAllOffers(req: ExtendedRequest, res: Response) {
        try {
            const OfferRepository = AppDataSource.getRepository(Offer);
            const offers = await OfferRepository.find();
            if (!offers) {
                return res.status(404).json({message: "No offers were found"});
            }
            return res.status(200).json({message:'Offers received succefully', data: offers});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async getOfferById(req: ExtendedRequest, res: Response) {
        try {
            const OfferRepository = AppDataSource.getRepository(Offer);
            const offer = await OfferRepository.findOne({where: {id: Number(req.params.id)}});
            if (!offer) {
                return res.status(404).json({message: "Offer not found"});
            }
            return res.status(200).json({message: 'Offer received succefully', data: offer});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async updateOffer(req: ExtendedRequest, res: Response) {
        try {
            const { from, to, date, description } = req.body;
            const OfferRepository = AppDataSource.getRepository(Offer);
            const offer = await OfferRepository.findOne({where: {id: Number(req.params.id)}});
            if (!offer) {
                return res.status(404).json({message: "Offer not found"});
            }
            offer.from = from;
            offer.to = to;
            offer.description = description;
            offer.date = typeof(date) == "string"? new Date(date): date;
            await OfferRepository.save(offer);
            return res.status(200).json({message:'Offer updated successfully', data: offer});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }

    static async deleteOffer(req: ExtendedRequest, res: Response) {
        try {
            const OfferRepository = AppDataSource.getRepository(Offer);
            const offer = await OfferRepository.findOne({where: {id: Number(req.params.id)}});
            if (!offer) {
                return res.status(404).json({message: "Offer not found"});
            }
            await OfferRepository.delete(offer);
            return res.status(200).json({message:'Offer deleted successfully'});
        } catch {
            return res.status(500).json({error: 'Something went wrong with databse'});
        }
    }
}