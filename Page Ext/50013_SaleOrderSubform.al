pageextension 50013 SaleOrderSubformExt extends "Sales Order Subform"
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
        /*
        modify("Unit Cost (LCY)")
        {
            caption = 'Unit Price';
        }
        modify("Line Amount")
        {
            caption = 'Line Amount';
        }
        */
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

            field(Brand; Rec.Brand)
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
            field("Commission %"; Rec."Commission %")
            {
                Applicationarea = All;
            }
            field("Fullfillment Type"; Rec."Fullfillment Type")
            {
                Applicationarea = All;
            }
            field("UID Date"; Rec."UID Date")
            {
                Applicationarea = All;
            }
            field("Part No."; Rec."Part No.")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin

                end;
            }

            field(UID; Rec.UID)
            {
                Editable = false;
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
            field("Line Approval Status"; Rec."Line Approval Status")
            {
                Applicationarea = All;
                Editable = false;
            }
            field("Allocation Status"; Rec."Allocation Status")
            {
                Applicationarea = All;
                Editable = false;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;

            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SH: Record "Sales Header";

            begin
                SH.Reset();
                SH.SetRange("No.", rec."Document No.");
                SH.SetRange("Document Type", rec."Document Type");
                if SH.FindFirst() then
                    rec."FAE Opportunity Document No." := SH."FAE Opportunity Document No.";
                rec.Modify();
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                RecItem: Record Item;
            begin
                RecItem.Reset();
                RecItem.SetRange("No.", Rec."No.");
                if RecItem.FindFirst() then begin
                    if Rec.Quantity < (2 * RecItem."MOQ(Minimum order Qty)") then begin
                        Error('You can use the quanity only multiplication of %1', (2 * RecItem."MOQ(Minimum order Qty)"));
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
                RunObject = page "SO Barcode Tracking";
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
        }
        addafter("Item Availability by")
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Send an approval request';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 50038;
                        RecItem: Record Item;
                        rfqline: Record "Sales Line";
                        approvalentry: Record "Approval Entry";
                        approvalentry1: Record "Approval Entry";
                    begin
                        /*
                                                rfqline.Reset();
                                                rfqline.SetRange("Document No.", Rec."Document No.");
                                                if rfqline.FindFirst() then begin
                                                    repeat
                                                        if rfqline."Line Approval Status" = rfqline."Line Approval Status"::Open then begin
                                                            rfqline."Line Approval Status" := rfqline."Line Approval Status"::"Pending For Approval";
                                                            RecItem.Reset();
                                                            RecItem.Get(rfqline."No.");
                                                            if rfqline."Allocation Status" = rfqline."Allocation Status"::Open then begin
                                                                if RecItem."Allocation Type" = RecItem."Allocation Type"::Allocate then
                                                                    rfqline."Allocation Status" := rfqline."Allocation Status"::"Pending For Approval";
                                                            end;
                                                            rfqline.Modify();
                                                        end;
                                                    until rfqline.Next() = 0;
                                                    Message('Approval Request has been sent');
                                                end;

                        */
                    END;
                }

                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = true;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 50038;
                    begin
                        /*
                        if Rec."Line Approval Status" = rec."Line Approval Status"::Approved then
                            Error('status should be pending for approval');
                        if Rec."Line Approval Status" = Rec."Line Approval Status"::"Pending For Approval" then begin
                            Rec."Line Approval Status" := Rec."Line Approval Status"::Open;
                            Rec.Modify();
                        end;
                        if Rec."Allocation Status" = Rec."Line Approval Status"::"Pending For Approval" then begin
                            Rec."Line Approval Status" := Rec."Line Approval Status"::Open;
                            Rec.Modify();
                        end;
*/
                    end;
                }
            }
        }
    }
    procedure SaleLineMasterScanBarcode(ScanBarcode: Code[20])
    var
        BarcCodeEntry: Codeunit BarCodeTracking;
        Itemrec: Record Item;
        BarCodeled: Record "Barcode Ledger Entry";
    begin
        if Rec.Type <> Rec.Type::Item then
            Error('Scanning can be only on Item Case');
        Itemrec.Get(Rec."No.");
        if Itemrec."Master Bar Code" = false then
            Error('You do not have permission to scan bar code');


        BarCodeled.reset;
        BarCodeled.setrange("Master Barcode No.", ScanBarcode);
        BarCodeled.SetRange("item No.", Rec."No.");
        if Not BarCodeled.FindFirst() then
            Error('Master Barcode does not exist in Barcode Ledger Entry');
        BarcCodeEntry.ScanBarcodesalesLine(true, false, false, ScanBarcode, Rec."Document No.", rec."Line No.", Rec."No.", Rec.Quantity, Rec."Location Code");
    end;


    procedure SaleLineCartonScanBarcode(ScanBarcode: Code[20])
    var
        BarcCodeEntry: Codeunit BarCodeTracking;
        Itemrec: Record Item;
        BarCodeled: Record "Barcode Ledger Entry";
    begin
        if Rec.Type <> Rec.Type::Item then
            Error('Scanning can be only on Item Case');
        Itemrec.Get(Rec."No.");
        if Itemrec."Sub Carton Bar Code" = false then
            Error('You do not have permission to scan bar code');

        BarCodeled.reset;
        BarCodeled.setrange(BarCodeled."Carton Barcode No.", ScanBarcode);
        BarCodeled.SetRange("item No.", Rec."No.");
        if Not BarCodeled.FindFirst() then
            Error('Carton Barcode does not exist in Barcode Ledger Entry');
        BarcCodeEntry.ScanBarcodesalesLine(false, true, false, ScanBarcode, Rec."Document No.", rec."Line No.", Rec."No.", Rec.Quantity, Rec."Location Code");
    end;

    procedure SaleLineProductScanBarcode(ScanBarcode: Code[20])
    var
        BarcCodeEntry: Codeunit BarCodeTracking;
        Itemrec: Record Item;
        BarCodeled: Record "Barcode Ledger Entry";
    begin
        if Rec.Type <> Rec.Type::Item then
            Error('Scanning can be only on Item Case');
        Itemrec.Get(Rec."No.");
        if Itemrec."Product Bar Code" = false then
            Error('You do not have permission to scan bar code');

        BarCodeled.reset;
        BarCodeled.setrange(BarCodeled."Product Barcode No.", ScanBarcode);
        BarCodeled.SetRange("item No.", Rec."No.");
        if Not BarCodeled.FindFirst() then
            Error('Product Barcode does not exist in Barcode Ledger Entry');
        BarcCodeEntry.ScanBarcodesalesLine(false, false, true, ScanBarcode, Rec."Document No.", rec."Line No.", Rec."No.", Rec.Quantity, Rec."Location Code");
    end;



    trigger OnDeleteRecord(): Boolean
    var
        ProductBarTracking: Record "SO Tracking";
    begin
        /*
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
*/
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