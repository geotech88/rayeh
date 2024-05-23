require('dotenv').config();
const { S3 } = require('@aws-sdk/client-s3');
const { S3Client, ListBucketsCommand , CreateBucketCommand, ListObjectsCommand } = require('@aws-sdk/client-s3');
const { defaultProvider } = require('@aws-sdk/credential-provider-node');

// Configure the endpoint for DigitalOcean Spaces
const spacesEndpoint = 'https://rayeh-cdn-service.nyc3.digitaloceanspaces.com';
const s3Client = new S3Client({
  forcePathStyle: true,
  endpoint: spacesEndpoint,
  region: 'nyc3',
  credentials: {
    accessKeyId: 'DO00JAMFCVFKP7LUBM7Q',
    secretAccessKey: 'gfzp7L66dkf8cqtk8n6KvJzDUSIVOov6KG+kKFRZ/q0',
  }
});

// Test: List all the buckets in your Spaces
// s3.listBuckets((err, data) => {
//   if (err) {
//     console.error('Error:', err);
//   } else {
//     console.log('Buckets:', data.Buckets);
//   }
// });
(async () => {
  try {
    //to create a new bucket 
    // const bucketName = 'test-bucket-' + Date.now();
    // const createBucketCommand = new CreateBucketCommand({ Bucket: bucketName });
    // await s3Client.send(createBucketCommand);
    // console.log(`Bucket ${bucketName} created successfully.`);

    // List objects in the created bucket
    const listObjectsCommand = new ListObjectsCommand({ Bucket: 'test-bucket-1716468505281' });
    const data = await s3Client.send(listObjectsCommand);
    console.log('Objects in Bucket:', data);
  } catch (err) {
    console.error('Error:', err);
  }
})();
// require('dotenv').config();

// const apiUrl = `https://dev-32micva8iqjojfue.us.auth0.com/userinfo`;
// async function fetchData() {
//   try {
//     // Making a GET request using fetch
//     const response = await fetch(apiUrl, {
//       headers: {
//         Authorization: `Bearer eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiaXNzIjoiaHR0cHM6Ly9kZXYtMzJtaWN2YThpcWpvamZ1ZS51cy5hdXRoMC5jb20vIn0..hxPMK5y-uy9ETIjv.SW2Ms06PVLDkot8REWFkG_wHTpt7HhJ-gu5z2WkvZEBaZ_b8cSySnFrLD-s6s7X7FLV4lVqOMja7D7j2_ZASaTUwX40mseSiqhc_VT1689j6iDDS9aaKCar2mceZBTYzoDElm17tcCblkPbJLjfvKevYmikWlOcLC_DPfG9uOFGfMPp6tYfel5ch01Tqud_T-Zk7tTqUIHFTLhoqa1O-ZfwiKaz7YnBWlniQgKQN1h9li11grU-f42PuC0-9ySIF259d0JvaH1ir5fkZTjF6ks03lvZ8NdR2lF705QBzFql-EVbelJFTNt7Ts3M96-VHei7zu2hQzcq9TtoU_AWHUlJtEvzhjLA7zWAKxqpvqSVP.FIb-wE5B0oodVEm-sx7sFw`
//       }
//     });

//     // Check if the response status is OK (status code 200)
//     if (!response.ok) {
//       throw new Error(`HTTP error! Status: ${response.statusText}`);
//     }

//     // Parse the JSON response
//     const data = await response.json();

//     // Log the data to the console
//     console.log('Fetched Data:', data);
//   } catch (error) {
//     // Handle any errors that occurred during the fetch
//     console.error('Fetch Error:', error);
//   }
// }

// // Call the fetchData function to initiate the request
// fetchData();