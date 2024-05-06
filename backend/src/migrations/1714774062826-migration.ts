import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1714774062826 implements MigrationInterface {
    name = 'Migration1714774062826'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "Role" ("id" SERIAL NOT NULL, "name" character varying NOT NULL, CONSTRAINT "PK_9309532197a7397548e341e5536" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Invoices" ("id" SERIAL NOT NULL, "amount" integer NOT NULL, "paymentMethod" character varying NOT NULL, "currency" character varying NOT NULL, "status" character varying NOT NULL, "issueDate" TIMESTAMP NOT NULL, "dueDate" TIMESTAMP NOT NULL, "userId" integer, CONSTRAINT "PK_89f2f5f3cb6dc35e50b7c6ab8c2" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Request" ("id" SERIAL NOT NULL, "from" character varying NOT NULL, "to" character varying NOT NULL, "price" character varying NOT NULL, "cost" character varying NOT NULL, "messageId" integer, CONSTRAINT "PK_23de24dc477765bcc099feae8e5" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Message" ("id" SERIAL NOT NULL, "message" character varying NOT NULL, "type" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "senderUserId" integer, "receiverUserId" integer, CONSTRAINT "PK_7dd6398f0d1dcaf73df342fa325" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Offer" ("id" SERIAL NOT NULL, "from" character varying NOT NULL, "to" character varying NOT NULL, "date" TIMESTAMP NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "PK_0ef6b03361b2e15ea4c60e1e536" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Tracker" ("id" SERIAL NOT NULL, "name" character varying NOT NULL, "status" character varying NOT NULL, "delivered" boolean NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "senderUserId" integer, "receiverUserId" integer, CONSTRAINT "PK_a89e172146a6a8de0caab70c7cc" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "User" ("id" SERIAL NOT NULL, "auth0UserId" character varying NOT NULL, "name" character varying NOT NULL, "email" character varying NOT NULL, "profession" character varying, "path" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "roleId" integer, CONSTRAINT "UQ_4a257d2c9837248d70640b3e36e" UNIQUE ("email"), CONSTRAINT "REL_0b8c60cc29663fa5b9fb108edd" UNIQUE ("roleId"), CONSTRAINT "PK_9862f679340fb2388436a5ab3e4" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "WalletLogs" ("id" SERIAL NOT NULL, "balance" integer NOT NULL, "currency" character varying NOT NULL, "amount" integer NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "PK_6c2a8430bbc811fc29a3b953f3b" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Wallet" ("id" SERIAL NOT NULL, "balance" integer NOT NULL, "currency" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "REL_2f7aa51d6746fc8fc8ed63ddfb" UNIQUE ("userId"), CONSTRAINT "PK_8828fa4047435abf9287ff0e89e" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "Invoices" ADD CONSTRAINT "FK_9c2859c28c8179e8e013cd091aa" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Request" ADD CONSTRAINT "FK_234bf127f6a924de88678f8bbd1" FOREIGN KEY ("messageId") REFERENCES "Message"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Message" ADD CONSTRAINT "FK_ef4851677ac12849e2f18dfd314" FOREIGN KEY ("senderUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Message" ADD CONSTRAINT "FK_2c62b76de47e0f6a12d6aeb06ce" FOREIGN KEY ("receiverUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Offer" ADD CONSTRAINT "FK_76b35aca75b2d657384efe3d075" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD CONSTRAINT "FK_bc0d02ddf217ba62ab6ba60b7fd" FOREIGN KEY ("senderUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD CONSTRAINT "FK_55c387ffe721ce1e8865cd3c8f7" FOREIGN KEY ("receiverUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "User" ADD CONSTRAINT "FK_0b8c60cc29663fa5b9fb108edd7" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "WalletLogs" ADD CONSTRAINT "FK_734d85b47ed77be658668645bb0" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Wallet" ADD CONSTRAINT "FK_2f7aa51d6746fc8fc8ed63ddfbc" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Wallet" DROP CONSTRAINT "FK_2f7aa51d6746fc8fc8ed63ddfbc"`);
        await queryRunner.query(`ALTER TABLE "WalletLogs" DROP CONSTRAINT "FK_734d85b47ed77be658668645bb0"`);
        await queryRunner.query(`ALTER TABLE "User" DROP CONSTRAINT "FK_0b8c60cc29663fa5b9fb108edd7"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP CONSTRAINT "FK_55c387ffe721ce1e8865cd3c8f7"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP CONSTRAINT "FK_bc0d02ddf217ba62ab6ba60b7fd"`);
        await queryRunner.query(`ALTER TABLE "Offer" DROP CONSTRAINT "FK_76b35aca75b2d657384efe3d075"`);
        await queryRunner.query(`ALTER TABLE "Message" DROP CONSTRAINT "FK_2c62b76de47e0f6a12d6aeb06ce"`);
        await queryRunner.query(`ALTER TABLE "Message" DROP CONSTRAINT "FK_ef4851677ac12849e2f18dfd314"`);
        await queryRunner.query(`ALTER TABLE "Request" DROP CONSTRAINT "FK_234bf127f6a924de88678f8bbd1"`);
        await queryRunner.query(`ALTER TABLE "Invoices" DROP CONSTRAINT "FK_9c2859c28c8179e8e013cd091aa"`);
        await queryRunner.query(`DROP TABLE "Wallet"`);
        await queryRunner.query(`DROP TABLE "WalletLogs"`);
        await queryRunner.query(`DROP TABLE "User"`);
        await queryRunner.query(`DROP TABLE "Tracker"`);
        await queryRunner.query(`DROP TABLE "Offer"`);
        await queryRunner.query(`DROP TABLE "Message"`);
        await queryRunner.query(`DROP TABLE "Request"`);
        await queryRunner.query(`DROP TABLE "Invoices"`);
        await queryRunner.query(`DROP TABLE "Role"`);
    }

}
