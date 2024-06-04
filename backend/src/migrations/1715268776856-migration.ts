import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1715268776856 implements MigrationInterface {
    name = 'Migration1715268776856'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE IF NOT EXISTS "Trips" ("id" SERIAL NOT NULL, "from" character varying NOT NULL, "to" character varying NOT NULL, "date" TIMESTAMP NOT NULL, "description" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "PK_6e9261c9689c6b1f699b2270209" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE IF NOT EXISTS "Transaction" ("id" integer NOT NULL, "name" character varying NOT NULL, "status" integer NOT NULL, "senderId" integer, "receiverId" integer, CONSTRAINT "PK_21eda4daffd2c60f76b81a270e9" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP COLUMN "delivered"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP COLUMN "updatedAt"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP COLUMN "status"`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD "date" TIMESTAMP NOT NULL`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD "timing" character varying NOT NULL`);
        await queryRunner.query(`ALTER TABLE "Trips" ADD CONSTRAINT "FK_f81936822ecece94f4bfe323226" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_54ae8d4d6bf2e147b2a0dec3085" FOREIGN KEY ("senderId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_722fb45a092d58911663d815ad2" FOREIGN KEY ("receiverId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_722fb45a092d58911663d815ad2"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_54ae8d4d6bf2e147b2a0dec3085"`);
        await queryRunner.query(`ALTER TABLE "Trips" DROP CONSTRAINT "FK_f81936822ecece94f4bfe323226"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP COLUMN "timing"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP COLUMN "date"`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD "status" character varying NOT NULL`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD "delivered" boolean NOT NULL`);
        await queryRunner.query(`DROP TABLE "Transaction"`);
        await queryRunner.query(`DROP TABLE "Trips"`);
    }

}