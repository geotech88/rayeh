import { Request, Response } from 'express';
import { BlobServiceClient, StorageSharedKeyCredential } from '@azure/storage-blob';
import { v4 as uuidv4 } from 'uuid';
require('dotenv').config();

export class GeneralCDNController {
    private blobServiceClient: BlobServiceClient;
    private publicContainer: string;

    constructor() {
        const accountName = process.env.AZURE_STORAGE_ACCOUNT_NAME || '';
        const accountKey = process.env.AZURE_STORAGE_ACCOUNT_KEY || '';
        const sharedKeyCredential = new StorageSharedKeyCredential(accountName, accountKey);
        
        this.publicContainer = process.env.AZURE_STORAGE_PUBLIC_CONTAINER || '';
        this.blobServiceClient = new BlobServiceClient(
            `https://${accountName}.blob.core.windows.net`,
            sharedKeyCredential
        );
    }

    public async uploadFile(req: Request, res: Response): Promise<Response> {
        try {
            const { file, folder_name, file_name } = req.body;

            if (!file || !folder_name) {
                return res.status(400).json({ error: 'Invalid request parameters' });
            }

            const containerName = this.publicContainer
            const blobName = `${folder_name}/${file_name || uuidv4()}`;
            const containerClient = this.blobServiceClient.getContainerClient(containerName);
            const blockBlobClient = containerClient.getBlockBlobClient(blobName);

            await blockBlobClient.uploadData(Buffer.from(file, 'base64'), {
                blobHTTPHeaders: { blobContentType: 'application/octet-stream' }
            });

            const fileUrl = blockBlobClient.url;
            return res.status(200).json({ file_url_or_secret_key: fileUrl });
        } catch (error) {
            console.error('Error uploading file:', error);
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    }

    public async deleteFile(req: Request, res: Response): Promise<Response> {
        try {
            const { file_path } = req.body;

            if ( !file_path ) {
                return res.status(400).json({ error: 'Invalid request parameters' });
            }

            const containerName = this.publicContainer;
            const containerClient = this.blobServiceClient.getContainerClient(containerName);
            const blockBlobClient = containerClient.getBlockBlobClient(file_path);

            await blockBlobClient.delete();

            return res.status(200).json({ message: 'File deleted successfully' });
        } catch (error) {
            console.error('Error deleting file:', error);
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    }
}
