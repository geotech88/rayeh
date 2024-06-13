import 'reflect-metadata';
import { Column, CreateDateColumn, Entity, ManyToMany, ManyToOne, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";
import { Tracker } from './Tracker.entity';
import { Transaction } from './Transaction.entity';
import { Reviews } from './Reviews.entity';
import { Conversation } from './Conversation.entity';

@Entity({ name: 'Trips'})
export class Trips {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.trips)
    user: User;

    @Column({nullable: false})
    from: string;

    @Column({nullable: false})
    to: string;

    @Column({nullable: false})
    date: Date;

    @Column({nullable: false})
    description: string;

    @Column({nullable: true})
    service: string;

    @OneToOne(() => Tracker, tracker => tracker.trip)
    tracker: Tracker;

    @OneToOne(() => Transaction, trip => trip.trip)
    transaction: Transaction;

    @OneToOne(() => Reviews, review => review.trip)
    review: Reviews;

    @ManyToMany(() => Conversation, conversation => conversation.trips)
    conversation: Conversation[];
    
    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}
