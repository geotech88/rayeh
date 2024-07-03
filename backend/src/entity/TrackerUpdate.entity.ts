import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Tracker } from "./Tracker.entity";

@Entity({ name: 'TrackerUpdates' })
export class TrackerUpdate {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => Tracker, tracker => tracker.updates)
    tracker: Tracker;

    @Column({ nullable: false })
    name: string;

    @Column({ nullable: false })
    date: Date;

    @Column({ nullable: false })
    timing: string;

    @Column({ nullable: false })
    place: string;

    @CreateDateColumn()
    createdAt: Date;
}
