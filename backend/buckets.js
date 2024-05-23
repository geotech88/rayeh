require('dotenv').config();
const { S3Client, ListBucketsCommand } = require('@aws-sdk/client-s3');

// Ensure environment variables are loaded correctly
// const spacesKey = process.env.DO_SPACES_KEY;
// const spacesSecret = process.env.DO_SPACES_SECRET;
const spacesEndpoint = 'https://rayeh-cdn-service.nyc3.digitaloceanspaces.com';

// if (!spacesKey || !spacesSecret || !spacesEndpoint) {
//   console.error('Error: Missing environment variables. Please check your .env file.');
//   process.exit(1);
// }

// Configure the endpoint for DigitalOcean Spaces
const s3Client = new S3Client({
    forcePathStyle: true,
    endpoint: spacesEndpoint,
    region: 'nyc3',
    credentials: {
      accessKeyId: 'DO00JAMFCVFKP7LUBM7Q',
      secretAccessKey: 'gfzp7L66dkf8cqtk8n6KvJzDUSIVOov6KG+kKFRZ/q0',
    }
});

// Function to list all buckets
(async () => {
  try {
    const listBucketsCommand = new ListBucketsCommand({});
    const data = await s3Client.send(listBucketsCommand);
    console.log('Full Response:', data);

    if (data.Buckets) {
      console.log('Buckets:', data.Buckets);
    } else {
      console.log('No Buckets found or response format is different: ',data);
    }
  } catch (err) {
    console.error('Error:', err);
  }
})();