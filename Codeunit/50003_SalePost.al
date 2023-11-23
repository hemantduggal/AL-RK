codeunit 50003 Salepost
{




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean)
    var
        RecCust: Record Customer;
        IgstAmount: Decimal;
        CgstAmount: Decimal;
        SgstAmount: Decimal;
        GSTSetup1: Record "GST Setup";
        TaxTransValue1: Record "Tax Transaction Value";
        SGST_perc1: Decimal;
        SGST_Amt2: Decimal;
        IGST_Amt2: Decimal;
        TaxComponentName1: Text;
        CGST_Amt1: Decimal;
        CGST_perc1: Decimal;
        IGST_Amt1: Decimal;
        CGST_Amt2: Decimal;
        IGST_perc1: Decimal;
        SLRec: Record "Sales Line";
        TemCred: Decimal;
    begin
        if SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] then begin
            if RecCust.get(SalesHeader."Sell-to Customer No.") then begin
                SalesHeader.CalcFields(Amount);
                Clear(IgstAmount);
                Clear(CgstAmount);
                Clear(SgstAmount);
                Clear(IGST_Amt2);
                Clear(CGST_Amt2);
                Clear(SGST_Amt2);
                Clear(TemCred);

                GSTSetup1.Get();//PT
                SLRec.Reset();
                SLRec.SetRange("Document No.", SalesHeader."No.");
                if SLRec.FindFirst() then
                    repeat
                        TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                        TaxTransValue1.SetRange("Tax Record ID", SLRec.RecordId());
                        TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                        TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                        if TaxTransValue1.FindSet() then
                            repeat
                                TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                                case TaxComponentName1 of
                                    'IGST':
                                        begin
                                            evaluate(IGST_Amt2, TaxTransValue1."Column Value");
                                            IgstAmount += IGST_Amt2;
                                        end;
                                    'CGST':
                                        begin
                                            evaluate(CGST_Amt2, TaxTransValue1."Column Value");
                                            CgstAmount += CGST_Amt2;
                                        end;
                                    'SGST':
                                        begin
                                            evaluate(SGST_Amt2, TaxTransValue1."Column Value");
                                            SgstAmount += SGST_Amt2;
                                        end;
                                end;
                            until TaxTransValue1.Next() = 0;
                    until SLRec.Next() = 0;
                RecCust.CalcFields("Balance (LCY)");
                if (RecCust."TemporaryCrPeriod(From Date)" < SalesHeader."Posting Date") AND (RecCust."TemporaryCrPeriod(To Date)" >= SalesHeader."Posting Date") then
                    TemCred := RecCust."Temporary Credit Limit"
                else
                    TemCred := 0;

                RecCust."Remaining Credit Limit" := RecCust."Credit Limit (LCY)" + RecCust."Temporary Credit Limit" - RecCust."Balance (LCY)" - (SalesHeader.Amount + SgstAmount + CgstAmount + IgstAmount);
                RecCust.Modify();
                if SalesHeader.Amount + SgstAmount + CgstAmount + IgstAmount > RecCust."Credit Limit (LCY)" - RecCust."Balance (LCY)" + TemCred then
                    Error('Credit Limit (LCY) %1 amount has been less from this amount %2', RecCust."Credit Limit (LCY)" + TemCred - RecCust."Balance (LCY)", SalesHeader.Amount + SgstAmount + CgstAmount + IgstAmount);
            end;
        END;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostItemJnlLineBeforePost', '', true, true)]
    local procedure "Sales-Post_OnAfterPostItemJnlLineBeforePost"
    (
        var ItemJournalLine: Record "Item Journal Line";
        SalesLine: Record "Sales Line";
        QtyToBeShippedBase: Decimal;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        var CheckApplFromItemEntry: Boolean;
        var TrackingSpecification: Record "Tracking Specification"
    )
    begin
        if SalesLine."Document Type" = SalesLine."Document Type"::Order then
            ItemJournalLine."Applies-to Entry" := GetShipmentEntry(SalesLine);
    end;


    procedure GetShipmentEntry(SL: Record "Sales Line"): Integer
    var
        ILE: Record "Item Ledger Entry";
        ProductTracking: Record "SO Tracking";
        ENT: Integer;
        BarcodLe: Record "Barcode Ledger Entry";
    begin
        Clear(ENT);
        ProductTracking.Reset();
        ProductTracking.SetRange("Document No.", SL."Document No.");
        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::Sales);
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




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeFinalizePosting', '', true, true)]
    local procedure "Sales-Post_OnRunOnBeforeFinalizePosting"
(
  var SalesHeader: Record "Sales Header";
  var SalesShipmentHeader: Record "Sales Shipment Header";
  var SalesInvoiceHeader: Record "Sales Invoice Header";
  var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
  var ReturnReceiptHeader: Record "Return Receipt Header";
  var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
  CommitIsSuppressed: Boolean;
  GenJnlLineExtDocNo: Code[35];
  var EverythingInvoiced: Boolean;
  GenJnlLineDocNo: Code[20];
  SrcCode: Code[10]
)
    var
        ITEMJ: Codeunit 22;
        Item_Ty: Record Item;
        BarCOdeTracking: Record "Master Barcode Tracking";
        BarcodeEntry: Record "Barcode Ledger Entry";
        BarcodeEntry1: Record "Barcode Ledger Entry";
        ILERec: Record "Item Ledger Entry";
        TLRec: Record "Sales Line";
        BarCOdeTracking1: Record "Master Barcode Tracking";
        CartonPOTracking1: Record "Carton BarCode Tracking";
        ProductPOTracking1: Record "SO Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductTracking: Record "SO Tracking";
    begin
        if (SalesShipmentHeader."No." <> '') OR (ReturnReceiptHeader."No." <> '') then begin
            TLRec.Reset();
            TLRec.SetRange("Document No.", SalesHeader."No.");
            if TLRec.FindFirst() then
                repeat
                    ProductPOTracking1.Reset();
                    ProductPOTracking1.SetRange("Document No.", TLRec."Document No.");
                    ProductPOTracking1.SetRange("Entry Type", ProductPOTracking1."Entry Type"::Sales);
                    ProductPOTracking1.SetRange("Item Line No.", TLRec."Line No.");
                    ProductPOTracking1.SetRange("Location Code", TLRec."Location Code");
                    ProductPOTracking1.SetRange("item No.", TLRec."No.");
                    if ProductPOTracking1.FindFirst() then begin
                        //                Message('Check2');
                        ProductTracking.Reset();
                        ProductTracking.SetRange("Document No.", TLRec."Document No.");
                        ProductTracking.SetRange("Entry Type", ProductTracking."Entry Type"::Sales);
                        ProductTracking.SetRange(ProductTracking."Item Line No.", TLRec."Line No.");
                        ProductTracking.SetRange("Item No.", TLRec."No.");
                        if ProductTracking.FindFirst() then
                            repeat
                                //                      Message('Check3');
                                BarcodeEntry1.Reset();
                                if BarcodeEntry1.FindLast() then;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", SalesShipmentHeader."No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                if ILERec.FindFirst() then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Sales;
                                    BarcodeEntry.Insert();
                                    BarcodeEntry."Document Type" := ILERec."Document Type";
                                    BarcodeEntry."Document No." := ILERec."Document No.";
                                    BarcodeEntry."Location Code" := ILERec."Location Code";
                                    BarcodeEntry."Posting Date" := ILERec."Posting Date";
                                    BarcodeEntry."item No." := ILERec."Item No.";
                                    BarcodeEntry.Qty := ProductTracking.Quanty;
                                    BarcodeEntry."Item Line No." := TLRec."Line No.";
                                    BarcodeEntry."Carton Barcode No." := ProductTracking."Carton Barcode No.";
                                    BarcodeEntry."Master Barcode No." := ProductTracking."Master Barcode No.";
                                    BarcodeEntry."Product Barcode No." := ProductTracking."Product Barcode No.";
                                    BarcodeEntry."ILE No." := ILERec."Entry No.";
                                    BarcodeEntry.Modify();
                                end;
                                ILERec.Reset();
                                ILERec.SetRange("Document No.", ReturnReceiptHeader."No.");
                                ILERec.SetRange("Document Line No.", TLRec."Line No.");
                                if ILERec.FindFirst() then begin
                                    BarcodeEntry.Init();
                                    BarcodeEntry."Entry No." := BarcodeEntry1."Entry No." + 1;
                                    BarcodeEntry."Entry Type" := BarcodeEntry."Entry Type"::Sales;
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

}
