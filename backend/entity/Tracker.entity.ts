// import 'reflect-metadata';
require("reflect-metadata");
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";
import { Trips } from './Trips.entity';

@Entity({ name: 'Tracker'})
export class Tracker {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.senderTrackers)
    senderUser: User;

    @ManyToOne(() => User, user => user.receiverTrackers)
    receiverUser: User;

    @Column({nullable: false})
    name: string;

    @Column({nullable: false})
    date: Date;

    @Column({nullable: false})
    timing: string

    @OneToOne(() => Trips, trip => trip.tracker)
    @JoinColumn()
    trip: Trips;

    @CreateDateColumn()
    createdAt: Date;
}
