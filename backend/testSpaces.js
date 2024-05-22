require('dotenv').config();
const AWS = require('@aws-sdk/client-s3');

// Configure the endpoint for DigitalOcean Spaces
const spacesEndpoint = new AWS.Endpoint('/rayeh-cdn-service.nyc3.cdn.digitaloceanspaces.com');
const s3 = new AWS.S3({
  endpoint: spacesEndpoint,
  accessKeyId: 'dop_v1_f8919d43eb378ef5172bdba7c1ccba30bd08a03d756f8bd925ac3d054b149023',
  secretAccessKey: 'G93dkl4k/d6ZE0juuG5BPHY28tAUf8lSZCEVh35w6Zg',
  region: 'nyc3'
});

// Test: List all the buckets in your Spaces
s3.listBuckets((err, data) => {
  if (err) {
    console.error('Error:', err);
  } else {
    console.log('Buckets:', data.Buckets);
  }
});