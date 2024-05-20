import { Router } from 'express';
import { TransactionsController } from '../controllers/transactions.controller';

const transactionRouter = Router();

transactionRouter.get('/api/transaction/getalltransactions', TransactionsController.getAllTransactions);

transactionRouter.get('/api/transaction/gettransaction/:id', TransactionsController.getTransactionById);

transactionRouter.patch('/api/transaction/updateinvoice/:id', TransactionsController.updateTransactionInvoice);

transactionRouter.patch('/api/transaction/updatestatus/:id', TransactionsController.updateTransactionStatus);

transactionRouter.delete('/api/transaction/delete/:id', TransactionsController.deleteTransaction);

export { transactionRouter };