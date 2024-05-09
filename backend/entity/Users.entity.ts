import 'reflect-metadata';
import { Column, CreateDateColumn, Entity, JoinColumn, OneToMany, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Role } from "./Roles.entity";
import { Invoice } from "./Invoices.entity";
import { Message } from "./Messages.entity";
import { Offer } from "./Offers.entity";
import { Tracker } from "./Tracker.entity";
import { WalletLogs } from "./WalletLogs.entity";
import { Reviews } from "./Reviews.entity";

@Entity({ name: 'User'})
export class User {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({nullable: false})
    auth0UserId: string;

    @Column({nullable: false})
    name: string;

    @Column({nullable: false, unique: true})
    email: string;

    @OneToOne(() => Role, role => role.id)
    @JoinColumn()
    role: Role;

    @OneToMany(() => Invoice, invoice => invoice.user)
    invoices: Invoice[];

    @OneToMany(() => Message, message => message.senderUser)
    senderMessages: Message[];
    
    @OneToMany(() => Message, message => message.receiverUser)
    receiverMessages: Message[];

    @OneToMany(()=> Tracker, tracker => tracker.senderUser)
    senderTrackers: Tracker[];

    @OneToMany(()=> Tracker, tracker => tracker.receiverUser)
    receiverTrackers: Tracker[];

    @OneToMany(() => Offer, offer => offer.user)
    offers: Offer[];

    @OneToMany(() => WalletLogs, walletLogs => walletLogs.user)
    walletLogs: WalletLogs[];

    @OneToMany(() => Reviews, reviews => reviews.user)
    reviews: Reviews[];

    @OneToOne(() => User, user => user.id)
    reviewedUser: User;

    @Column({nullable: true})
    profession: string;

    @Column({nullable: false})
    path: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}