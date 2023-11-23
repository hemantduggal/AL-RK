pageextension 50025 postPurInvSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Invoice Discount Amount")
        {
            field("Invoice Discount Amount1"; TotalPurchInvHeader."Invoice Discount Amount")
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



            field("Total Amount Incl. VAT1"; TotalPurchInvHeader."Amount Including VAT")
            {
                ApplicationArea = Basic, Suite;
                //    AutoFormatExpression = Currency.Code;
                //   AutoFormatType = 1;
                //  CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                Caption = 'Total Amount Incl.';
                Editable = false;
                ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
            }

        }
        modify(Description)
        {
            Caption = 'Manufacture Part No.';
        }
        modify("Invoice Discount Amount")
        {
            Visible = false;
        }
        modify("Total Amount Excl. VAT")
        {
            Caption = 'Subtotal Excl.';
            Visible = false;
        }

        modify("Total VAT Amount")
        {
            Visible = false;
        }
        modify("Total Amount Incl. VAT")
        {
            Visible = false;
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
    }


}