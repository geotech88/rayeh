import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";

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
    status: string;

    @Column()
    delivered: boolean

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}