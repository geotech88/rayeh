import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1716901636751 implements MigrationInterface {
    name = 'Migration1716901636751'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE SEQUENCE IF NOT EXISTS "Transaction_id_seq" OWNED BY "Transaction"."id"`);
        await queryRunner.query(`ALTER TABLE "Transaction" ALTER COLUMN "id" SET DEFAULT nextval('"Transaction_id_seq"')`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Transaction" ALTER COLUMN "id" DROP DEFAULT`);
        await queryRunner.query(`DROP SEQUENCE "Transaction_id_seq"`);
    }

}
