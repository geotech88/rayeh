import { Column, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryColumn } from "typeorm";
import { User } from "./Users.entity";
import { Trips } from "./Trips.entity";
import { Invoice } from "./Invoices.entity";

@Entity({ name: 'Transaction'})
export class Transaction {
    @PrimaryColumn()
    id: number;

    @ManyToOne(() => User, user => user.transaction_sender)
    sender: User;

    @ManyToOne(() => User, user => user.transaction_receiver)
    receiver: User;

    @Column({nullable: false})
    name: string;

    @Column()
    status: number;

    @OneToOne(() => Trips, trip => trip.transaction)
    @JoinColumn()
    trip: Trips;

    @OneToOne(() => Invoice, invoice => invoice.transaction, {nullable: true})
    @JoinColumn()
    invoice: Invoice;
}