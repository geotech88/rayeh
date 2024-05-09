import 'reflect-metadata';
import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./Users.entity";

@Entity({ name: 'Invoices'})
export class Invoice {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.invoices)
    user: User;
    
    @Column()
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