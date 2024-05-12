import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { Reviews } from "../entity/Reviews.entity";
import { User } from "../entity/Users.entity";
import { calculateReviewsAverage } from "../helpers/helpers";

export class ReviewsController {
    static async createReview(req: ExtendedRequest, res: Response) {
        try {
            const { value, rating, reviewedUserId } = req.body;
            const user = await AppDataSource.getRepository(User).findOne({where: {email: req.user?.email}});
            const reviewedUser = await AppDataSource.getRepository(User).findOne({where: {auth0UserId: reviewedUserId}});
            if (!user || !reviewedUser) {
                return res.status(404).send({ message: "User not found" });
            }
            const ReviewRepository = AppDataSource.getRepository(Reviews);
            const review = new Reviews();
            review.user = user;
            review.value = value;
            review.rating = rating;
            review.reviewedUser = reviewedUser;
            await ReviewRepository.save(review);
            return res.status(200).json({ message: "Review created", data: review });
        } catch (error: any) {
            return res.status(500).json({ error: error.message });
        }
    }

    static async getAllReviewsToUser(req: ExtendedRequest, res: Response) {
         try {
            const reviews = await AppDataSource.getRepository(Reviews)
                                    .find({relations: {user: true}, where: {reviewedUser: {auth0UserId: req.params?.id}}});
            if (!reviews) {
                return res.status(404).json({ message: "Reviews not found" });
            }
            const average = calculateReviewsAverage(reviews);
            return res.status(200).json({ message: "Reviews retrieved successfully", data: {reviews, 'average_rating': average} });
         } catch (error: any) {
            return res.status(500).json({ error: error.message });
         }
    }

    static async deleteReview(req: ExtendedRequest, res: Response) {
        try {
            const review = await AppDataSource.getRepository(Reviews).findOne({ where: { id: Number(req.params?.id) } });
            if (!review) {
                return res.status(404).json({ message: "Review not found" });
            }
            await AppDataSource.getRepository(Reviews).delete(review);
            return res.status(200).json({ message: 'Review deleted successfully' });
        } catch (error: any) {
            return res.status(500).json({ error: error.message });
        }
    }
}