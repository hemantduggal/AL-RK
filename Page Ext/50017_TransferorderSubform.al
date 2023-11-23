pageextension 50017 TransOrderSubform extends "Transfer Order Subform"
{
    layout
    {
        modify(Description)
        {
            Caption = 'Manufacture Part No.';
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
                RunObject = page "TO Barcode Tracking";
                RunPageLink = "Document No." = field("Document No."), "Item Line No." = field("Line No."), "Item No." = field("Item No.");
                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if ItemRec.Get(Rec."Item No.") then begin
                        if ItemRec."Master Bar Code" = false then
                            Error('You do not have permission to open master barcodetracking');
                    end else
                        Error('You do not have permission to open master barcodetracking');
                end;

            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        POTracking: Record "Master Barcode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductBarTracking: Record "TO Tracking";
    begin
        Clear(POTracking);
        Clear(CartonTracking);
        Clear(ProductBarTracking);


        ProductBarTracking.Reset();
        ProductBarTracking.SetRange("Document No.", Rec."Document No.");
        ProductBarTracking.SetRange("Item No.", Rec."Item No.");
        ProductBarTracking.SetRange("Item Line No.", Rec."Line No.");
        ProductBarTracking.SetRange("Location Code", Rec."Transfer-from Code");
        if ProductBarTracking.FindFirst() then
            ProductBarTracking.DeleteAll();
    end;


    procedure TransferLineMasterScanBarcode(ScanBarcode: Code[20])
    var
        BarcCodeEntry: Codeunit BarCodeTracking;
        Itemrec: Record Item;
        BarCodeled: Record "Barcode Ledger Entry";
    begin

        Itemrec.Get(Rec."Item No.");
        if Itemrec."Master Bar Code" = false then
            Error('You do not have permission to scan bar code');


        BarCodeled.reset;
        BarCodeled.setrange("Master Barcode No.", ScanBarcode);
        BarCodeled.SetRange("item No.", Rec."Item No.");
        if Not BarCodeled.FindFirst() then
            Error('Master Barcode does not exist in Barcode Ledger Entry');
        BarcCodeEntry.ScanBarcodeTransferLine(true, false, false, ScanBarcode, Rec."Document No.", rec."Line No.", Rec."Item No.", Rec.Quantity, Rec."Transfer-from Code");
    end;


    procedure TransferLineCartonScanBarcode(ScanBarcode: Code[20])
    var
        BarcCodeEntry: Codeunit BarCodeTracking;
        Itemrec: Record Item;
        BarCodeled: Record "Barcode Ledger Entry";
    begin

        Itemrec.Get(Rec."Item No.");
        if Itemrec."Sub Carton Bar Code" = false then
            Error('You do not have permission to scan bar code');

        BarCodeled.reset;
        BarCodeled.setrange(BarCodeled."Carton Barcode No.", ScanBarcode);
        BarCodeled.SetRange("item No.", Rec."Item No.");
        if Not BarCodeled.FindFirst() then
            Error('Carton Barcode does not exist in Barcode Ledger Entry');
        BarcCodeEntry.ScanBarcodeTransferLine(false, true, false, ScanBarcode, Rec."Document No.", rec."Line No.", Rec."Item No.", Rec.Quantity, Rec."Transfer-from Code");
    end;

    procedure TransferLineProductScanBarcode(ScanBarcode: Code[20])
    var
        BarcCodeEntry: Codeunit BarCodeTracking;
        Itemrec: Record Item;
        BarCodeled: Record "Barcode Ledger Entry";
    begin

        Itemrec.Get(Rec."Item No.");
        if Itemrec."Product Bar Code" = false then
            Error('You do not have permission to scan bar code');

        BarCodeled.reset;
        BarCodeled.setrange(BarCodeled."Product Barcode No.", ScanBarcode);
        BarCodeled.SetRange("item No.", Rec."Item No.");
        if Not BarCodeled.FindFirst() then
            Error('Product Barcode does not exist in Barcode Ledger Entry');
        BarcCodeEntry.ScanBarcodeTransferLine(false, false, true, ScanBarcode, Rec."Document No.", rec."Line No.", Rec."Item No.", Rec.Quantity, Rec."Transfer-from Code");
    end;


}