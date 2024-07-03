import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1720034469295 implements MigrationInterface {
    name = 'Migration1720034469295'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "TrackerUpdates" ("id" SERIAL NOT NULL, "name" character varying NOT NULL, "date" TIMESTAMP NOT NULL, "timing" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "trackerId" integer, CONSTRAINT "PK_2147e8b0312ed868343ad81f0f9" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "TrackerUpdates" ADD CONSTRAINT "FK_0ea01c223ef21632963e665fddc" FOREIGN KEY ("trackerId") REFERENCES "Tracker"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "TrackerUpdates" DROP CONSTRAINT "FK_0ea01c223ef21632963e665fddc"`);
        await queryRunner.query(`DROP TABLE "TrackerUpdates"`);
    }

}
