import { Response, Router, NextFunction } from 'express';
import { TrackersController } from '../controllers/trackers.controller';

const trackerRouter = Router();

trackerRouter.post('/api/tracker/createtracker', TrackersController.createTracker);

trackerRouter.get('/api/tracker/getalltrackers', TrackersController.getAllTrackers);

trackerRouter.get('/api/tracker/gettrackers/:id', TrackersController.getTrackersByUserId);

trackerRouter.patch('/api/tracker/update/:id', TrackersController.updateTracker)

trackerRouter.delete('/api/tracker/delete/:id', TrackersController.deleteTracker);

export { trackerRouter };