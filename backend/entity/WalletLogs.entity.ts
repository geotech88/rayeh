import 'reflect-metadata';
import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";

@Entity({ name: 'WalletLogs'})
export class WalletLogs {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.walletLogs)
    user: User;

    @Column()
    balance: number;

    @Column({nullable: false})
    currency: string;
    
    @Column()
    amount: number;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}
