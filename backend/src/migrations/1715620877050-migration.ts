import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1715620877050 implements MigrationInterface {
    name = 'Migration1715620877050'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "User" ADD CONSTRAINT "UQ_6d1138dd13a50db157a1874a2d4" UNIQUE ("auth0UserId")`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "User" DROP CONSTRAINT "UQ_6d1138dd13a50db157a1874a2d4"`);
    }

}