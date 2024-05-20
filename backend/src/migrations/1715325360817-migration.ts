import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1715325360817 implements MigrationInterface {
    name = 'Migration1715325360817'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Request" ADD "date" TIMESTAMP NOT NULL`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD "reviewedUserId" integer`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD CONSTRAINT "UQ_d35e4f965fb0315258de04f0060" UNIQUE ("reviewedUserId")`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD CONSTRAINT "FK_d35e4f965fb0315258de04f0060" FOREIGN KEY ("reviewedUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Reviews" DROP CONSTRAINT "FK_d35e4f965fb0315258de04f0060"`);
        await queryRunner.query(`ALTER TABLE "Reviews" DROP CONSTRAINT "UQ_d35e4f965fb0315258de04f0060"`);
        await queryRunner.query(`ALTER TABLE "Reviews" DROP COLUMN "reviewedUserId"`);
        await queryRunner.query(`ALTER TABLE "Request" DROP COLUMN "date"`);
    }

}
