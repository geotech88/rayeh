import 'reflect-metadata';
import { Column, CreateDateColumn, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";


@Entity({ name: 'Wallet'})
export class Wallet {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToOne(() => User, user => user.id)
    @JoinColumn()
    user: User;

    @Column({type: 'decimal', precision: 10, scale: 2, default: 0.00})
    balance: number;

    @Column({default: 'USD'})
    currency: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}
