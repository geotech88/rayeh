require("reflect-metadata");
const { Column, Entity, ManyToOne, OneToOne, PrimaryGeneratedColumn } = require("typeorm");
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
