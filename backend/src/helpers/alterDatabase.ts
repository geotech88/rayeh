import { DataSource } from 'typeorm';
import { AppDataSource } from "../config/ormconfig";

export async function alterColumns(): Promise<void> {
  const queryRunner = AppDataSource.createQueryRunner();
  
  await queryRunner.connect();
  
  try {

    // Add foreign key constraint between Reviews and Trips
    // await queryRunner.query(`
    //   ALTER TABLE "Reviews" 
    //   ADD CONSTRAINT "FK_1b5cb7633ec0e7c58dd841b7689" 
    //   FOREIGN KEY ("tripId") 
    //   REFERENCES "Trips"("id") 
    //   ON DELETE NO ACTION 
    //   ON UPDATE NO ACTION;
    // `);
    // await queryRunner.query(`CREATE TABLE "Conversation" ("id" SERIAL NOT NULL, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "senderUserId" integer, "receiverUserId" integer, CONSTRAINT "PK_d85d78217c1fe814df6326f8cdc" PRIMARY KEY ("id"))`);
    // await queryRunner.query(`CREATE TABLE "Operations" ("id" SERIAL NOT NULL, "amount" integer NOT NULL, "accountNumber" character varying NOT NULL, "pending" boolean NOT NULL DEFAULT true, "status" character varying, "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "userId" integer, CONSTRAINT "PK_3c348450b7794168bb37c7ef4ac" PRIMARY KEY ("id"))`);

    // // console.log(`Added foreign key constraint between Reviews and Trips`);

    // // Modify transaction id to be auto-increment
    // // await queryRunner.query(`
    // //   ALTER TABLE "Transactions" 
    // //   ALTER COLUMN "id" 
    // //   SET DEFAULT nextval('"Transactions_id_seq"'::regclass);
    // // `);
    // await queryRunner.query(`ALTER TABLE "Message" DROP COLUMN "senderUserId"`);
    // await queryRunner.query(`ALTER TABLE "Message" DROP COLUMN "receiverUserId"`);
    // await queryRunner.query(`ALTER TABLE "Message" ADD "conversationId" integer`);
    // await queryRunner.query(`ALTER TABLE "Message" ADD CONSTRAINT "FK_1c6f2c392c2c3c43f5287ced8d9" FOREIGN KEY ("conversationId") REFERENCES "Conversation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    // // console.log(`Modified Transactions id to be auto-increment`);
    // await queryRunner.query(`ALTER TABLE "Conversation" ADD CONSTRAINT "FK_ccb97e1a13f54e72687452c5924" FOREIGN KEY ("senderUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    // await queryRunner.query(`ALTER TABLE "Conversation" ADD CONSTRAINT "FK_89e4902f4eadff37c15bf8671f8" FOREIGN KEY ("receiverUserId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    // // Add new column to Tracker table
    // await queryRunner.query(`ALTER TABLE "Operations" ADD CONSTRAINT "FK_dcb1c1218c8361ada88e8e8bfc3" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    // await queryRunner.query(`CREATE TABLE "conversation_trips_trips" ("conversationId" integer NOT NULL, "tripsId" integer NOT NULL, CONSTRAINT "PK_d54d5dcc689c20c707af392a40b" PRIMARY KEY ("conversationId", "tripsId"))`);
    // await queryRunner.query(`CREATE INDEX "IDX_e03fa540375874fac2aef4a4fc" ON "conversation_trips_trips" ("conversationId") `);
    // await queryRunner.query(`CREATE INDEX "IDX_03829a54b6405b6713ad05e656" ON "conversation_trips_trips" ("tripsId") `);
    // await queryRunner.query(`ALTER TABLE "conversation_trips_trips" ADD CONSTRAINT "FK_e03fa540375874fac2aef4a4fca" FOREIGN KEY ("conversationId") REFERENCES "Conversation"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
    // await queryRunner.query(`ALTER TABLE "conversation_trips_trips" ADD CONSTRAINT "FK_03829a54b6405b6713ad05e6565" FOREIGN KEY ("tripsId") REFERENCES "Trips"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
      // await queryRunner.query(`ALTER TABLE "Message" ADD "userId" integer`);
      // await queryRunner.query(`ALTER TABLE "Message" ADD CONSTRAINT "FK_84d835397d0526ad7d04ef354e1" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    // await queryRunner.query(`ALTER TABLE "Request" ADD "service" character varying NOT NULL`);
    // await queryRunner.query(`ALTER TABLE "Trips" ADD "service" character varying`);
    await queryRunner.query(`ALTER TABLE "Conversation" ADD "lastTripId" integer`);
    // if (!(await checkColumnExistence('Tracker', 'place'))) {
    //   await queryRunner.query(`ALTER TABLE "Tracker" ADD COLUMN "place" VARCHAR(255);`);
    //   console.log(`Added column: place in table: Tracker`);
    // } else {
    //   console.log(`Column 'place' already exists in table 'Tracker'`);
    // }

    // Set default value for currency column in Wallet table
    // await queryRunner.query(`
    //   ALTER TABLE "Wallet" 
    //   ALTER COLUMN "currency" 
    //   SET DEFAULT 'SAR';
    // `);
    // console.log(`Set default value for currency column in Wallet table`);

    // console.log('Database schema alterations completed successfully.');
  } catch (err: any) {
    console.error('Error altering columns:', err.stack);
  } finally {
    await queryRunner.release();
  }
}
