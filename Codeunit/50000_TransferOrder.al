codeunit 50000 TranferOrder
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnBeforeCode', '', true, true)]
    local procedure "Item Jnl.-Post_OnBeforeCode"
    (
        var ItemJournalLine: Record "Item Journal Line";
        var HideDialog: Boolean;
        var SuppressCommit: Boolean;
        var IsHandled: Boolean
    )
    begin
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then
            ItemJournalLine."Applies-to Entry" := GetItemJNEntry(ItemJournalLine)
    end;


    procedure GetItemJNEntry(SL: Record "Item Journal Line"): Integer
    var
        ILE: Record "Item Ledger Entry";
        ProductTracking: Record "SO Tracking";
        ENT: Integer;
        BarcodLe: Record "Barcode Ledger Entry";
    begin
        Clear(ENT);
        ProductTracking.Reset();
        ProductTracking.SetRange("Document No.", SL."Document No.");
        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::"Item Journal Line");
        ProductTracking.SetRange(ProductTracking."Item Line No.", SL."Line No.");
        ProductTracking.SetRange("Item No.", SL."Item No.");
        if ProductTracking.FindFirst() then begin
            BarcodLe.Reset();
            BarcodLe.SetRange("item No.", ProductTracking."Item No.");
            BarcodLe.SetRange("Location Code", ProductTracking."Location Code");
            if ProductTracking."Master Barcode No." <> '' then
                BarcodLe.SetRange(BarcodLe."Master Barcode No.", ProductTracking."Master Barcode No.");
            if ProductTracking."Carton Barcode No." <> '' then
                BarcodLe.SetRange(BarcodLe."Carton Barcode No.", ProductTracking."Carton Barcode No.");
            if ProductTracking."Product Barcode No." <> '' then
                BarcodLe.SetRange(BarcodLe."Product Barcode No.", ProductTracking."Product Barcode No.");
            if BarcodLe.FindFirst() then
                ENT := BarcodLe."ILE No.";
        end;
        //     Error('%1', ENT);

        ILE.Reset();
        ILE.SetRange("Location Code", SL."Location Code");
        ILE.SetRange(ILE."Entry No.", ENT);
        ILE.SetFilter(Quantity, '>=%1', SL.Quantity);
        if ILE.FindFirst() then
            exit(ILE."Entry No.")
        else
            exit(0);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure "Item Jnl.-Post Line_OnAfterInitItemLedgEntry"
    (
        var NewItemLedgEntry: Record "Item Ledger Entry";
        var ItemJournalLine: Record "Item Journal Line";
        var ItemLedgEntryNo: Integer
    )
    var
        ITEMJn: Record "Item Journal Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchRcptHeader1: Record "Purch. Rcpt. Header";
        Item_Ty: Record Item;
        BarCOdeTracking: Record "Master Barcode Tracking";
        BarcodeEntry: Record "Barcode Ledger Entry";
        BarcodeEntry1: Record "Barcode Ledger Entry";
        ILERec: Record "Item Ledger Entry";

        faeHead: Record "FAE Header";
        SIH: Record "Sales Invoice Header";
        SIL: Record "Sales Invoice Line";
        TotLineAmt: Decimal;
        SL: Record "Sales Line";
        TotSLLineAmt: Decimal;
        totallineamt: Decimal;
        BarCOdeTracking1: Record "Master Barcode Tracking";
        CartonPOTracking1: Record "Carton BarCode Tracking";
        ProductPOTracking1: Record "Product BarCode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductTracking: Record "Product BarCode Tracking";
        ProductTracking2: Record "Item Journal Tracking";
        ProductTracking3: Record "Item Journal Tracking";
    begin
        NewItemLedgEntry."Item Barcode No." := ItemJournalLine."Item Barcode No.";
        if ItemJournalLine."Journal Template Name" = 'ITEM' then begin
            ITEMJn.Reset();
            ITEMJn.SetRange("Document No.", ItemJournalLine."Document No.");
            ITEMJn.SetRange("Line No.", ItemJournalLine."Line No.");
            if ITEMJn.FindFirst() then
                repeat
                    ProductPOTracking1.Reset();
                    ProductPOTracking1.SetRange("Document No.", ITEMJn."Document No.");
                    ProductPOTracking1.SetRange("Item Line No.", ITEMJn."Line No.");
                    ProductPOTracking1.SetRange("item No.", ITEMJn."Item No.");
                    if ProductPOTracking1.FindFirst() then begin
                        ProductTracking.Reset();
                        ProductTracking.SetRange("Document No.", ITEMJn."Document No.");
                        ProductTracking.SetRange(ProductTracking."Item Line No.", ITEMJn."Line No.");
                        ProductTracking.SetRange("Item No.", ITEMJn."Item No.");
                        if ProductTracking.FindFirst() then
                            repeat
                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                if NewItemLedgEntry."Document No." <> '' then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := NewItemLedgEntry."Document Type";
                                    BarcodeEntry."Document No." := NewItemLedgEntry."Document No.";
                                    BarcodeEntry."Location Code" := NewItemLedgEntry."Location Code";
                                    BarcodeEntry."Posting Date" := NewItemLedgEntry."Posting Date";
                                    BarcodeEntry."item No." := NewItemLedgEntry."Item No.";
                                    BarcodeEntry.Qty := 1;
                                    BarcodeEntry."Item Line No." := ITEMJn."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking."Product Barcode No.";
                                    BarcodeEntry."ILE No." := NewItemLedgEntry."Entry No.";
                                    BarcodeEntry.Modify();
                                end;

                                ProductTracking.Delete();
                            until ProductTracking.Next() = 0;
                    END Else begin

                        CartonPOTracking1.Reset();
                        CartonPOTracking1.SetRange("Document No.", ITEMJn."Document No.");
                        CartonPOTracking1.SetRange("Item Line No.", ITEMJn."Line No.");
                        CartonPOTracking1.SetRange("item No.", ITEMJn."Item No.");
                        if CartonPOTracking1.FindFirst() then begin

                            CartonTracking.Reset();
                            CartonTracking.SetRange("Document No.", ITEMJn."Document No.");
                            CartonTracking.SetRange(CartonTracking."Item Line No.", ITEMJn."Line No.");
                            CartonTracking.SetRange("Item No.", ITEMJn."Item No.");
                            if CartonTracking.FindFirst() then
                                repeat

                                    BarcodeEntry1.Reset();
                                    if BarcodeEntry1.FindLast() then;
                                    if NewItemLedgEntry."Document No." <> '' then begin

                                        BarcodeEntry.Init();
                                        BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                        BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                        BarcodeEntry.Insert();
                                        BarcodeEntry."Document Type" := NewItemLedgEntry."Document Type";
                                        BarcodeEntry."Document No." := NewItemLedgEntry."Document No.";
                                        BarcodeEntry."Location Code" := NewItemLedgEntry."Location Code";
                                        BarcodeEntry."Posting Date" := NewItemLedgEntry."Posting Date";
                                        BarcodeEntry."item No." := NewItemLedgEntry."Item No.";
                                        BarcodeEntry.Qty := 1;
                                        BarcodeEntry."Item Line No." := ITEMJn."Line No.";
                                        BarcodeEntry."Carton Barcode No." := CartonTracking."Carton Barcode No.";
                                        BarcodeEntry."Master Barcode No." := CartonTracking."Master Barcode No.";
                                        BarcodeEntry."ILE No." := NewItemLedgEntry."Entry No.";
                                        BarcodeEntry.Modify();
                                    end;

                                    CartonTracking.Delete();
                                until CartonTracking.Next() = 0;

                        END Else begin
                            BarCOdeTracking1.Reset();
                            BarCOdeTracking1.SetRange("Document No.", ITEMJn."Document No.");
                            BarCOdeTracking1.SetRange("Item Line No.", ITEMJn."Line No.");
                            BarCOdeTracking1.SetRange("item No.", ITEMJn."Item No.");
                            if BarCOdeTracking1.FindFirst() then begin
                                BarCOdeTracking.Reset();
                                BarCOdeTracking.SetRange("Document No.", ITEMJn."Document No.");
                                BarCOdeTracking.SetRange(BarCOdeTracking."Item Line No.", ITEMJn."Line No.");
                                BarCOdeTracking.SetRange("Item No.", ITEMJn."Item No.");
                                if BarCOdeTracking.FindFirst() then
                                    repeat
                                        BarcodeEntry1.Reset();
                                        if BarcodeEntry1.FindLast() then;
                                        if NewItemLedgEntry."Document No." <> '' then begin
                                            BarcodeEntry.Init();
                                            BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                            BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                            BarcodeEntry.Insert();
                                            BarcodeEntry."Document Type" := NewItemLedgEntry."Document Type";
                                            BarcodeEntry."Document No." := NewItemLedgEntry."Document No.";
                                            BarcodeEntry."Location Code" := NewItemLedgEntry."Location Code";
                                            BarcodeEntry."Posting Date" := NewItemLedgEntry."Posting Date";
                                            BarcodeEntry."item No." := NewItemLedgEntry."Item No.";
                                            BarcodeEntry.Qty := 1;
                                            BarcodeEntry."Item Line No." := ITEMJn."Line No.";
                                            BarcodeEntry."Master Barcode No." := BarCOdeTracking."Carton Barcode No.";
                                            BarcodeEntry."ILE No." := NewItemLedgEntry."Entry No.";
                                            BarcodeEntry.Modify();
                                        end;
                                        BarCOdeTracking.Delete();
                                    until BarCOdeTracking.Next() = 0;
                            END;
                        end;
                    END;



                    ProductTracking2.Reset();
                    ProductTracking2.SetRange("Document No.", ITEMJn."Document No.");
                    ProductTracking2.SetRange("Item Line No.", ITEMJn."Line No.");
                    ProductTracking2.SetRange("item No.", ITEMJn."Item No.");
                    if ProductTracking2.FindFirst() then begin
                        ProductTracking3.Reset();
                        ProductTracking3.SetRange("Document No.", ITEMJn."Document No.");
                        ProductTracking3.SetRange("Entry Type", ProductTracking3."Entry Type"::"Item Journal Line");
                        ProductTracking3.SetRange(ProductTracking3."Item Line No.", ITEMJn."Line No.");
                        ProductTracking3.SetRange("Item No.", ITEMJn."Item No.");
                        if ProductTracking3.FindFirst() then
                            repeat
                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                if NewItemLedgEntry."Document No." <> '' then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := NewItemLedgEntry."Document Type";
                                    BarcodeEntry."Document No." := NewItemLedgEntry."Document No.";
                                    BarcodeEntry."Location Code" := NewItemLedgEntry."Location Code";
                                    BarcodeEntry."Posting Date" := NewItemLedgEntry."Posting Date";
                                    BarcodeEntry."item No." := NewItemLedgEntry."Item No.";
                                    BarcodeEntry.Qty := -1;
                                    BarcodeEntry."Item Line No." := ITEMJn."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking3."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking3."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking3."Product Barcode No.";
                                    BarcodeEntry."ILE No." := NewItemLedgEntry."Entry No.";
                                    BarcodeEntry.Modify();
                                end;
                                ProductTracking3.Delete();
                            until ProductTracking3.Next() = 0;
                    END;
                until ITEMJn.Next() = 0;
        END;
    END;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnAfterCreateItemJnlLine"
    (
        var ItemJournalLine: Record "Item Journal Line";
        TransferLine: Record "Transfer Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferShipmentLine: Record "Transfer Shipment Line"
    )

    begin
        ItemJournalLine."Applies-to Entry" := GetShipmentEntry(TransferLine);
    end;


    procedure GetShipmentEntry(SL: Record "Transfer Line"): Integer
    var
        ILE: Record "Item Ledger Entry";
        ProductTracking: Record "SO Tracking";
        ENT: Integer;
        BarcodLe: Record "Barcode Ledger Entry";
    begin
        Clear(ENT);
        ProductTracking.Reset();
        ProductTracking.SetRange("Document No.", SL."Document No.");
        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::Transfer);
        ProductTracking.SetRange(ProductTracking."Item Line No.", SL."Line No.");
        ProductTracking.SetRange("Item No.", SL."Item No.");
        if ProductTracking.FindFirst() then begin
            BarcodLe.Reset();
            BarcodLe.SetRange("item No.", ProductTracking."Item No.");
            BarcodLe.SetRange("Location Code", ProductTracking."Location Code");
            if ProductTracking."Master Barcode No." <> '' then
                BarcodLe.SetRange(BarcodLe."Master Barcode No.", ProductTracking."Master Barcode No.");
            if ProductTracking."Carton Barcode No." <> '' then
                BarcodLe.SetRange(BarcodLe."Carton Barcode No.", ProductTracking."Carton Barcode No.");
            if ProductTracking."Product Barcode No." <> '' then
                BarcodLe.SetRange(BarcodLe."Product Barcode No.", ProductTracking."Product Barcode No.");
            if BarcodLe.FindFirst() then
                ENT := BarcodLe."ILE No.";
        end;
        //     Error('%1', ENT);

        ILE.Reset();
        ILE.SetRange("Location Code", SL."Transfer-from Code");
        ILE.SetRange(ILE."Entry No.", ENT);
        ILE.SetFilter(Quantity, '>=%1', SL.Quantity);
        if ILE.FindFirst() then
            exit(ILE."Entry No.")
        else
            exit(0);
    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnRunOnBeforeCommit', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnRunOnBeforeCommit"
   (
       var TransferHeader: Record "Transfer Header";
       var TransferShipmentHeader: Record "Transfer Shipment Header";
       PostedWhseShptHeader: Record "Posted Whse. Shipment Header";
       var SuppressCommit: Boolean
   )
    var
        ITEMJ: Codeunit 22;
        Item_Ty: Record Item;
        BarCOdeTracking: Record "Master Barcode Tracking";
        BarcodeEntry: Record "Barcode Ledger Entry";
        BarcodeEntry1: Record "Barcode Ledger Entry";
        ILERec: Record "Item Ledger Entry";
        TLRec: Record "Transfer Line";
        BarCOdeTracking1: Record "Master Barcode Tracking";
        CartonPOTracking1: Record "Carton BarCode Tracking";
        ProductPOTracking1: Record "TO Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductTracking: Record "TO Tracking";
    begin
        if (TransferShipmentHeader."No." <> '') then begin
            TLRec.Reset();
            TLRec.SetRange("Document No.", TransferHeader."No.");
            if TLRec.FindFirst() then
                repeat
                    ProductPOTracking1.Reset();
                    ProductPOTracking1.SetRange("Document No.", TLRec."Document No.");
                    ProductPOTracking1.SetRange("Item Line No.", TLRec."Line No.");
                    ProductPOTracking1.SetRange("item No.", TLRec."Item No.");
                    if ProductPOTracking1.FindFirst() then begin
                        //                Message('Check2');
                        ProductTracking.Reset();
                        ProductTracking.SetRange("Document No.", TLRec."Document No.");
                        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::Transfer);
                        ProductTracking.SetRange(ProductTracking."Item Line No.", TLRec."Line No.");
                        ProductTracking.SetRange("Item No.", TLRec."Item No.");
                        if ProductTracking.FindFirst() then
                            repeat
                                //                      Message('Check3');
                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", TransferShipmentHeader."No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                if ILERec.FindFirst() then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Transfer;
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := ILERec."Document Type";
                                    BarcodeEntry."Document No." := ILERec."Document No.";
                                    BarcodeEntry."Location Code" := ILERec."Location Code";
                                    BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                    BarcodeEntry."item No." := ILERec."Item No.";
                                    BarcodeEntry.Qty := -1;
                                    BarcodeEntry."Item Line No." := TLRec."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking."Product Barcode No.";
                                    BarcodeEntry."ILE No." := ILERec."Entry No.";
                                    BarcodeEntry.Modify();
                                end;
                            until ProductTracking.Next() = 0;
                    END;
                until TLRec.Next() = 0;
        END;
    end;







    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeDeleteOneTransferHeader', '', true, true)]
    local procedure "TransferOrder-Post Receipt_OnBeforeDeleteOneTransferHeader"
    (
        TransferHeader: Record "Transfer Header";
        var DeleteOne: Boolean;
        TransferReceiptHeader: Record "Transfer Receipt Header"
    )
    var
        ITEMJ: Codeunit 22;
        Item_Ty: Record Item;
        BarCOdeTracking: Record "Master Barcode Tracking";
        BarcodeEntry: Record "Barcode Ledger Entry";
        BarcodeEntry1: Record "Barcode Ledger Entry";
        ILERec: Record "Item Ledger Entry";
        TLRec: Record "Transfer Line";
        BarCOdeTracking1: Record "Master Barcode Tracking";
        CartonPOTracking1: Record "Carton BarCode Tracking";
        ProductPOTracking1: Record "TO Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductTracking: Record "TO Tracking";
    begin
        if (TransferReceiptHeader."No." <> '') then begin
            TLRec.Reset();
            TLRec.SetRange("Document No.", TransferHeader."No.");
            if TLRec.FindFirst() then
                repeat
                    ProductPOTracking1.Reset();
                    ProductPOTracking1.SetRange("Document No.", TLRec."Document No.");
                    ProductPOTracking1.SetRange("Item Line No.", TLRec."Line No.");
                    ProductPOTracking1.SetRange("item No.", TLRec."Item No.");
                    if ProductPOTracking1.FindFirst() then begin
                        ProductTracking.Reset();
                        ProductTracking.SetRange("Document No.", TLRec."Document No.");
                        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::Transfer);
                        ProductTracking.SetRange(ProductTracking."Item Line No.", TLRec."Line No.");
                        ProductTracking.SetRange("Item No.", TLRec."Item No.");
                        if ProductTracking.FindFirst() then
                            repeat
                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", TransferReceiptHeader."No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                ILERec.SetFilter("Location Code", '<>%1', 'IN-TRANSIT');
                                if ILERec.FindFirst() then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Transfer;
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := ILERec."Document Type";
                                    BarcodeEntry."Document No." := ILERec."Document No.";
                                    BarcodeEntry."Location Code" := ILERec."Location Code";
                                    BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                    BarcodeEntry."item No." := ILERec."Item No.";
                                    BarcodeEntry.Qty := 1;
                                    BarcodeEntry."Item Line No." := TLRec."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking."Product Barcode No.";
                                    BarcodeEntry."ILE No." := ILERec."Entry No.";
                                    BarcodeEntry.Modify();
                                end;
                                ProductTracking.Delete();
                            until ProductTracking.Next() = 0;
                    END;
                until TLRec.Next() = 0;
        END;
    end;


    var
        myInt: Integer;
        TO: Page 5740;
}