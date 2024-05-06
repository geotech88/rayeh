import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1715011239842 implements MigrationInterface {
    name = 'Migration1715011239842'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Offer" ADD "description" character varying NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Offer" DROP COLUMN "description"`);
    }

}
