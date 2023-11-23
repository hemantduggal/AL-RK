codeunit 50043 allevents
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', false, false)]

    local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var ValueEntryNo: Integer; var ItemApplnEntryNo: Integer; GlobalValueEntry: Record "Value Entry"; TransferItem: Boolean; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; var OldItemLedgerEntry: Record "Item Ledger Entry")
    var
        RecItem: Record Item;
        recile: Record "Item Ledger Entry";
    begin
        // RecItem.reset;
        // RecItem.SetRange("No.", ItemLedgerEntry."Item No.");
        // if RecItem.FindFirst() then
        ItemLedgerEntry.Brand := ItemJournalLine.Brand;
        ItemLedgerEntry.Brand := ItemJournalLine.Brand;
        ItemLedgerEntry.SPQ := ItemJournalLine.SPQ;
        ItemLedgerEntry.MOQ := ItemJournalLine.MOQ;
        ItemLedgerEntry.LT := ItemJournalLine.LT;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]

    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry.Brand := ItemJournalLine.Brand;
        NewItemLedgEntry.Brand := ItemJournalLine.Brand;
        NewItemLedgEntry.SPQ := ItemJournalLine.SPQ;
        NewItemLedgEntry.MOQ := ItemJournalLine.MOQ;
        NewItemLedgEntry.LT := ItemJournalLine.LT;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry");
    var
        SalesPos: Codeunit 80;
        RecItem: Record Item;
    begin
        RecItem.Reset();
        RecItem.SetRange("No.", ItemLedgerEntry."Item No.");
        if RecItem.FindFirst() then
            ItemLedgerEntry.Description := RecItem.Description;


        ItemLedgerEntry."Requisition No." := ItemJournalLine."Requisition No.";
        ItemLedgerEntry."Requisition Line No." := ItemJournalLine."Requisition Line No.";
        ItemLedgerEntry.Brand := ItemJournalLine.Brand;
        ItemLedgerEntry.SPQ := ItemJournalLine.SPQ;
        ItemLedgerEntry.MOQ := ItemJournalLine.MOQ;
        ItemLedgerEntry.LT := ItemJournalLine.LT;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeader(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    var

    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line");
    var
        PH: Record "Purchase Header";
        RecItem: Record Item;
    begin

        ItemJnlLine.Description := PurchLine.Description;
        ItemJnlLine."Requisition No." := PurchLine."Requisition No.";
        ItemJnlLine."Requisition Line No." := PurchLine."Requisition Line No.";
        ItemJnlLine.SPQ := PurchLine.SPQ;
        ItemJnlLine.MOQ := PurchLine.MOQ;
        ItemJnlLine.LT := PurchLine.LT;
        ItemJnlLine.Brand := PurchLine."Brand Name";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]

    local procedure OnAfterCopyItemJnlLineFromSalesLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin
        ItemJnlLine.Brand := SalesLine.Brand;
        ItemJnlLine.SPQ := SalesLine.SPQ;
        ItemJnlLine.MOQ := SalesLine.MOQ;
        ItemJnlLine.LT := SalesLine.LT;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnCodeOnAfterItemJnlPostBatchRun', '', false, false)]

    local procedure OnCodeOnAfterItemJnlPostBatchRun(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; SuppressCommit: Boolean)
    var
        BarCOdeTracking: Record "Master Barcode Tracking";
        BarcodeEntry: Record "Barcode Ledger Entry";
        BarcodeEntry1: Record "Barcode Ledger Entry";
        ILERec: Record "Item Ledger Entry";
        TLRec: Record "Item Journal Line";
        BarCOdeTracking1: Record "Master Barcode Tracking";
        CartonPOTracking1: Record "Carton BarCode Tracking";
        ProductPOTracking1: Record "Product BarCode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductTracking: Record "Product BarCode Tracking";
    begin

        begin
            Message('Check1');
            //  if (SalesShptHdrNo <> '') OR (RetRcpHdrNo <> '') then begin
            TLRec.Reset();
            TLRec.SetRange("Document No.", ItemJournalLine."No.");
            if TLRec.FindFirst() then
                repeat
                    ProductPOTracking1.Reset();
                    ProductPOTracking1.SetRange("Document No.", TLRec."Document No.");
                    ProductPOTracking1.SetRange("Entry Type", ProductPOTracking1."Entry Type"::"Item Journal Line");
                    ProductPOTracking1.SetRange("Item Line No.", TLRec."Line No.");
                    ProductPOTracking1.SetRange("Location Code", TLRec."Location Code");
                    ProductPOTracking1.SetRange("item No.", TLRec."No.");
                    if ProductPOTracking1.FindFirst() then begin
                        Message('Check2');
                        ProductTracking.Reset();
                        ProductTracking.SetRange("Document No.", TLRec."Document No.");
                        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::"Item Journal Line");
                        ProductTracking.SetRange(ProductTracking."Item Line No.", TLRec."Line No.");
                        ProductTracking.SetRange("Item No.", TLRec."No.");
                        if ProductTracking.FindFirst() then
                            repeat
                                Message('Check3');
                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", ItemJournalLine."Document No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                if ILERec.FindFirst() then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := ILERec."Document Type";
                                    BarcodeEntry."Document No." := ILERec."Document No.";
                                    BarcodeEntry."Location Code" := ILERec."Location Code";
                                    BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                    BarcodeEntry."item No." := ILERec."Item No.";
                                    BarcodeEntry.Qty := ILERec.Quantity;
                                    BarcodeEntry."Item Line No." := TLRec."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking."Product Barcode No.";
                                    BarcodeEntry."ILE No." := ILERec."Entry No.";
                                    BarcodeEntry.Modify();
                                end;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", ItemJournalLine."Document No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                if ILERec.FindFirst() then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := ILERec."Document Type";
                                    BarcodeEntry."Document No." := ILERec."Document No.";
                                    BarcodeEntry."Location Code" := ILERec."Location Code";
                                    BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                    BarcodeEntry."item No." := ILERec."Item No.";
                                    BarcodeEntry.Qty := ILERec.Quantity;
                                    BarcodeEntry."Item Line No." := TLRec."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking."Product Barcode No.";
                                    BarcodeEntry."ILE No." := ILERec."Entry No.";
                                    BarcodeEntry.Modify();
                                end;
                            until ProductTracking.Next() = 0;
                    END Else begin
                        CartonPOTracking1.Reset();
                        CartonPOTracking1.SetRange("Document No.", TLRec."Document No.");
                        CartonPOTracking1.SetRange("Entry Type", CartonPOTracking1."Entry Type"::"Item Journal Line");
                        CartonPOTracking1.SetRange("Item Line No.", TLRec."Line No.");
                        CartonPOTracking1.SetRange("Location Code", TLRec."Location Code");
                        CartonPOTracking1.SetRange("item No.", TLRec."No.");
                        if CartonPOTracking1.FindFirst() then begin
                            CartonTracking.Reset();
                            CartonTracking.SetRange("Document No.", TLRec."Document No.");
                            CartonTracking.SetRange("Entry Type", CartonTracking."Entry Type"::"Item Journal Line");
                            CartonTracking.SetRange(CartonTracking."Item Line No.", TLRec."Line No.");
                            CartonTracking.SetRange("Item No.", TLRec."No.");
                            if CartonTracking.FindFirst() then
                                repeat
                                    BarcodeEntry1.Reset();
                                    if BarcodeEntry1.FindLast() then;
                                    ILERec.Reset();
                                    ILERec.SetRange("Document No.", ItemJournalLine."Document No.");
                                    ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                    if ILERec.FindFirst() then begin
                                        BarcodeEntry.Init();
                                        BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                        BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                        BarcodeEntry.Insert();
                                        BarcodeEntry."Document Type" := ILERec."Document Type";
                                        BarcodeEntry."Document No." := ILERec."Document No.";
                                        BarcodeEntry."Location Code" := ILERec."Location Code";
                                        BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                        BarcodeEntry."item No." := ILERec."Item No.";
                                        BarcodeEntry.Qty := ILERec.Quantity;
                                        BarcodeEntry."Item Line No." := TLRec."Line No.";
                                        BarcodeEntry."Carton Barcode No." := CartonTracking."Carton Barcode No.";
                                        BarcodeEntry."Master Barcode No." := CartonTracking."Master Barcode No.";
                                        BarcodeEntry."ILE No." := ILERec."Entry No.";
                                        BarcodeEntry.Modify();
                                    end;
                                    ILERec.Reset();
                                    ILERec.SetRange("Document No.", ItemJournalLine."Document No.");
                                    ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                    if ILERec.FindFirst() then begin
                                        BarcodeEntry.Init();
                                        BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                        BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                        BarcodeEntry.Insert();
                                        BarcodeEntry."Document Type" := ILERec."Document Type";
                                        BarcodeEntry."Document No." := ILERec."Document No.";
                                        BarcodeEntry."Location Code" := ILERec."Location Code";
                                        BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                        BarcodeEntry."item No." := ILERec."Item No.";
                                        BarcodeEntry.Qty := ILERec.Quantity;
                                        BarcodeEntry."Item Line No." := TLRec."Line No.";
                                        BarcodeEntry."Carton Barcode No." := CartonTracking."Carton Barcode No.";
                                        BarcodeEntry."Master Barcode No." := CartonTracking."Master Barcode No.";
                                        BarcodeEntry."ILE No." := ILERec."Entry No.";
                                        BarcodeEntry.Modify();
                                    end;
                                until CartonTracking.Next() = 0;

                        END Else begin
                            BarCOdeTracking1.Reset();
                            BarCOdeTracking1.SetRange("Document No.", TLRec."Document No.");
                            BarCOdeTracking1.SetRange(BarCOdeTracking1."Entry Type", BarCOdeTracking1."Entry Type"::"Item Journal Line");
                            BarCOdeTracking1.SetRange("Item Line No.", TLRec."Line No.");
                            BarCOdeTracking1.SetRange("Location Code", TLRec."Location Code");
                            BarCOdeTracking1.SetRange("item No.", TLRec."No.");
                            if BarCOdeTracking1.FindFirst() then begin
                                BarCOdeTracking.Reset();
                                BarCOdeTracking.SetRange("Document No.", TLRec."Document No.");
                                BarCOdeTracking.SetRange(BarCOdeTracking."Entry Type", BarCOdeTracking."Entry Type"::"Item Journal Line");
                                BarCOdeTracking.SetRange(BarCOdeTracking."Item Line No.", TLRec."Line No.");
                                BarCOdeTracking.SetRange("Item No.", TLRec."No.");
                                if BarCOdeTracking.FindFirst() then
                                    repeat
                                        BarcodeEntry1.Reset();
                                        if BarcodeEntry1.FindLast() then;
                                        ILERec.Reset();
                                        ILERec.SetRange("Document No.", ItemJournalLine."Document No.");
                                        ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                        if ILERec.FindFirst() then begin
                                            BarcodeEntry.Init();
                                            BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                            BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                            BarcodeEntry.Insert();
                                            BarcodeEntry."Document Type" := ILERec."Document Type";
                                            BarcodeEntry."Document No." := ILERec."Document No.";
                                            BarcodeEntry."Location Code" := ILERec."Location Code";
                                            BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                            BarcodeEntry."item No." := ILERec."Item No.";
                                            BarcodeEntry.Qty := ILERec.Quantity;
                                            BarcodeEntry."Item Line No." := TLRec."Line No.";
                                            BarcodeEntry."Master Barcode No." := BarCOdeTracking."Carton Barcode No.";
                                            BarcodeEntry."ILE No." := ILERec."Entry No.";
                                            BarcodeEntry.Modify();
                                        end;
                                        ILERec.Reset();
                                        ILERec.SetRange("Document No.", ItemJournalLine."Document No.");
                                        ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                        if ILERec.FindFirst() then begin
                                            BarcodeEntry.Init();
                                            BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                            BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::"Item Journal Line";
                                            BarcodeEntry.Insert();
                                            BarcodeEntry."Document Type" := ILERec."Document Type";
                                            BarcodeEntry."Document No." := ILERec."Document No.";
                                            BarcodeEntry."Location Code" := ILERec."Location Code";
                                            BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                            BarcodeEntry."item No." := ILERec."Item No.";
                                            BarcodeEntry.Qty := ILERec.Quantity;
                                            BarcodeEntry."Item Line No." := TLRec."Line No.";
                                            BarcodeEntry."Master Barcode No." := BarCOdeTracking."Carton Barcode No.";
                                            BarcodeEntry."ILE No." := ILERec."Entry No.";
                                            BarcodeEntry.Modify();
                                        end;
                                    until BarCOdeTracking.Next() = 0;
                            END;
                        end;
                    END;
                until TLRec.Next() = 0;
        END;
    End;


    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]

    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.Remarks := GenJournalLine.Remarks;
        CustLedgerEntry.Narration := GenJournalLine.Narration;
        CustLedgerEntry.Zone := GenJournalLine.Zone;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', true, true)]
    local procedure "Sales-Post_OnBeforePostCustomerEntry"
     (
         var GenJnlLine: Record "Gen. Journal Line";
         var SalesHeader: Record "Sales Header";
         var TotalSalesLine: Record "Sales Line";
         var TotalSalesLineLCY: Record "Sales Line";
         CommitIsSuppressed: Boolean;
         PreviewMode: Boolean;
         var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"
     )
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GenJnlLine.Remarks := SalesHeader.Remarks;
        GenJnlLine.Narration := SalesHeader.Narration;
        GenJnlLine.Zone := SalesHeader.Zone;
    end;

    var
        var1: Codeunit 12;
}
