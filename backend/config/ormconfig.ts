require('dotenv').config();
import { DataSource, DataSourceOptions } from "typeorm";

const config = {
    type: 'postgres',
    host: process.env.DB_HOST,
    port: parseInt(process.env.DB_PORT || '5432'),
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    synchronize: true,
    logging: process.env.MODE === "DEV" ? false : false,
    entities: ["entity/*.entity.ts"],
    migrations: ["migrations/*.ts"],
    ssl: process.env.MODE === 'DEV' ? true : false,   
};

export default { config };

export const AppDataSource: DataSource = new DataSource(config as DataSourceOptions);
