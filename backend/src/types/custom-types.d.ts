import 'express'; // Ensure Express types are loaded first

declare global {
  namespace Express {
    interface Request {
      file?: Express.Multer.File; // Ensure this matches the import
    }
  }
}