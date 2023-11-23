pageextension 50021 SaleQuotesubformExt extends "Sales Quote Subform"
{
    layout
    {
        addafter("Subtotal Excl. VAT")
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
        modify("Subtotal Excl. VAT")
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
        addafter("Location Code")
        {

            field("Stock Qty"; Rec."Stock Qty")
            {
                Applicationarea = All;
            }
            field("Quote Status"; Rec."Quote Status")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin
                    if Rec."Quote Status" = Rec."Quote Status"::Lost then
                        Rec.TestField(Reason);
                end;
            }
            field(Reason; Rec.Reason)
            {
                Applicationarea = All;
            }
            field(Cancel; Rec.Cancel)
            {
                ApplicationArea = all;
            }

            field("Cancelation reason"; Rec."Cancelation reason")
            {
                Applicationarea = All;
            }
            field("Request Date"; Rec."Request Date")
            {
                Applicationarea = All;
            }
            field("Estimated Date"; Rec."Estimated Date")
            {
                Applicationarea = All;
            }
            field("Confirm Date"; Rec."Confirm Date")
            {
                Applicationarea = All;
            }

            field(Rate; Rec.Rate)
            {
                ApplicationArea = All;
            }
            field(Partially; Rec.Partially)
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    sh: Record "Sales Header";
                begin
                    sh.Reset();
                    sh.SetRange("No.", Rec."Document No.");
                    if sh.FindFirst() then begin
                        if sh.Status = sh.Status::Released then begin
                            if xRec.Partially = true then
                                Error('You can not modify the field once it is partially make to order');
                        end;
                    end;

                end;
            }

            field("Customer Part No."; Rec."Customer Part No.")
            {
                Applicationarea = All;
            }
            field("RFQ Doc No."; Rec."RFQ Doc No.")
            {
                Applicationarea = All;
            }
            field("RFQ Line No."; Rec."RFQ Line No.")
            {
                Applicationarea = All;
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                Applicationarea = All;
            }
            field(Brand; Rec.Brand)
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
            field("Margin is Less"; Rec."Margin is Less")
            {
                Applicationarea = All;
                Editable = false;
            }
            field("Price Status"; Rec."Price Status")
            {
                Editable = false;
                Applicationarea = All;
            }
            field("Allocation Status"; Rec."Allocation Status")
            {
                Editable = false;
                Applicationarea = All;
            }
            field("Remaining Approval Status"; Rec."Remaining Approval Status")
            {
                Editable = false;
                Applicationarea = All;
            }
            field("Margin Status"; Rec."Margin Status")
            {
                Editable = false;
                Applicationarea = All;
            }

        }

        modify("Unit Price")
        {
            //Visible = false;
            Caption = 'Quoted Price';
            trigger OnAfterValidate()
            var
                Sadapr: Record "Sada price List";
                RecItem: Record Item;
                SH: Record "Sales Header";
            begin
                /*
                if Rec."Document Type" = Rec."Document Type"::Quote then begin
                    RecItem.Reset();
                    RecItem.Get(Rec."No.");
                    if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
                        Sadapr.Reset();
                        Sadapr.SetRange("Item No. (MPN)", Rec."No.");
                        Sadapr.SetRange("Customer No.", Rec."Sell-to Customer No.");
                        Sadapr.SetFilter("Item Start Date", '>= %1', Rec."Posting Date");
                        Sadapr.SetFilter("Item Expiry Date", '<=%1', Rec."Posting Date");
                        if Sadapr.FindFirst() then begin
                            Rec."Unit Price" := Sadapr."DBC. (DCPL Price)";

                            if Rec."Unit Price" < (RecItem."Purchase price" + RecItem."Margin %") then begin
                                Rec."Margin is Less" := true;
                                Rec."Margin Status" := Rec."Margin Status"::"Pending For Approval";
                            end;
                            Message('Approval request sent to sales Head Due to margin is less then the mentioned in item');
                        end;
                    end;
                end;
*/
            end;
        }
        /*
        addafter("Unit of Measure Code")
        {
            field(UnitPrice; Rec."Unit Price")
            {
                Caption = 'Quoted Price';
                ApplicationArea = Basic, Suite;
                BlankZero = true;
                Editable = NOT IsBlankNumber;
                Enabled = NOT IsBlankNumber;
                ShowMandatory = (Rec.Type <> Rec.Type::" ") AND (Rec."No." <> '');
                ToolTip = 'Specifies the price for one unit on the sales line.';

                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }
*/

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