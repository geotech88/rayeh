import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1716894728110 implements MigrationInterface {
    name = 'Migration1716894728110'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Reviews" ADD "tripId" integer`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD CONSTRAINT "UQ_1b5cb7633ec0e7c58dd841b7689" UNIQUE ("tripId")`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD CONSTRAINT "FK_1b5cb7633ec0e7c58dd841b7689" FOREIGN KEY ("tripId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Reviews" DROP CONSTRAINT "FK_1b5cb7633ec0e7c58dd841b7689"`);
        await queryRunner.query(`ALTER TABLE "Reviews" DROP CONSTRAINT "UQ_1b5cb7633ec0e7c58dd841b7689"`);
        await queryRunner.query(`ALTER TABLE "Reviews" DROP COLUMN "tripId"`);
    }

}
