import { Router } from 'express';
import { TripsController } from '../controllers/trips.controller';

const tripsRouter = Router();

tripsRouter.post('/api/trips/createtrip', TripsController.createTrips);

tripsRouter.get('/api/trips/getallTrips', TripsController.getAllTrips);

tripsRouter.get('/api/trips/gettrip/:id', TripsController.getTripsById);

tripsRouter.get('/api/trips/getTripsbysearch', TripsController.getTripsBySearch);

tripsRouter.get('/api/trips/getTripsByUserId/:id', TripsController.getTripsByUserId);

tripsRouter.post('/api/trips/updatetrip/:id', TripsController.updateTrips);

tripsRouter.delete('/api/trips/deletetrip/:id', TripsController.deleteTrips);

export { tripsRouter };