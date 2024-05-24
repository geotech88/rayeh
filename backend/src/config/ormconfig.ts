require('dotenv').config();
import { DataSource, DataSourceOptions } from "typeorm";
import fs from 'fs';

const config = {
    type: 'postgres',
    host: process.env.DB_HOST,
    port: parseInt(process.env.DB_PORT || '5432'),
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    synchronize: true,
    logging: process.env.MODE === "DEV" ? false : false,
    entities: process.env.MODE === "DEV" ? ["src/entity/*.entity.ts"] : ["dist/entity/*.entity.js"],
    migrations: process.env.MODE === "DEV" ? ["src/migrations/*.ts"] : ["dist/migrations/*.js"],
    ssl: process.env.MODE !== 'DEV'
    ? {
        rejectUnauthorized: true,
        ca: fs.readFileSync('src/certs/ca.crt').toString(),
      }
    : false,
};

export default { config };

export const AppDataSource: DataSource = new DataSource(config as DataSourceOptions);