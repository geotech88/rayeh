import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1720034738428 implements MigrationInterface {
    name = 'Migration1720034738428'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "TrackerUpdates" ADD "place" character varying NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "TrackerUpdates" DROP COLUMN "place"`);
    }

}
