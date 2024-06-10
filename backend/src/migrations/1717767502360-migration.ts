import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1717767502360 implements MigrationInterface {
    name = 'Migration1717767502360'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "Role" ("id" SERIAL NOT NULL, "name" character varying NOT NULL, CONSTRAINT "PK_9309532197a7397548e341e5536" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Tracker" ("id" SERIAL NOT NULL, "name" character varying NOT NULL, "date" TIMESTAMP NOT NULL, "timing" character varying NOT NULL, "place" character varying, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "senderUserId" integer, "receiverUserId" integer, "tripId" integer, CONSTRAINT "REL_37d36117f596ca4114398cef06" UNIQUE ("tripId"), CONSTRAINT "PK_a89e172146a6a8de0caab70c7cc" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Reviews" ("id" SERIAL NOT NULL, "value" character varying NOT NULL, "rating" integer NOT NULL, "userId" integer, "tripId" integer, "reviewedUserId" integer, CONSTRAINT "REL_1b5cb7633ec0e7c58dd841b768" UNIQUE ("tripId"), CONSTRAINT "REL_d35e4f965fb0315258de04f006" UNIQUE ("reviewedUserId"), CONSTRAINT "PK_5ae106da7bc18dc3731e48a8a94" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Request" ("id" SERIAL NOT NULL, "from" character varying NOT NULL, "to" character varying NOT NULL, "price" character varying NOT NULL, "cost" character varying NOT NULL, "date" TIMESTAMP NOT NULL, "messageId" integer, CONSTRAINT "PK_23de24dc477765bcc099feae8e5" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Message" ("id" SERIAL NOT NULL, "message" character varying NOT NULL, "type" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "conversationId" integer, CONSTRAINT "PK_7dd6398f0d1dcaf73df342fa325" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Conversation" ("id" SERIAL NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "senderUserId" integer, "receiverUserId" integer, CONSTRAINT "PK_d85d78217c1fe814df6326f8cdc" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Trips" ("id" SERIAL NOT NULL, "from" character varying NOT NULL, "to" character varying NOT NULL, "date" TIMESTAMP NOT NULL, "description" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "PK_6e9261c9689c6b1f699b2270209" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Transaction" ("id" SERIAL NOT NULL, "name" character varying NOT NULL, "status" integer NOT NULL, "senderId" integer, "receiverId" integer, "tripId" integer, "invoiceId" integer, CONSTRAINT "REL_9928ad54f448b90a719334fdc0" UNIQUE ("tripId"), CONSTRAINT "REL_93b0e22bf2727fc5969cc81b38" UNIQUE ("invoiceId"), CONSTRAINT "PK_21eda4daffd2c60f76b81a270e9" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Invoices" ("id" SERIAL NOT NULL, "amount" numeric(10,2) NOT NULL, "paymentMethod" character varying NOT NULL, "currency" character varying NOT NULL, "status" character varying NOT NULL, "issueDate" TIMESTAMP NOT NULL, "dueDate" TIMESTAMP NOT NULL, "userId" integer, CONSTRAINT "PK_89f2f5f3cb6dc35e50b7c6ab8c2" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Operations" ("id" SERIAL NOT NULL, "amount" integer NOT NULL, "accountNumber" character varying NOT NULL, "pending" boolean NOT NULL DEFAULT true, "status" character varying, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "PK_3c348450b7794168bb37c7ef4ac" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "User" ("id" SERIAL NOT NULL, "auth0UserId" character varying NOT NULL, "name" character varying NOT NULL, "email" character varying NOT NULL, "profession" character varying, "path" character varying NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "roleId" integer, CONSTRAINT "UQ_6d1138dd13a50db157a1874a2d4" UNIQUE ("auth0UserId"), CONSTRAINT "UQ_4a257d2c9837248d70640b3e36e" UNIQUE ("email"), CONSTRAINT "REL_0b8c60cc29663fa5b9fb108edd" UNIQUE ("roleId"), CONSTRAINT "PK_9862f679340fb2388436a5ab3e4" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "WalletLogs" ("id" SERIAL NOT NULL, "balance" integer NOT NULL, "currency" character varying NOT NULL, "amount" integer NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "PK_6c2a8430bbc811fc29a3b953f3b" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Wallet" ("id" SERIAL NOT NULL, "balance" numeric(10,2) NOT NULL DEFAULT '0', "currency" character varying NOT NULL DEFAULT 'SAR', "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "REL_2f7aa51d6746fc8fc8ed63ddfb" UNIQUE ("userId"), CONSTRAINT "PK_8828fa4047435abf9287ff0e89e" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD CONSTRAINT "FK_bc0d02ddf217ba62ab6ba60b7fd" FOREIGN KEY ("senderUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD CONSTRAINT "FK_55c387ffe721ce1e8865cd3c8f7" FOREIGN KEY ("receiverUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Tracker" ADD CONSTRAINT "FK_37d36117f596ca4114398cef066" FOREIGN KEY ("tripId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD CONSTRAINT "FK_03697b4cf2383ce44b9b0ac3fda" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD CONSTRAINT "FK_1b5cb7633ec0e7c58dd841b7689" FOREIGN KEY ("tripId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Reviews" ADD CONSTRAINT "FK_d35e4f965fb0315258de04f0060" FOREIGN KEY ("reviewedUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Request" ADD CONSTRAINT "FK_234bf127f6a924de88678f8bbd1" FOREIGN KEY ("messageId") REFERENCES "Message"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Message" ADD CONSTRAINT "FK_1c6f2c392c2c3c43f5287ced8d9" FOREIGN KEY ("conversationId") REFERENCES "Conversation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Conversation" ADD CONSTRAINT "FK_ccb97e1a13f54e72687452c5924" FOREIGN KEY ("senderUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Conversation" ADD CONSTRAINT "FK_89e4902f4eadff37c15bf8671f8" FOREIGN KEY ("receiverUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Trips" ADD CONSTRAINT "FK_f81936822ecece94f4bfe323226" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_54ae8d4d6bf2e147b2a0dec3085" FOREIGN KEY ("senderId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_722fb45a092d58911663d815ad2" FOREIGN KEY ("receiverId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_9928ad54f448b90a719334fdc05" FOREIGN KEY ("tripId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Transaction" ADD CONSTRAINT "FK_93b0e22bf2727fc5969cc81b386" FOREIGN KEY ("invoiceId") REFERENCES "Invoices"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Invoices" ADD CONSTRAINT "FK_9c2859c28c8179e8e013cd091aa" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Operations" ADD CONSTRAINT "FK_dcb1c1218c8361ada88e8e8bfc3" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "User" ADD CONSTRAINT "FK_0b8c60cc29663fa5b9fb108edd7" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "WalletLogs" ADD CONSTRAINT "FK_734d85b47ed77be658668645bb0" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Wallet" ADD CONSTRAINT "FK_2f7aa51d6746fc8fc8ed63ddfbc" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Wallet" DROP CONSTRAINT "FK_2f7aa51d6746fc8fc8ed63ddfbc"`);
        await queryRunner.query(`ALTER TABLE "WalletLogs" DROP CONSTRAINT "FK_734d85b47ed77be658668645bb0"`);
        await queryRunner.query(`ALTER TABLE "User" DROP CONSTRAINT "FK_0b8c60cc29663fa5b9fb108edd7"`);
        await queryRunner.query(`ALTER TABLE "Operations" DROP CONSTRAINT "FK_dcb1c1218c8361ada88e8e8bfc3"`);
        await queryRunner.query(`ALTER TABLE "Invoices" DROP CONSTRAINT "FK_9c2859c28c8179e8e013cd091aa"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_93b0e22bf2727fc5969cc81b386"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_9928ad54f448b90a719334fdc05"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_722fb45a092d58911663d815ad2"`);
        await queryRunner.query(`ALTER TABLE "Transaction" DROP CONSTRAINT "FK_54ae8d4d6bf2e147b2a0dec3085"`);
        await queryRunner.query(`ALTER TABLE "Trips" DROP CONSTRAINT "FK_f81936822ecece94f4bfe323226"`);
        await queryRunner.query(`ALTER TABLE "Conversation" DROP CONSTRAINT "FK_89e4902f4eadff37c15bf8671f8"`);
        await queryRunner.query(`ALTER TABLE "Conversation" DROP CONSTRAINT "FK_ccb97e1a13f54e72687452c5924"`);
        await queryRunner.query(`ALTER TABLE "Message" DROP CONSTRAINT "FK_1c6f2c392c2c3c43f5287ced8d9"`);
        await queryRunner.query(`ALTER TABLE "Request" DROP CONSTRAINT "FK_234bf127f6a924de88678f8bbd1"`);
        await queryRunner.query(`ALTER TABLE "Reviews" DROP CONSTRAINT "FK_d35e4f965fb0315258de04f0060"`);
        await queryRunner.query(`ALTER TABLE "Reviews" DROP CONSTRAINT "FK_1b5cb7633ec0e7c58dd841b7689"`);
        await queryRunner.query(`ALTER TABLE "Reviews" DROP CONSTRAINT "FK_03697b4cf2383ce44b9b0ac3fda"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP CONSTRAINT "FK_37d36117f596ca4114398cef066"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP CONSTRAINT "FK_55c387ffe721ce1e8865cd3c8f7"`);
        await queryRunner.query(`ALTER TABLE "Tracker" DROP CONSTRAINT "FK_bc0d02ddf217ba62ab6ba60b7fd"`);
        await queryRunner.query(`DROP TABLE "Wallet"`);
        await queryRunner.query(`DROP TABLE "WalletLogs"`);
        await queryRunner.query(`DROP TABLE "User"`);
        await queryRunner.query(`DROP TABLE "Operations"`);
        await queryRunner.query(`DROP TABLE "Invoices"`);
        await queryRunner.query(`DROP TABLE "Transaction"`);
        await queryRunner.query(`DROP TABLE "Trips"`);
        await queryRunner.query(`DROP TABLE "Conversation"`);
        await queryRunner.query(`DROP TABLE "Message"`);
        await queryRunner.query(`DROP TABLE "Request"`);
        await queryRunner.query(`DROP TABLE "Reviews"`);
        await queryRunner.query(`DROP TABLE "Tracker"`);
        await queryRunner.query(`DROP TABLE "Role"`);
    }

}
