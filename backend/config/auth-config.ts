require('dotenv').config();

const config = {
    authRequired: false,
    auth0Logout: true,
    secret: process.env.AUTH_SECRET,
    baseURL: process.env.AUTH_BASEURL,
    clientID: process.env.AUTH_CLIENT_ID,
    clientSecret: process.env.AUTH_CLIENT_SECRET,
    issuerBaseURL: process.env.AUTH_ISSUER_DOMAIN,
};

export {config};