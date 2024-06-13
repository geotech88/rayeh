import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1718271517931 implements MigrationInterface {
    name = 'Migration1718271517931'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Request" ADD "service" character varying NOT NULL`);
        await queryRunner.query(`ALTER TABLE "Trips" ADD "service" character varying`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Trips" DROP COLUMN "service"`);
        await queryRunner.query(`ALTER TABLE "Request" DROP COLUMN "service"`);
    }

}
