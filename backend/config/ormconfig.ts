require('dotenv').config();
import { DataSource, DataSourceOptions, In } from "typeorm";
import { User } from "../entity/Users.entity";
import { Offer } from "../entity/Offers.entity";
import { Invoice } from "../entity/Invoices.entity";
import { Wallet } from "../entity/Wallet.entity";
import { WalletLogs } from "../entity/WalletLogs.entity";
import { Reviews } from "../entity/Reviews.entity";
import { Role } from "../entity/Roles.entity";
import { Tracker } from "../entity/Tracker.entity";
import { Message } from "../entity/Messages.entity";
import { Request } from "../entity/Request.entity";

const config = {
    type: 'postgres',
    host: process.env.DB_HOST,
    port: parseInt(process.env.DB_PORT || '5432'),
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    synchronize: true,
    logging: process.env.MODE === "dev" ? false : false,
    entities: ["entity/*.entity.{ts,js}"],
    // entities: [User, Offer, Invoice, Wallet, WalletLogs, Reviews, Role, Tracker, Message, Request],
    migrations: ["migrations/*.{ts,js}"],
};

export default { config };

export const AppDataSource: DataSource = new DataSource(config as DataSourceOptions);