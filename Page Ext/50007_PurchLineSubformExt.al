pageextension 50007 PurOrderSubform extends "Purchase order Subform"
{
    layout
    {

        addafter("Direct Unit Cost")
        {
            field(Commision; Rec.Commision)
            {
                ApplicationArea = all;

            }
            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = all;

            }
            field("Salvage Value"; Rec."Salvage Value")
            {
                ApplicationArea = all;

            }
        }
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
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                ph: Record "Purchase Header";
                recitem: Record Item;
            begin
                recitem.Reset();
                recitem.SetRange("No.", Rec."No.");
                if recitem.FindFirst() then begin
                    Rec.MOQ := recitem."Purchase MOQ Qty";
                    Rec."MOQ Value" := recitem."Purchase MOQ";
                    Rec.SPQ := recitem."SPQ(Std. product Qty)";
                    ph.Reset();
                    ph.setrange("No.", Rec."Document No.");
                    if ph.FindFirst() then begin
                        if ph."PO Type" = ph."PO Type"::Regular then
                            Rec.Quantity := 2 * recitem."SPQ(Std. product Qty)";
                    end;
                end;
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                ph: Record "Purchase Header";
                recitem: Record Item;
            begin
                recitem.Reset();
                recitem.SetRange("No.", Rec."No.");
                if recitem.FindFirst() then;
                ph.Reset();
                ph.SetRange("No.", Rec."Document No.");
                ph.SetRange("Document Type", Rec."Document Type");
                if ph.FindFirst() then begin
                    if ph."PO Type" = ph."PO Type"::Sample then begin
                        if Rec.Quantity > Rec.MOQ then
                            Error('Quantity should be less then the MOQ in line no. %1', Rec."Line No.");
                    end else begin
                        if ph."PO Type" = ph."PO Type"::Regular then begin
                            if Rec.Quantity < Rec."MOQ Value" then
                                Error('Quantity should not be less then the MOQ in line no. %1', Rec."Line No.");
                        end;
                    end;
                end;
                /*
                recitem.Reset();
                recitem.SetRange("No.", Rec."No.");
                if recitem.FindFirst() then begin
                    if Rec.Quantity <> (2 * recitem."SPQ(Std. product Qty)") then
                        Error('Quantity should be double the SPQ Qty mentioned in item card');
                end;
                */
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnBeforeValidate()
            var
                ph: Record "Purchase Header";
            begin
                ph.Reset();
                ph.SetRange("No.", Rec."Document No.");
                ph.SetRange("Document Type", Rec."Document Type");
                if ph.FindFirst() then begin
                    if ph."PO Type" = ph."PO Type"::Sample then begin
                        if Rec."Direct Unit Cost" > Rec."MOQ Value" then
                            Error('Line Amount should be less then the MOQ value in line no. %1', Rec."MOQ Value");
                    end else begin
                        if ph."PO Type" = ph."PO Type"::Regular then begin
                            if Rec."Direct Unit Cost" < Rec."MOQ Value" then
                                Error('Line Amount should not be less then the MOQ value in line no. %1', Rec."MOQ Value");
                        end;
                    end;


                end;
            end;
        }
    }


    actions
    {
        addafter("Item Availability by")
        {
            action(BarcodeTracking)
            {
                //Promoted = true;
                ApplicationArea = All;
                RunObject = page "Master Barcode Tracking";
                RunPageLink = "Document No." = field("Document No."), "Item Line No." = field("Line No."), "Item No." = field("No.");
                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if ItemRec.Get(Rec."No.") then begin
                        if ItemRec."Master Bar Code" = false then
                            Error('You do not have permission to open master barcodetracking');
                    end else
                        Error('You do not have permission to open master barcodetracking');
                end;

            }

            action("Barcode")
            {
                ApplicationArea = all;

                Image = Calculate;
                trigger OnAction()
                var

                    Barcodetrack: Codeunit BarCodeTracking;
                begin
                    Barcodetrack.scanbarcodepurchase(Rec);
                end;
            }
        }
    }



    trigger OnDeleteRecord(): Boolean
    var
        POTracking: Record "Master Barcode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductBarTracking: Record "Product BarCode Tracking";
    begin
        Clear(POTracking);
        Clear(CartonTracking);
        Clear(ProductBarTracking);

        POTracking.Reset();
        POTracking.SetRange("Document No.", Rec."Document No.");
        POTracking.SetRange("Item No.", Rec."No.");
        POTracking.SetRange("Item Line No.", Rec."Line No.");
        POTracking.SetRange("Location Code", Rec."Location Code");
        if POTracking.FindFirst() then
            POTracking.DeleteAll();

        CartonTracking.Reset();
        CartonTracking.SetRange("Document No.", Rec."Document No.");
        CartonTracking.SetRange("Item No.", Rec."No.");
        CartonTracking.SetRange("Item Line No.", Rec."Line No.");
        CartonTracking.SetRange("Location Code", Rec."Location Code");
        if CartonTracking.FindFirst() then
            CartonTracking.DeleteAll();

        ProductBarTracking.Reset();
        ProductBarTracking.SetRange("Document No.", Rec."Document No.");
        ProductBarTracking.SetRange("Item No.", Rec."No.");
        ProductBarTracking.SetRange("Item Line No.", Rec."Line No.");
        ProductBarTracking.SetRange("Location Code", Rec."Location Code");
        if ProductBarTracking.FindFirst() then
            ProductBarTracking.DeleteAll();
    end;

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