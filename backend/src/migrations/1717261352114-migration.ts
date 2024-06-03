import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1717261352114 implements MigrationInterface {
    name = 'Migration1717261352114'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Tracker" ADD "place" character varying`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Tracker" DROP COLUMN "place"`);
    }

}
