require("reflect-metadata");
const { Column, Entity, ManyToOne, OneToOne, PrimaryGeneratedColumn } = require("typeorm");
import { User } from "./Users.entity";
import { Transaction } from './Transaction.entity';

@Entity({ name: 'Invoices'})
export class Invoice {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.invoices)
    user: User;

    @OneToOne(() => Transaction, transaction => transaction.invoice)
    transaction: Transaction;
    
    @Column({type: 'decimal', precision: 10, scale: 2})
    amount: number;

    @Column({nullable: false})
    paymentMethod: string;

    @Column({nullable: false})
    currency: string;

    @Column({nullable: false})
    status: string;

    @Column({nullable: false})
    issueDate: Date;

    @Column({nullable: false})
    dueDate: Date;
}
