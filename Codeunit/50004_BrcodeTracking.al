codeunit 50005 BarCodeTracking
{
    procedure ScanBarcode(ScanBarcode: Code[20]; DocumentNo: Code[20]; LineNo: Integer; ItemNo: Code[20]; Qty: Decimal; LocCode: Code[20])
    var
        BarCodeTracking: Record "TO Tracking";
        BarCodeTracking1: Record "TO Tracking";
        BarCodeTracking2: Record "TO Tracking";
        BarcodeLedgerEntry: Record "Barcode Ledger Entry";
    begin
        BarCodeTracking2.Reset();
        BarCodeTracking2.SetRange("Document No.", DocumentNo);
        BarCodeTracking2.SetRange("Item Line No.", LineNo);
        if BarCodeTracking2.FindFirst() then;
        if BarCodeTracking2.Count >= Qty then
            Error('QTY does not exist on line');

        BarCodeTracking1.Reset();
        BarCodeTracking1.SetRange("Document No.", DocumentNo);
        BarCodeTracking1.SetRange("Item Line No.", LineNo);
        if BarCodeTracking1.FindLast() then;

        BarCodeTracking.Init();
        BarCodeTracking."Document No." := DocumentNo;
        BarCodeTracking."Item No." := ItemNo;
        BarCodeTracking."Item Line No." := LineNo;
        BarCodeTracking."Line No." := BarCodeTracking1."Line No." + 10000;
        BarCodeTracking.Insert();
        BarCodeTracking."Location Code" := LocCode;
        if BarCodeTracking."Master Barcode No." = '' then begin
            BarcodeLedgerEntry.Reset();
            BarcodeLedgerEntry.SetRange("Master Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry.FindFirst() then begin
                BarCodeTracking."Master Barcode No." := ScanBarcode;
            end;
        end;
        if BarCodeTracking."Carton Barcode No." = '' then begin
            BarcodeLedgerEntry.Reset();
            BarcodeLedgerEntry.SetRange("Carton Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry.FindFirst() then begin
                BarCodeTracking."Carton Barcode No." := ScanBarcode;
            end;
        end;
        if BarCodeTracking."Product Barcode No." = '' then begin
            BarcodeLedgerEntry.Reset();
            BarcodeLedgerEntry.SetRange("Product Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry.FindFirst() then begin
                BarCodeTracking."Product Barcode No." := ScanBarcode;
            end;
        end;

        //BarCodeTracking."Entry Type" := BarCodeTracking."Entry Type"::Sales;
        BarCodeTracking.Modify();
    end;


    procedure ScanBarcodeTransferLine(MasterBarcode: Boolean; cartonBarcode: Boolean; ProduBar: Boolean; ScanBarcode: Code[20]; DocumentNo: Code[20]; LineNo: Integer; ItemNo: Code[20]; Qty: Decimal; LocCode: Code[20])
    var
        BarCodeTracking: Record "TO Tracking";
        BarCodeTracking1: Record "TO Tracking";
        BarCodeTracking2: Record "TO Tracking";
        BarcodeLedgerEntry: Record "Barcode Ledger Entry";
        BarcodeLedgerEntry1: Record "Barcode Ledger Entry";
    begin
        if ProduBar = true then begin
            BarCodeTracking1.Reset();
            BarCodeTracking1.SetRange("Document No.", DocumentNo);
            BarCodeTracking1.SetRange("Item Line No.", LineNo);
            if BarCodeTracking1.FindLast() then;

            BarCodeTracking.Init();
            BarCodeTracking."Document No." := DocumentNo;
            BarCodeTracking."Item No." := ItemNo;
            BarCodeTracking."Item Line No." := LineNo;
            BarCodeTracking."Line No." := BarCodeTracking1."Line No." + 10000;
            BarCodeTracking.Insert();
            BarcodeLedgerEntry."Entry Type" := BarCodeTracking."Entry Type"::Sales;
            BarCodeTracking."Location Code" := LocCode;

            BarcodeLedgerEntry.Reset();
            BarcodeLedgerEntry.SetRange(BarcodeLedgerEntry."Product Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry.FindFirst() then begin
                BarCodeTracking."Master Barcode No." := BarcodeLedgerEntry."Master Barcode No.";
                BarCodeTracking."Carton Barcode No." := BarcodeLedgerEntry."Carton Barcode No.";
                BarCodeTracking."Product Barcode No." := BarcodeLedgerEntry."Product Barcode No.";
            end;
            BarCodeTracking.Modify();
        END;

        if cartonBarcode = true then begin
            BarcodeLedgerEntry1.Reset();
            BarcodeLedgerEntry1.SetRange("Carton Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry1.FindFirst() then
                repeat
                    BarCodeTracking1.Reset();
                    BarCodeTracking1.SetRange("Document No.", DocumentNo);
                    BarCodeTracking1.SetRange("Item Line No.", LineNo);
                    if BarCodeTracking1.FindLast() then;

                    BarCodeTracking.Init();
                    BarCodeTracking."Document No." := DocumentNo;
                    BarCodeTracking."Item No." := ItemNo;
                    BarCodeTracking."Item Line No." := LineNo;
                    BarCodeTracking."Line No." := BarCodeTracking1."Line No." + 10000;
                    BarCodeTracking.Insert();
                    BarcodeLedgerEntry."Entry Type" := BarCodeTracking."Entry Type"::Sales;
                    BarCodeTracking."Location Code" := LocCode;
                    BarCodeTracking."Master Barcode No." := BarcodeLedgerEntry1."Master Barcode No.";
                    BarCodeTracking."Carton Barcode No." := BarcodeLedgerEntry1."Carton Barcode No.";
                    BarCodeTracking."Product Barcode No." := BarcodeLedgerEntry1."Product Barcode No.";
                    BarCodeTracking.Modify();
                until BarcodeLedgerEntry1.Next() = 0;
        end;

        if MasterBarcode = true then begin
            BarcodeLedgerEntry1.Reset();
            BarcodeLedgerEntry1.SetRange("Master Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry1.FindFirst() then
                repeat
                    BarCodeTracking1.Reset();
                    BarCodeTracking1.SetRange("Document No.", DocumentNo);
                    BarCodeTracking1.SetRange("Item Line No.", LineNo);
                    if BarCodeTracking1.FindLast() then;

                    BarCodeTracking.Init();
                    BarCodeTracking."Document No." := DocumentNo;
                    BarCodeTracking."Item No." := ItemNo;
                    BarCodeTracking."Item Line No." := LineNo;
                    BarCodeTracking."Line No." := BarCodeTracking1."Line No." + 10000;
                    BarCodeTracking.Insert();
                    BarcodeLedgerEntry."Entry Type" := BarCodeTracking."Entry Type"::Sales;
                    BarCodeTracking."Location Code" := LocCode;
                    BarCodeTracking."Master Barcode No." := BarcodeLedgerEntry1."Master Barcode No.";
                    BarCodeTracking."Carton Barcode No." := BarcodeLedgerEntry1."Carton Barcode No.";
                    BarCodeTracking."Product Barcode No." := BarcodeLedgerEntry1."Product Barcode No.";
                    BarCodeTracking.Modify();
                until BarcodeLedgerEntry1.Next() = 0;
        end;
    end;

    procedure ScanBarcodesalesLine(MasterBarcode: Boolean; cartonBarcode: Boolean; ProduBar: Boolean; ScanBarcode: Code[20]; DocumentNo: Code[20]; LineNo: Integer; ItemNo: Code[20]; Qty: Decimal; LocCode: Code[20])
    var
        BarCodeTracking: Record "SO Tracking";
        BarCodeTracking1: Record "SO Tracking";
        BarCodeTracking2: Record "SO Tracking";
        BarcodeLedgerEntry: Record "Barcode Ledger Entry";
        BarcodeLedgerEntry1: Record "Barcode Ledger Entry";
    begin
        if ProduBar = true then begin
            BarCodeTracking1.Reset();
            BarCodeTracking1.SetRange("Document No.", DocumentNo);
            BarCodeTracking1.SetRange("Item Line No.", LineNo);
            if BarCodeTracking1.FindLast() then;

            BarCodeTracking.Init();
            BarCodeTracking."Document No." := DocumentNo;
            BarCodeTracking."Item No." := ItemNo;
            BarCodeTracking."Item Line No." := LineNo;
            BarCodeTracking."Line No." := BarCodeTracking1."Line No." + 10000;
            BarCodeTracking.Insert();
            BarcodeLedgerEntry."Entry Type" := BarCodeTracking."Entry Type"::Sales;
            BarCodeTracking."Location Code" := LocCode;

            BarcodeLedgerEntry.Reset();
            BarcodeLedgerEntry.SetRange(BarcodeLedgerEntry."Product Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry.FindFirst() then begin
                BarCodeTracking."Master Barcode No." := BarcodeLedgerEntry."Master Barcode No.";
                BarCodeTracking."Carton Barcode No." := BarcodeLedgerEntry."Carton Barcode No.";
                BarCodeTracking."Product Barcode No." := BarcodeLedgerEntry."Product Barcode No.";
            end;
            BarCodeTracking.Modify();
        END;

        if cartonBarcode = true then begin
            BarcodeLedgerEntry1.Reset();
            BarcodeLedgerEntry1.SetRange("Carton Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry1.FindFirst() then
                repeat
                    BarCodeTracking1.Reset();
                    BarCodeTracking1.SetRange("Document No.", DocumentNo);
                    BarCodeTracking1.SetRange("Item Line No.", LineNo);
                    if BarCodeTracking1.FindLast() then;

                    BarCodeTracking.Init();
                    BarCodeTracking."Document No." := DocumentNo;
                    BarCodeTracking."Item No." := ItemNo;
                    BarCodeTracking."Item Line No." := LineNo;
                    BarCodeTracking."Line No." := BarCodeTracking1."Line No." + 10000;
                    BarCodeTracking.Insert();
                    BarcodeLedgerEntry."Entry Type" := BarCodeTracking."Entry Type"::Sales;
                    BarCodeTracking."Location Code" := LocCode;
                    BarCodeTracking."Master Barcode No." := BarcodeLedgerEntry1."Master Barcode No.";
                    BarCodeTracking."Carton Barcode No." := BarcodeLedgerEntry1."Carton Barcode No.";
                    BarCodeTracking."Product Barcode No." := BarcodeLedgerEntry1."Product Barcode No.";
                    BarCodeTracking.Modify();
                until BarcodeLedgerEntry1.Next() = 0;
        end;

        if MasterBarcode = true then begin
            BarcodeLedgerEntry1.Reset();
            BarcodeLedgerEntry1.SetRange("Master Barcode No.", ScanBarcode);
            if BarcodeLedgerEntry1.FindFirst() then
                repeat
                    BarCodeTracking1.Reset();
                    BarCodeTracking1.SetRange("Document No.", DocumentNo);
                    BarCodeTracking1.SetRange("Item Line No.", LineNo);
                    if BarCodeTracking1.FindLast() then;

                    BarCodeTracking.Init();
                    BarCodeTracking."Document No." := DocumentNo;
                    BarCodeTracking."Item No." := ItemNo;
                    BarCodeTracking."Item Line No." := LineNo;
                    BarCodeTracking."Line No." := BarCodeTracking1."Line No." + 10000;
                    BarCodeTracking.Insert();
                    BarcodeLedgerEntry."Entry Type" := BarCodeTracking."Entry Type"::Sales;
                    BarCodeTracking."Location Code" := LocCode;
                    BarCodeTracking."Master Barcode No." := BarcodeLedgerEntry1."Master Barcode No.";
                    BarCodeTracking."Carton Barcode No." := BarcodeLedgerEntry1."Carton Barcode No.";
                    BarCodeTracking."Product Barcode No." := BarcodeLedgerEntry1."Product Barcode No.";
                    BarCodeTracking.Modify();
                until BarcodeLedgerEntry1.Next() = 0;
        end;
    end;


    procedure scanbarcodepurchase(Purchline: Record "Purchase Line")
    var
        QAHrec: Record "Barcode Data";
        QALRec: Record "Barcode Data";
        QAHrec1: Record "Barcode Data";
        QAHrec2: Record "Barcode Data";
        NoSeriaMan: Codeunit NoSeriesManagement;
        InvSetup: Record "Inventory Setup";
        TRANLine: Record "Transfer Line";
        // Buffertable: Record "Barcode Buffer Table";
        // QALRec1: Record "QA&WIP Line";
        ProOrderLine: Record "Prod. Order Line";
        ItemRec: Record Item;
    begin
        QAHrec1.Reset();
        QAHrec1.SetRange(QAHrec1."Document No.", Purchline."Document No.");
        QAHrec1.SetRange(QAHrec1."Item Line No.", Purchline."Line No.");
        if Not QAHrec1.FindFirst() then begin
            QAHrec.Init();
            QAHrec."Document No." := Purchline."Document No.";
            QAHrec."Item Line No." := Purchline."Line No.";
            QAHrec.Insert();
            QAHrec."Item No." := Purchline."No.";
            QAHrec.Modify();
            /*
                        ProOrderLine.Reset();
                        ProOrderLine.SetRange(ProOrderLine."Prod. Order No.", RPO."No.");
                        if ProOrderLine.FindFirst() then
                            repeat
                                QALRec.Init();
                                QALRec."Released Production Order No" := RPO."No.";
                                QALRec."Line No" := ProOrderLine."Line No.";
                                QALRec.Insert();
                                QALRec."Item Code" := ProOrderLine."Item No.";
                                QALRec.Qty := ProOrderLine.Quantity;
                                QALRec.Modify();
                            until ProOrderLine.Next() = 0;
                            */

            Commit();

            QAHrec2.Reset();
            QAHrec2.SetRange(QAHrec2."Document No.", Purchline."Document No.");
            QAHrec2.SetRange(QAHrec2."Item Line No.", Purchline."Line No.");
            if QAHrec2.FindFirst() then
                Page.RunModal(50070, QAHrec2);
        end else begin
            QAHrec2.Reset();
            QAHrec2.SetRange(QAHrec2."Document No.", Purchline."Document No.");
            QAHrec2.SetRange(QAHrec2."Item Line No.", Purchline."Line No.");
            if QAHrec2.FindFirst() then
                Page.RunModal(50070, QAHrec2);
        end;
    end;
}