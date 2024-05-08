import { Router } from 'express';
import { InvoicesController } from '../controllers/invoices.controller';

const invoiceRouter = Router();

invoiceRouter.post('/api/invoice/createinvoice', InvoicesController.createInvoice);

invoiceRouter.get('/api/invoice/getallinvoices', InvoicesController.getAllUserInvoices);

invoiceRouter.delete('/api/invoice/deleteinvoice/:id', InvoicesController.deleteInvoice);

export { invoiceRouter };