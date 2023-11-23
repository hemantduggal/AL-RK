pageextension 50049 purinvline extends "Purch. Invoice Subform"
{
    layout
    {

        addafter(AmountBeforeDiscount)
        {
            field(LineAMt; TotalPurchaseLine."Line Amount")
            {
                ApplicationArea = Basic, Suite;
                //AutoFormatExpression = Currency.Code;
                //AutoFormatType = 1;
                //CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code, TotalSalesHeader."Prices Including VAT");
                Caption = 'Subtotal Excl.';
                Editable = false;
                ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.';
            }
            field("Total Amount Excl. VAT1"; TotalPurchaseLine.Amount)
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

            field("Total Amount Incl. VAT1"; TotalPurchaseLine."Amount Including VAT")
            {
                ApplicationArea = Basic, Suite;
                //    AutoFormatExpression = Currency.Code;
                //   AutoFormatType = 1;
                //  CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                Caption = 'Total Amount Incl.';
                Editable = false;
                ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
            }
            field(InvoiceDiscountAmount1; InvoiceDiscountAmount)
            {
                ApplicationArea = Basic, Suite;
                //   AutoFormatExpression = Currency.Code;
                //    AutoFormatType = 1;
                // CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(FieldCaption("Inv. Discount Amount"), Currency.Code);
                Caption = 'Invoice Discount Amount';
                Editable = false;
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

        modify(InvoiceDiscountAmount)
        {
            Visible = false;
        }
        modify(AmountBeforeDiscount)
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
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.Type := Rec.Type::Item;
    end;
}