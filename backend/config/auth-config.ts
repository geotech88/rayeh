require('dotenv').config();

const config = {
    authRequired: false,
    auth0Logout: true,
    secret: process.env.SECRET,
    baseURL: process.env.BASEURL,
    clientID: process.env.CLIENTID,
    clientSecret: process.env.CLIENTSECRET,
    issuerBaseURL: process.env.ISSUER_DOMAIN,
};

export {config};