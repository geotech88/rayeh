import { Router } from 'express';
import { OffersController } from '../controllers/offers.controller';

const offerRouter = Router();

offerRouter.post('/api/offer/createoffer', OffersController.createOffer);

offerRouter.get('/api/offer/getalloffers', OffersController.getAllOffers);

offerRouter.get('/api/offer/getoffer/:id', OffersController.getOfferById);

offerRouter.post('/api/offer/updateOffer/:id', OffersController.updateOffer);

offerRouter.delete('/api/offer/deleteoffer/:id', OffersController.deleteOffer);

export { offerRouter };