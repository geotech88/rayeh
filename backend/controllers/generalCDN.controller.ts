import { Response } from 'express';
import { v4 as uuidv4 } from 'uuid';
import { ExtendedRequest } from '../middlewares/Authentication';
import { S3 } from 'aws-sdk';

require('dotenv').config();

export class GenralCDNController {
    private s3: S3;
    private bucketPublic: string;

    constructor() {
        this.s3 = new S3({
            endpoint: process.env.DO_SPACES_ENDPOINT,
            accessKeyId: process.env.DO_SPACES_KEY,
            secretAccessKey: process.env.DO_SPACES_SECRET,
            region: 'us-east-1',
        });
        this.bucketPublic = process.env.DO_SPACES_PUBLIC_BUCKET || '';
    }

    public async uploadFile(req: ExtendedRequest, res: Response): Promise<Response> {
        try {
            const { file, folder_name, file_name } = req.body;

            if (!file || !folder_name) {
                return res.status(400).json({ error: 'Invalid request parameters' });
            }

            const bucketName = this.bucketPublic;
            const key = `${folder_name}/${file_name || uuidv4()}`;
            const buffer = Buffer.from(file, 'base64');

            await this.s3.putObject({
                Bucket: bucketName,
                Key: key,
                Body: buffer,
                ACL: 'public-read',
                ContentType: 'application/octet-stream'
            }).promise();

            const fileUrl = `${process.env.DO_SPACES_ENDPOINT}/${bucketName}/${key}`;
            return res.status(200).json({ file_url_or_secret_key: fileUrl });

        } catch (error) {
            console.error('Error uploading file:', error);
            return res.status(500).json({ error: 'Internal Server Error' });
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
        } catch (error) {
            console.error('Error deleting file:', error);
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    }
}