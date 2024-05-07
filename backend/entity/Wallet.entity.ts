import { Column, CreateDateColumn, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";

@Entity({ name: 'Wallet'})
export class Wallet {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToOne(() => User, user => user.id)
    @JoinColumn()
    user: User;

    @Column()
    balance: number;

    @Column({nullable: false})
    currency: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}