import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1718374932079 implements MigrationInterface {
    name = 'Migration1718374932079'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Conversation" ADD "lastTripId" integer`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Conversation" DROP COLUMN "lastTripId"`);
    }

}
