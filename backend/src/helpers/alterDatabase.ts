import { DataSource } from 'typeorm';
import { AppDataSource } from "../config/ormconfig";

export async function alterColumns(): Promise<void> {
  const queryRunner = AppDataSource.createQueryRunner();
  
  await queryRunner.connect();
  
  try {

    // Add foreign key constraint between Reviews and Trips
    await queryRunner.query(`
      ALTER TABLE "Reviews" 
      ADD CONSTRAINT "FK_1b5cb7633ec0e7c58dd841b7689" 
      FOREIGN KEY ("tripId") 
      REFERENCES "Trips"("id") 
      ON DELETE NO ACTION 
      ON UPDATE NO ACTION;
    `);
    // console.log(`Added foreign key constraint between Reviews and Trips`);

    // Modify transaction id to be auto-increment
    await queryRunner.query(`
      ALTER TABLE "Transactions" 
      ALTER COLUMN "id" 
      SET DEFAULT nextval('"Transactions_id_seq"'::regclass);
    `);
    // console.log(`Modified Transactions id to be auto-increment`);

    // Add new column to Tracker table
    // if (!(await checkColumnExistence('Tracker', 'place'))) {
    //   await queryRunner.query(`ALTER TABLE "Tracker" ADD COLUMN "place" VARCHAR(255);`);
    //   console.log(`Added column: place in table: Tracker`);
    // } else {
    //   console.log(`Column 'place' already exists in table 'Tracker'`);
    // }

    // Set default value for currency column in Wallet table
    await queryRunner.query(`
      ALTER TABLE "Wallet" 
      ALTER COLUMN "currency" 
      SET DEFAULT 'SAR';
    `);
    // console.log(`Set default value for currency column in Wallet table`);

    // console.log('Database schema alterations completed successfully.');
  } catch (err: any) {
    console.error('Error altering columns:', err.stack);
  } finally {
    await queryRunner.release();
  }
}
