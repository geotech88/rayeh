require("reflect-metadata");
const { Column, Entity, ManyToOne, OneToOne, PrimaryGeneratedColumn, JoinColumn } = require("typeorm");
import { User } from "./Users.entity";

@Entity({ name: 'Reviews'})
export class Reviews {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.reviews)
    user: User;

    @OneToOne(() => User, user => user.reviewedUser)
    @JoinColumn()
    reviewedUser: User;

    @Column({nullable: false})
    value: string;
    
    @Column()
    rating: number;
}
