require("reflect-metadata");
import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";


@Entity({name: 'Operations'})
export class Operations {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.operations)
    user: User;

    @Column({nullable: false})
    amount: number;

    @Column({nullable: false})
    accountNumber: string;

    @Column({default: true})
    pending: Boolean;

    @Column({nullable: true})
    status: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}