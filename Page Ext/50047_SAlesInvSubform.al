pageextension 50047 saleinvline extends "Sales Invoice Subform"
{
    layout
    {
        addafter("TotalSalesLine.""Line Amount""")
        {
            field(LineAMt; TotalSalesLine."Line Amount")
            {
                ApplicationArea = Basic, Suite;
                //AutoFormatExpression = Currency.Code;
                //AutoFormatType = 1;
                //CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code, TotalSalesHeader."Prices Including VAT");
                Caption = 'Subtotal Excl.';
                Editable = false;
                ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.';
            }
            field("Total Amount Excl. VAT1"; TotalSalesLine.Amount)
            {
                ApplicationArea = Basic, Suite;
                //               AutoFormatExpression = Currency.Code;
                //AutoFormatType = 1;
                //             CaptionClass = DocumentTotals.GetTotalExclVATCaption(Currency.Code);
                Caption = 'Total Amount Excl.';
                DrillDown = false;
                Editable = false;
                ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
            }

            field("Total Amount Incl. VAT1"; TotalSalesLine."Amount Including VAT")
            {
                ApplicationArea = Basic, Suite;
                //    AutoFormatExpression = Currency.Code;
                //   AutoFormatType = 1;
                //  CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                Caption = 'Total Amount Incl.';
                Editable = false;
                ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
            }
            field("Invoice Discount Amount1"; InvoiceDiscountAmount)
            {
                ApplicationArea = Basic, Suite;
                //   AutoFormatExpression = Currency.Code;
                //    AutoFormatType = 1;
                // CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(FieldCaption("Inv. Discount Amount"), Currency.Code);
                Caption = 'Invoice Discount Amount';
                Editable = InvDiscAmountEditable;
                ToolTip = 'Specifies a discount amount that is deducted from the value of the Total Incl. VAT field, based on sales lines where the Allow Invoice Disc. field is selected. You can enter or change the amount manually.';

                trigger OnValidate()
                var
                    DocumentTotals: Codeunit "Document Totals";
                begin
                    DocumentTotals.SalesDocTotalsNotUpToDate();
                    //  ValidateInvoiceDiscountAmount();
                end;
            }
        }
        modify("Total VAT Amount")
        {
            Visible = false;
        }

        modify("Invoice Discount Amount")
        {
            Visible = false;
        }
        modify("TotalSalesLine.""Line Amount""")
        {
            Caption = 'Subtotal Excl.';
            Visible = false;
        }
        modify("Total Amount Excl. VAT")
        {
            Visible = false;
        }
        modify("Total Amount Incl. VAT")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }
    }
}