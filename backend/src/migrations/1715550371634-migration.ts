import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1715550371634 implements MigrationInterface {
    name = 'Migration1715550371634'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Invoices" DROP COLUMN "amount"`);
        await queryRunner.query(`ALTER TABLE "Invoices" ADD "amount" numeric(10,2) NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Invoices" DROP COLUMN "amount"`);
        await queryRunner.query(`ALTER TABLE "Invoices" ADD "amount" integer NOT NULL`);
    }

}