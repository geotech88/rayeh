import { Response } from 'express';
import { v4 as uuidv4 } from 'uuid';
import { ExtendedRequest } from '../middlewares/Authentication';
import { S3, Endpoint } from 'aws-sdk';

require('dotenv').config();

export class GenralCDNController {
    private s3: S3;
    private bucketPublic: string;

    constructor() {
        // const spacesEndpoint = new Endpoint('https://rayeh-cdn-service.nyc3.digitaloceanspaces.com');

        const spaceEndpoint = new Endpoint(process.env.DO_SPACES_ENDPOINT || "")
        this.s3 = new S3({
            endpoint: spaceEndpoint,
            accessKeyId: process.env.DO_SPACES_KEY,
            secretAccessKey: process.env.DO_SPACES_SECRET,
            region: process.env.DO_SPACES_REGION
        });
        this.bucketPublic = process.env.DO_SPACES_PUBLIC_BUCKET || "";
    }

    public async uploadFile(req: ExtendedRequest): Promise<any> {
        try {
            const file = req.file;
            if ( !file) {
                return {message: 'invalid request parameters'};
            }
            const file_name = file.originalname;
            const ext = file_name.split('.').pop();
            const filename = file_name.split('.').slice(0, -1).join();
            const bucketName = this.bucketPublic;
            const key = `${filename + uuidv4() + '.' + ext}`;
            console.log('the file name:', {
                Bucket: bucketName,
                Key: key,
                Body: file?.buffer,
                ACL: 'public-read',
                ContentType: file?.mimetype
            });

            const { Location } = await this.s3.upload({
                Bucket: bucketName,
                Key: key,
                Body: file?.buffer,
                ACL: 'public-read',
                ContentType: file?.mimetype
            }).promise();

            return { file_url: Location };

        } catch (error:any) {
            console.error('Error uploading file:', error);
            return { message: error.message };
        }
    }

    public async deleteFile(req: ExtendedRequest, res: Response): Promise<Response> {
        try {
            const { file_path } = req.body;

            if (!file_path) {
                return res.status(400).json({ error: 'Invalid request parameters' });
            }

            const bucketName = this.bucketPublic;

            await this.s3.deleteObject({
                Bucket: bucketName,
                Key: file_path
            }).promise();

            return res.status(200).json({ message: 'File deleted successfully' });
        } catch (error:any) {
            console.error('Error deleting file:', error);
            return res.status(500).json({ error: error.message });
        }
    }
}