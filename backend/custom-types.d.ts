// custom-types.d.ts
import { File } from 'multer';

declare global {
  namespace Express {
    interface Request {
      file?: File; // This is optional; use file!: File; if it should be non-nullable
    }
  }
}