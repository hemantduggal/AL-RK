pageextension 50018 TransOrderExt extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            field(MasterScanBarcode; MasterScanBarcode)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //   IF GETLASTERRORTEXT <> '' THEN
                    //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                    CurrPage.TransferLines.PAGE.TransferLineMasterScanBarcode(MasterScanBarcode);
                    CLEAR(MasterScanBarcode);
                    CurrPage.UPDATE;
                end;
            }
            field(CartonScanBarcode; CartonScanBarcode)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //   IF GETLASTERRORTEXT <> '' THEN
                    //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                    CurrPage.TransferLines.PAGE.TransferLineCartonScanBarcode(CartonScanBarcode);
                    CLEAR(MasterScanBarcode);
                    CurrPage.UPDATE;
                end;
            }
            field(ProductScanBarcode; ProductScanBarcode)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //   IF GETLASTERRORTEXT <> '' THEN
                    //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                    CurrPage.TransferLines.PAGE.TransferLineProductScanBarcode(CartonScanBarcode);
                    CLEAR(MasterScanBarcode);
                    CurrPage.UPDATE;
                end;
            }
        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                TLRec: Record "Transfer Line";
                ItemRec: Record Item;
                BarCodeTrack: Record "TO Tracking";
            begin
                TLRec.Reset();
                TLRec.SetRange("Document No.", Rec."No.");
                TLRec.SetFilter("Qty. to Ship", '<>%1', 0);
                if TLRec.FindFirst() then
                    repeat
                        if ItemRec.Get(TLRec."Item No.") then begin
                            if ItemRec."Barcode Tracking" = true then begin
                                BarCodeTrack.Reset();
                                BarCodeTrack.SetRange("Document No.", TLRec."Document No.");
                                BarCodeTrack.SetRange("Item No.", TLRec."Item No.");
                                BarCodeTrack.SetRange("Entry Type", BarCodeTrack."Entry Type"::Transfer);
                                if Not BarCodeTrack.FindFirst() then
                                    Error('Please attach barcode tracking on this item %1', TLRec."Item No.");

                                BarCodeTrack.Reset();
                                BarCodeTrack.SetRange("Document No.", TLRec."Document No.");
                                BarCodeTrack.SetRange("Item No.", TLRec."Item No.");
                                BarCodeTrack.SetRange("Entry Type", BarCodeTrack."Entry Type"::Transfer);
                                BarCodeTrack.SetRange(BarCodeTrack."Carton Barcode No.", '');
                                if BarCodeTrack.FindFirst() then
                                    Error('Please attach Item Barcode No. on barcode tracking on this item %1', TLRec."Item No.");
                            end;
                        end;
                    until TLRec.Next() = 0;
            end;
        }
    }


    var
        MasterScanBarcode: Code[20];
        CartonScanBarcode: Code[20];
        ProductScanBarcode: Code[20];

}
