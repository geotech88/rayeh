require("reflect-metadata");
import { Column, CreateDateColumn, Entity, JoinTable, ManyToMany, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Message } from "./Messages.entity";
import { User } from "./Users.entity";
import { Trips } from "./Trips.entity";

@Entity({name : 'Conversation'})
export class Conversation {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToMany(() => Message, message => message.conversation)
    messages: Message[];

    @ManyToOne(() => User, user => user.senderConversation)
    senderUser: User;

    @ManyToOne(() => User, user => user.receiverConversation)
    receiverUser: User;

    @ManyToMany(() => Trips, trips => trips.conversation)
    @JoinTable()
    trips: Trips[];

    @Column({nullable: true})
    lastTripId: number;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}