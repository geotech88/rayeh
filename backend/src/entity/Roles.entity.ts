require("reflect-metadata");
import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./Users.entity";

@Entity({ name: 'Role'})
export class Role {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({nullable: false})
    name: string;

    @OneToOne(() => User, user => user.role)
    user: User;
}
