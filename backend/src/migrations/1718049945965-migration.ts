import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1718049945965 implements MigrationInterface {
    name = 'Migration1718049945965'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Message" ADD "userId" integer`);
        await queryRunner.query(`ALTER TABLE "Message" ADD CONSTRAINT "FK_84d835397d0526ad7d04ef354e1" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Message" DROP CONSTRAINT "FK_84d835397d0526ad7d04ef354e1"`);
        await queryRunner.query(`ALTER TABLE "Message" DROP COLUMN "userId"`);
    }

}
