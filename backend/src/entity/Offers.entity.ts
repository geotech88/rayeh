import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./Users.entity";

@Entity({ name: 'Offer'})
export class Offer {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => User, user => user.offers)
    user: User;

    @Column({nullable: false})
    from: string;

    @Column({nullable: false})
    to: string;

    @Column({nullable: false})
    date: Date;

    @Column({nullable: false})
    description: string;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}