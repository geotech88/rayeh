require("reflect-metadata");
import { Column, CreateDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";
import { Request } from "./Request.entity";

@Entity({ name: 'Message'}) 
export class Message {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.senderMessages)
    senderUser: User;

    @ManyToOne(() => User, user => user.receiverMessages)
    receiverUser: User;

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
