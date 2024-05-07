import * as jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";
require('dotenv').config();
import { payload } from "../dto/user.dto";
import { Decimal128 } from "typeorm";
const axios = require('axios');

const { JWT_SECRET = "" } = process.env;
export class encrypt {
  static async encryptpass(password: string) {
    return bcrypt.hashSync(password, 12);
  }
  static comparepassword(hashPassword: string, password: string) {
    return bcrypt.compareSync(password, hashPassword);
  }

  static generateToken(payload: payload) {
    return jwt.sign(payload, JWT_SECRET, { expiresIn: "1d" });
  }

}

export const getToken = async () => {
    const tokenUrl = `${process.env.ISSUER_DOMAIN}/oauth/token`;

    const clientId = process.env.CLIENTID;
    const clientSecret = process.env.CLIENTSECRET;

    const audience = process.env.ISSUER_AUDIENCE;

    return axios.post(tokenUrl, {
      grant_type: 'client_credentials',
      client_id: clientId,
      client_secret: clientSecret,
      audience: audience
    })
    .then((response: any) => {
      const accessToken = response.data.access_token;
      return accessToken;
    })
    .catch((error: any) => {
      console.error('Error obtaining access token:', error.response.data);
    });
}

// export const uploadFile = async (file: any) => {

// }

export const conversionCurrency = async (from: string, to: string, amount: number): Promise<number> => {
  //TODO: will use an api request to convert the currency
  return amount;
}