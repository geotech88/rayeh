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