import 'reflect-metadata';
import { Column, Entity, ManyToOne, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Message } from "./Messages.entity";

@Entity({ name: 'Request'})
export class Request {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => Message, message => message.request)
    message: Message;

    @Column({nullable: false})
    from: string;

    @Column({nullable: false})
    to: string;

    @Column({nullable: false})
    price: string;

    @Column({nullable: false})
    cost: string;

    @Column({type: "timestamp", nullable: false})
    date: Date;
}

