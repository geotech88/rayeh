import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1717963979549 implements MigrationInterface {
    name = 'Migration1717963979549'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "conversation_trips_trips" ("conversationId" integer NOT NULL, "tripsId" integer NOT NULL, CONSTRAINT "PK_d54d5dcc689c20c707af392a40b" PRIMARY KEY ("conversationId", "tripsId"))`);
        await queryRunner.query(`CREATE INDEX "IDX_e03fa540375874fac2aef4a4fc" ON "conversation_trips_trips" ("conversationId") `);
        await queryRunner.query(`CREATE INDEX "IDX_03829a54b6405b6713ad05e656" ON "conversation_trips_trips" ("tripsId") `);
        await queryRunner.query(`ALTER TABLE "conversation_trips_trips" ADD CONSTRAINT "FK_e03fa540375874fac2aef4a4fca" FOREIGN KEY ("conversationId") REFERENCES "Conversation"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "conversation_trips_trips" ADD CONSTRAINT "FK_03829a54b6405b6713ad05e6565" FOREIGN KEY ("tripsId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "conversation_trips_trips" DROP CONSTRAINT "FK_03829a54b6405b6713ad05e6565"`);
        await queryRunner.query(`ALTER TABLE "conversation_trips_trips" DROP CONSTRAINT "FK_e03fa540375874fac2aef4a4fca"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_03829a54b6405b6713ad05e656"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_e03fa540375874fac2aef4a4fc"`);
        await queryRunner.query(`DROP TABLE "conversation_trips_trips"`);
    }

}
