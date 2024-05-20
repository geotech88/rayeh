import * as jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";
import dotenv from 'dotenv';
import { payload } from "../dto/user.dto";
import { Reviews } from "../entity/Reviews.entity";
import axios from 'axios';

dotenv.config();

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
    const tokenUrl = `${process.env.AUTH0_DOMAIN}/oauth/token`;

    const clientId = process.env.AUTH0_CLIENT_ID;
    const clientSecret = process.env.AUTH0_CLIENT_SECRET;

    const audience = process.env.AUTH0_AUDIENCE;

    return axios.post(tokenUrl, {
      grant_type: 'client_credentials',
      client_id: clientId,
      client_secret: clientSecret,
      audience: audience
    })
    .then((response: any) => {
      const accessToken = response.data;
      return accessToken;
    })
    .catch((error: any) => {
      console.error('Error obtaining access token:', error.response.data);
    });
}

export const calculateReviewsAverage = (reviews: Reviews[]) => {
    const sum = reviews.reduce((acc: number, review: Reviews) => acc + review.rating, 0);
    return sum / reviews.length || 0;
}

// export const uploadFile = async (file: any) => {

// }

export const conversionCurrency = async (from: string, to: string, amount: number): Promise<number> => {
  //TODO: will use an api request to convert the currency
  return amount;
}
