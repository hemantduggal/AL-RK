pageextension 50005 PurQuoteSubform extends "Purchase Quote Subform"
{
    layout
    {
        addafter(AmountBeforeDiscount)
        {
            field(TotalPurchaseLine; TotalPurchaseLine."Line Amount")
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
            field("Invoice Discount Amount1"; InvoiceDiscountAmount)
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

        modify("Invoice Discount Amount")
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
        modify(Description)
        {
            Caption = 'Manufacture Part No.';
        }
        addafter(Description)
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                Applicationarea = All;
            }
            field("Requisition Line No."; Rec."Requisition Line No.")
            {
                Applicationarea = All;
            }
            field(Application; Rec.Application)
            {
                Applicationarea = All;
            }
            field(project; Rec.project)
            {
                Applicationarea = All;
            }

            field(POP; Rec.POP)
            {
                Applicationarea = All;
            }
            field(BQ; Rec.BQ)
            {
                Applicationarea = All;
            }
            field("End Customer"; Rec."End Customer")
            {
                Applicationarea = All;
            }
            field(LT; Rec.LT)
            {
                Applicationarea = All;
            }
            field(SPQ; Rec.SPQ)
            {
                Applicationarea = All;
            }
            field(MOQ; Rec.MOQ)
            {
                Applicationarea = All;
            }

        }

        addafter(Quantity)
        {
            field("Make Order Qty"; Rec."Make Order Qty")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin
                    if Rec."Make Order Qty" > Rec."Remaining Qty" then
                        Error('you can not order more then %1', Rec."Remaining Qty");
                end;
            }
            field("Remaining Qty"; Rec."Remaining Qty")
            {
                Applicationarea = All;
                Editable = false;
            }
            field("Total Qty"; Rec."Total Qty")
            {
                Applicationarea = All;
                Editable = false;
            }
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