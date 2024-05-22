import { Response } from 'express';
// import { v4 as uuidv4 } from 'uuid';
import { ExtendedRequest } from '../middlewares/Authentication';
import { S3, Endpoint } from 'aws-sdk';

require('dotenv').config();

export class GenralCDNController {
    private s3: S3;
    private bucketPublic: string;

    constructor() {
        const spaceEndpoint = new Endpoint('nyc3.cdn.digitaloceanspaces.com')
        this.s3 = new S3({
            endpoint: spaceEndpoint,
            accessKeyId: 'dop_v1_f8919d43eb378ef5172bdba7c1ccba30bd08a03d756f8bd925ac3d054b149023',
            secretAccessKey: 'G93dkl4k/d6ZE0juuG5BPHY28tAUf8lSZCEVh35w6Zg',
            region: 'nyc3'
        });
        this.bucketPublic = 'rayeh-cdn-service';
    }

    public async uploadFile(req: ExtendedRequest): Promise<any> {
        try {
            const file_name = req.body?.file_name;
            const file = req.file;
            if (!file_name || !file) {
                return {message: 'invalid request parameters'};
            }
            const ext = file_name.split('.').pop();
            const filename = file_name.split('.').slice(0, -1).join();
            const bucketName = this.bucketPublic;
            const key = `${filename + uuidv4() + '.' + ext}`;
            console.log('bucketName:', bucketName);

            const { Location } = await this.s3.upload({
                Bucket: bucketName,
                Key: key,
                Body: file?.buffer,
                ACL: 'public-read',
                ContentType: file?.mimetype
            }).promise();

            return { file_url: Location };

        } catch (error) {
            console.error('Error uploading file:', error);
            return { message: 'Internal Server Error' };
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