require('dotenv').config();
import { DataSource, DataSourceOptions } from "typeorm";

const config = {
    type: 'postgres',
    host: process.env.PGHOST,
    port: parseInt(process.env.DBPORT || '5432'),
    username: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    database: process.env.PGDATABASE,
    synchronize: true,
    logging: process.env.NODE_ENV === "dev" ? false : false,
    entities: ["entity/*.entity.ts"],
    migrations: ["migrations/*.ts"]
};

export default { config };

export const AppDataSource: DataSource = new DataSource(config as DataSourceOptions);