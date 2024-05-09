import { Router } from 'express';
import { TripsController } from '../controllers/trips.controller';

const tripsRouter = Router();

tripsRouter.post('/api/offer/createoffer', TripsController.createTrips);

tripsRouter.get('/api/offer/getallTrips', TripsController.getAllTrips);

tripsRouter.get('/api/offer/getoffer/:id', TripsController.getTripsById);

tripsRouter.get('/api/offer/getTripsbysearch', TripsController.getTripsBySearch);

tripsRouter.post('/api/offer/updateOffer/:id', TripsController.updateTrips);

tripsRouter.delete('/api/offer/deleteoffer/:id', TripsController.deleteTrips);

export { tripsRouter };