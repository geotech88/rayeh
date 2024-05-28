import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1715269248276 implements MigrationInterface {
    name = 'Migration1715269248276'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Tracker" ADD "tripId" integer`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD CONSTRAINT "UQ_37d36117f596ca4114398cef066" UNIQUE ("tripId")`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD "tripId" integer`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "UQ_9928ad54f448b90a719334fdc05" UNIQUE ("tripId")`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD "invoiceId" integer`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "UQ_93b0e22bf2727fc5969cc81b386" UNIQUE ("invoiceId")`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD CONSTRAINT "FK_37d36117f596ca4114398cef066" FOREIGN KEY ("tripId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_9928ad54f448b90a719334fdc05" FOREIGN KEY ("tripId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_93b0e22bf2727fc5969cc81b386" FOREIGN KEY ("invoiceId") REFERENCES "Invoices"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_93b0e22bf2727fc5969cc81b386"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_9928ad54f448b90a719334fdc05"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP CONSTRAINT "FK_37d36117f596ca4114398cef066"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "UQ_93b0e22bf2727fc5969cc81b386"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP COLUMN "invoiceId"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "UQ_9928ad54f448b90a719334fdc05"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP COLUMN "tripId"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP CONSTRAINT "UQ_37d36117f596ca4114398cef066"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP COLUMN "tripId"`);
    }

}