import { Response, Router, NextFunction } from 'express';
import { ReviewsController } from '../controllers/reviews.controller';

const reviewRouter = Router();

reviewRouter.post('/api/review/createreview', ReviewsController.createReview);

reviewRouter.get('/api/review/getallreviewstouser/:id', ReviewsController.getAllReviewsToUser);

reviewRouter.get('/api/review/getalluserreviews/:id', ReviewsController.getAllUserReviews);

reviewRouter.delete('/api/review/delete/:id', ReviewsController.deleteReview);

export { reviewRouter };