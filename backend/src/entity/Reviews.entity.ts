require("reflect-metadata");
import { Column, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";
import { Trips } from "./Trips.entity";

@Entity({ name: 'Reviews'})
export class Reviews {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.reviews)
    user: User;

    @OneToOne(() => Trips, trip => trip.review)
    @JoinColumn()
    trip: Trips;

    @OneToOne(() => User, user => user.reviewedUser)
    @JoinColumn()
    reviewedUser: User;

    @Column({nullable: false})
    value: string;
    
    @Column()
    rating: number;
}
