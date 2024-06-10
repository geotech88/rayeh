require("reflect-metadata");
import { Column, CreateDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";
import { Request } from "./Request.entity";
import { Conversation } from "./Conversation.entity";

@Entity({ name: 'Message'}) 
export class Message {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => Conversation, conversation => conversation.messages)
    conversation: Conversation;

    @OneToMany(() => Request, request => request.message)
    request: Request[];

    @Column({nullable: false})
    message: string;

    @Column({nullable: false})
    type: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;

}
