codeunit 50002 Purchpost
{









    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostVendorEntry', '', true, true)]
    local procedure "Purch.-Post_OnBeforePostVendorEntry"
 (
     var GenJnlLine: Record "Gen. Journal Line";
     var PurchHeader: Record "Purchase Header";
     var TotalPurchLine: Record "Purchase Line";
     var TotalPurchLineLCY: Record "Purchase Line";
     PreviewMode: Boolean;
     CommitIsSupressed: Boolean;
     var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"
 )
    begin
        WITH PurchHeader DO BEGIN
            GenJnlLine."Vendor Name" := PurchHeader."Buy-from Vendor Name";
            GenJnlLine.Zone := PurchHeader.Zone;
        end;
    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemJnlLineOnBeforeItemJnlPostLineRunWithCheck', '', true, true)]
    local procedure "Purch.-Post_OnPostItemJnlLineOnBeforeItemJnlPostLineRunWithCheck"
      (
          var ItemJnlLine: Record "Item Journal Line";
          var PurchaseLine: Record "Purchase Line";
          DropShipOrder: Boolean;
          PurchaseHeader: Record "Purchase Header";
          WhseReceive: Boolean;
          QtyToBeReceived: Decimal;
          QtyToBeReceivedBase: Decimal;
          QtyToBeInvoiced: Decimal;
          QtyToBeInvoicedBase: Decimal
      )
    begin
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Return Order" then
            ItemJnlLine."Applies-to Entry" := GetShipmentEntry(PurchaseLine);
    end;


    procedure GetShipmentEntry(SL: Record "Purchase Line"): Integer
    var
        ILE: Record "Item Ledger Entry";
        ProductTracking: Record "SO Tracking";
        ENT: Integer;
        BarcodLe: Record "Barcode Ledger Entry";
    begin
        Clear(ENT);
        ProductTracking.Reset();
        ProductTracking.SetRange("Document No.", SL."Document No.");
        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::Purchase);
        ProductTracking.SetRange(ProductTracking."Item Line No.", SL."Line No.");
        ProductTracking.SetRange("Item No.", SL."No.");
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



    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure "Vendor Ledger Entry_OnAfterCopyVendLedgerEntryFromGenJnlLine"
         (
             var VendorLedgerEntry: Record "Vendor Ledger Entry";
             GenJournalLine: Record "Gen. Journal Line"
         )
    begin
        VendorLedgerEntry."Vendor Name" := GenJournalLine."Vendor Name";
        VendorLedgerEntry.Zone := GenJournalLine.Zone;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnBeforeFinalizePosting', '', true, true)]
    local procedure "Purch.-Post_OnRunOnBeforeFinalizePosting"
    (
        var PurchaseHeader: Record "Purchase Header";
        var PurchRcptHeader: Record "Purch. Rcpt. Header";
        var PurchInvHeader: Record "Purch. Inv. Header";
        var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        var ReturnShipmentHeader: Record "Return Shipment Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CommitIsSuppressed: Boolean
    )
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchRcptHeader1: Record "Purch. Rcpt. Header";
        Item_Ty: Record Item;
        BarCOdeTracking: Record "Master Barcode Tracking";
        BarcodeEntry: Record "Barcode Ledger Entry";
        BarcodeEntry1: Record "Barcode Ledger Entry";
        ILERec: Record "Item Ledger Entry";
        TLRec: Record "Purchase Line";
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
        ProductTracking2: Record "Purchase Return Tracking";
        ProductTracking3: Record "Purchase Return Tracking";
    begin

        if (PurchRcptHeader."No." <> '') OR (ReturnShipmentHeader."No." <> '') then begin
            TLRec.Reset();
            TLRec.SetRange("Document No.", PurchaseHeader."No.");
            if TLRec.FindFirst() then
                repeat
                    ProductPOTracking1.Reset();
                    ProductPOTracking1.SetRange("Document No.", TLRec."Document No.");
                    ProductPOTracking1.SetRange("Entry Type", ProductPOTracking1."Entry Type"::Purchase);
                    ProductPOTracking1.SetRange("Item Line No.", TLRec."Line No.");
                    ProductPOTracking1.SetRange("Location Code", TLRec."Location Code");
                    ProductPOTracking1.SetRange("item No.", TLRec."No.");
                    if ProductPOTracking1.FindFirst() then begin
                        //Message('Check2');
                        ProductTracking.Reset();
                        ProductTracking.SetRange("Document No.", TLRec."Document No.");
                        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::Purchase);
                        ProductTracking.SetRange(ProductTracking."Item Line No.", TLRec."Line No.");
                        ProductTracking.SetRange("Item No.", TLRec."No.");
                        if ProductTracking.FindFirst() then
                            repeat
                                //Message('Check3');
                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", PurchRcptHeader."No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                if ILERec.FindFirst() then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Purchase;
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
                    END Else begin
                        CartonPOTracking1.Reset();
                        CartonPOTracking1.SetRange("Document No.", TLRec."Document No.");
                        CartonPOTracking1.SetRange("Entry Type", CartonPOTracking1."Entry Type"::Purchase);
                        CartonPOTracking1.SetRange("Item Line No.", TLRec."Line No.");
                        CartonPOTracking1.SetRange("Location Code", TLRec."Location Code");
                        CartonPOTracking1.SetRange("item No.", TLRec."No.");
                        if CartonPOTracking1.FindFirst() then begin
                            CartonTracking.Reset();
                            CartonTracking.SetRange("Document No.", TLRec."Document No.");
                            CartonTracking.SetRange("Entry Type", CartonTracking."Entry Type"::Purchase);
                            CartonTracking.SetRange(CartonTracking."Item Line No.", TLRec."Line No.");
                            CartonTracking.SetRange("Item No.", TLRec."No.");
                            if CartonTracking.FindFirst() then
                                repeat
                                    BarcodeEntry1.Reset();
                                    if BarcodeEntry1.FindLast() then;
                                    ILERec.Reset();
                                    ILERec.SetRange("Document No.", PurchRcptHeader."No.");
                                    ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                    if ILERec.FindFirst() then begin
                                        BarcodeEntry.Init();
                                        BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                        BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Purchase;
                                        BarcodeEntry.Insert();
                                        BarcodeEntry."Document Type" := ILERec."Document Type";
                                        BarcodeEntry."Document No." := ILERec."Document No.";
                                        BarcodeEntry."Location Code" := ILERec."Location Code";
                                        BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                        BarcodeEntry."item No." := ILERec."Item No.";
                                        BarcodeEntry.Qty := 1;
                                        BarcodeEntry."Item Line No." := TLRec."Line No.";
                                        BarcodeEntry."Carton Barcode No." := CartonTracking."Carton Barcode No.";
                                        BarcodeEntry."Master Barcode No." := CartonTracking."Master Barcode No.";
                                        BarcodeEntry."ILE No." := ILERec."Entry No.";
                                        BarcodeEntry.Modify();
                                    end;

                                    CartonTracking.Delete();
                                until CartonTracking.Next() = 0;

                        END Else begin
                            BarCOdeTracking1.Reset();
                            BarCOdeTracking1.SetRange("Document No.", TLRec."Document No.");
                            BarCOdeTracking1.SetRange(BarCOdeTracking1."Entry Type", BarCOdeTracking1."Entry Type"::Purchase);
                            BarCOdeTracking1.SetRange("Item Line No.", TLRec."Line No.");
                            BarCOdeTracking1.SetRange("Location Code", TLRec."Location Code");
                            BarCOdeTracking1.SetRange("item No.", TLRec."No.");
                            if BarCOdeTracking1.FindFirst() then begin
                                BarCOdeTracking.Reset();
                                BarCOdeTracking.SetRange("Document No.", TLRec."Document No.");
                                BarCOdeTracking.SetRange(BarCOdeTracking."Entry Type", BarCOdeTracking."Entry Type"::Purchase);
                                BarCOdeTracking.SetRange(BarCOdeTracking."Item Line No.", TLRec."Line No.");
                                BarCOdeTracking.SetRange("Item No.", TLRec."No.");
                                if BarCOdeTracking.FindFirst() then
                                    repeat
                                        BarcodeEntry1.Reset();
                                        if BarcodeEntry1.FindLast() then;
                                        ILERec.Reset();
                                        ILERec.SetRange("Document No.", PurchRcptHeader."No.");
                                        ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                        if ILERec.FindFirst() then begin
                                            BarcodeEntry.Init();
                                            BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                            BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Purchase;
                                            BarcodeEntry.Insert();
                                            BarcodeEntry."Document Type" := ILERec."Document Type";
                                            BarcodeEntry."Document No." := ILERec."Document No.";
                                            BarcodeEntry."Location Code" := ILERec."Location Code";
                                            BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                            BarcodeEntry."item No." := ILERec."Item No.";
                                            BarcodeEntry.Qty := 1;
                                            BarcodeEntry."Item Line No." := TLRec."Line No.";
                                            BarcodeEntry."Master Barcode No." := BarCOdeTracking."Carton Barcode No.";
                                            BarcodeEntry."ILE No." := ILERec."Entry No.";
                                            BarcodeEntry.Modify();
                                        end;
                                        BarCOdeTracking.Delete();
                                    until BarCOdeTracking.Next() = 0;
                            END;
                        end;
                    END;

                    ProductTracking2.Reset();
                    ProductTracking2.SetRange("Document No.", TLRec."Document No.");
                    ProductTracking2.SetRange("Item Line No.", TLRec."Line No.");
                    ProductTracking2.SetRange("item No.", TLRec."No.");
                    if ProductTracking2.FindFirst() then begin

                        ProductTracking3.Reset();
                        ProductTracking3.SetRange("Document No.", TLRec."Document No.");
                        ProductTracking3.SetRange("Entry Type", ProductTracking3."Entry Type"::Purchase);
                        ProductTracking3.SetRange(ProductTracking3."Item Line No.", TLRec."Line No.");
                        ProductTracking3.SetRange("Item No.", TLRec."No.");
                        if ProductTracking3.FindFirst() then
                            repeat

                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", ReturnShipmentHeader."No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                if ILERec.FindFirst() then begin

                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Purchase;
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := ILERec."Document Type";
                                    BarcodeEntry."Document No." := ILERec."Document No.";
                                    BarcodeEntry."Location Code" := ILERec."Location Code";
                                    BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                    BarcodeEntry."item No." := ILERec."Item No.";
                                    BarcodeEntry.Qty := -1;
                                    BarcodeEntry."Item Line No." := TLRec."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking3."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking3."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking3."Product Barcode No.";
                                    BarcodeEntry."ILE No." := ILERec."Entry No.";
                                    BarcodeEntry.Modify();
                                end;
                                ProductTracking3.Delete();
                            until ProductTracking3.Next() = 0;
                    END;
                until TLRec.Next() = 0;

        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeDeletePurchQuote', '', true, true)]

    local procedure OnBeforeDeletePurchQuote(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', true, true)]

    local procedure OnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
        PurchOrderLine."Total Qty" := PurchQuoteLine.Quantity;
        PurchOrderLine."Make Order Qty" := PurchQuoteLine."Make Order Qty";
        PurchOrderLine.Quantity := PurchQuoteLine."Make Order Qty";
        PurchOrderLine."Remaining Qty" := PurchQuoteLine."Remaining Qty";

    end;

    var
        c: Codeunit "Purch.-Quote to Order";

}