require("reflect-metadata");
import { CreateDateColumn, Entity, JoinColumn, ManyToMany, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
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
    @JoinColumn()
    trips: Trips[];

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}