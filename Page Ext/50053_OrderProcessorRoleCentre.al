pageextension 50053 OrderProcessor extends "Order Processor Role Center"
{
    actions
    {
        addafter(Reports)
        {
            action(SaleRFQList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales RFQ List';
                Image = "Report";
                RunObject = page "Sale RFQ Order List";
            }
        }
        addafter(Customer)
        {
            group(CustomizedReports)
            {
                Caption = 'Customized Reports';
                action(PurchOrderReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Order Report';
                    Image = "Report";
                    RunObject = Report "Purchase Order Report";
                }
                action(DebitNote)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Debit Note Report';
                    Image = "Report";
                    RunObject = Report DebitNoteReport;
                }
                action(saleregister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sale Register Report';
                    Image = "Report";
                    RunObject = Report "Sales Register";
                }
                action(saleOrderReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sale Order Report';
                    Image = "Report";
                    RunObject = Report "Sales Order Report";
                }
                action(TaxinvoiceReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tax Invoice Report';
                    Image = "Report";
                    RunObject = Report TaxinvoiceReport;
                }
                action(salerfqReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sale RFQ Report';
                    Image = "Report";
                    RunObject = Report SalesRFQReport;
                }
                action(purchregisterReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Registerr Report';
                    Image = "Report";
                    RunObject = Report "Purchase Register";
                }
                action(ExportInvoiceReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Export Invoice Report';
                    Image = "Report";
                    RunObject = Report Export_Invoice_Report;
                }
                action(creditnoteReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Credit Note Report';
                    Image = "Report";
                    RunObject = Report CreditNote_Report;
                }
                action(packinglistReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Packing List Report';
                    Image = "Report";
                    RunObject = Report PackingListReport;
                }
                action(stocklistReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock List Report';
                    Image = "Report";
                    RunObject = Report StockListReportnew;
                }
                action(billwiseagingReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bill Wise Aging Report';
                    Image = "Report";
                    RunObject = Report BillwiseagingReportcopy;
                }
                action(SubLedgerReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sub Ledger Report';
                    Image = "Report";
                    RunObject = Report SubLedgerReport;
                }
                action(openingbalanceregisterReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Opening Balance Register Report';
                    Image = "Report";
                    RunObject = Report "Opening Balance Register";
                }
                action(openingstockregisterReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Opening Stock Report';
                    Image = "Report";
                    RunObject = Report "Opening Stock Register";
                }
                action(StockAgingAnalysisReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Aging Analysis Report';
                    Image = "Report";
                    RunObject = Report AgingAnalysisReport;
                }
                action(salesquotationReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'sales Quote Report';
                    Image = "Report";
                    RunObject = Report "Sale Quotation Report";
                }
                action(pendingsalequoteReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Sales Quote Report';
                    Image = "Report";
                    RunObject = Report PendingSalesQuote;
                }
                action(stockmovementReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Movement Report';
                    Image = "Report";
                    RunObject = Report StockMovement;
                }
                action(purchreturnReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Return Report';
                    Image = "Report";
                    RunObject = Report "Purchase Return Report";
                }
                action(pendingsalerfqReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Sale Rfq Report';
                    Image = "Report";
                    RunObject = Report "Pending Sales RFQ Report";
                }
                action(stockvaluationReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Valuation Report';
                    Image = "Report";
                    RunObject = Report "Stock Valuation New Report";
                }
                action(faeReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FAE Report';
                    Image = "Report";
                    RunObject = Report "FAE Report";
                }
                action(pendingsaleorderReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Sales Order Report';
                    Image = "Report";
                    RunObject = Report PendingSalesOrders;
                }
                action(pendingpurchordersReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Purchase Orders Report';
                    Image = "Report";
                    RunObject = Report PendingPurchOrders;
                }
                action(StockLedgerReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Return Report';
                    Image = "Report";
                    RunObject = Report "Stock Ledger Reports";
                }
                action(salereturnReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Return Report';
                    Image = "Report";
                    RunObject = Report "Sale Return Report";
                }
                action(cancelledSaleRfqReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancelled Sales RFQ Report';
                    Image = "Report";
                    RunObject = Report "Calc. Machine Center Calendar";
                }
            }
        }

    }
}