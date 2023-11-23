
page 50056 "Master Barcode Tracking"
{

    SourceTable = "Master Barcode Tracking";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = true;
    ModifyAllowed = true;


    layout
    {
        area(Content)
        {
            repeater(group)
            {

                field("Document No."; Rec."Document No.")
                {
                    Applicationarea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                }
                field("Item Line No."; Rec."Item Line No.")
                {
                    Applicationarea = All;
                }

                field("Location Code"; Rec."Location Code")
                {
                    Applicationarea = All;
                }

                field("Carton Barcode No."; Rec."Carton Barcode No.")
                {
                    Caption = 'Master Barcode No.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        CartonBar: Record "Carton BarCode Tracking";
                    begin

                        CartonBar.Reset();
                        CartonBar.SetRange("Document No.", Rec."Document No.");
                        CartonBar.SetRange("Entry Type", Rec."Entry Type");
                        CartonBar.SetRange("Location Code", Rec."Location Code");
                        CartonBar.SetRange("Item No.", Rec."Item No.");
                        CartonBar.SetRange("Item Line No.", Rec."Item Line No.");
                        CartonBar.SetRange("Master Barcode No.", xRec."Carton Barcode No.");
                        if CartonBar.FindFirst() then
                            Error('You do not have change the Master Barcode, Because line is already exist');
                    end;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            group("Visual Inspection")
            {
                action(CartonbarcodeTracking)
                {
                    Caption = 'Carton Barcode Tracking';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Calculate;
                    ApplicationArea = All;
                    RunObject = page "Carton Barcode Tracking";
                    RunPageLink = "Document No." = field("Document No."), "Item Line No." = field("Item Line No."), "Item No." = field("Item No."),
                    "Master Barcode No." = field("Carton Barcode No.");
                    trigger OnAction()
                    var
                        ItemRec: Record Item;
                    begin
                        if ItemRec.Get(Rec."Item No.") then begin
                            if ItemRec."Sub Carton Bar Code" = false then
                                Error('You do not have permission to open master barcodetracking');
                        end else
                            Error('You do not have permission to open master barcodetracking');
                    end;

                }
                action(Accept)
                {
                    Image = Order;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                    begin
                        Rec.Status := Rec.Status::Accept;
                    end;
                }
                action(Reject)
                {
                    Image = Order;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                    begin
                        Rec.Status := Rec.Status::Reject;
                    end;
                }
            }
        }
    }


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        POTracking: Record "Master Barcode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductBarTracking: Record "Product BarCode Tracking";
        POtrack: Decimal;
        Cartontrc: Decimal;
        proBarTrc: Decimal;
        POQty: Decimal;
        POLine: Record "Purchase Line";
        SOLine: Record "Sales Line";
        TransLine: Record "Transfer Line";
        IteMJnLine: Record "Item Journal Line";
    begin
        Clear(POtrack);
        Clear(Cartontrc);
        Clear(proBarTrc);
        Clear(POQty);
        POTracking.Reset();
        POTracking.SetRange("Document No.", Rec."Document No.");
        //    POTracking.SetRange("Entry Type", Rec."Entry Type");
        POTracking.SetRange("Item No.", Rec."Item No.");
        POTracking.SetRange("Item Line No.", Rec."Item Line No.");
        //POTracking.SetRange("Location Code", Rec."Location Code");
        if POTracking.FindFirst() then
            repeat
                POtrack += 1;
            // Message('master track count..%1', POtrack);
            until POTracking.Next() = 0;

        CartonTracking.Reset();
        CartonTracking.SetRange("Document No.", Rec."Document No.");
        // CartonTracking.SetRange("Entry Type", Rec."Entry Type");
        CartonTracking.SetRange("Item No.", Rec."Item No.");
        CartonTracking.SetRange("Item Line No.", Rec."Item Line No.");
        //CartonTracking.SetRange("Location Code", Rec."Location Code");
        if CartonTracking.FindFirst() then
            repeat
                Cartontrc += 1;
            // Message('carton track count..%1', Cartontrc);
            until CartonTracking.Next() = 0;

        ProductBarTracking.Reset();
        ProductBarTracking.SetRange("Document No.", Rec."Document No.");
        //  ProductBarTracking.SetRange("Entry Type", Rec."Entry Type");
        ProductBarTracking.SetRange("Item No.", Rec."Item No.");
        ProductBarTracking.SetRange("Item Line No.", Rec."Item Line No.");
        // ProductBarTracking.SetRange("Location Code", Rec."Location Code");
        if ProductBarTracking.FindFirst() then
            repeat
                proBarTrc += 1;
            // Message('product track count..%1', proBarTrc);

            until ProductBarTracking.Next() = 0;

        if proBarTrc <> 0 then
            POQty := proBarTrc
        else
            if Cartontrc <> 0 then
                POQty := Cartontrc
            else
                if POtrack <> 0 then
                    POQty := POtrack;

        POLine.Reset();
        POLine.SetRange("Document No.", Rec."Document No.");
        POLine.SetRange("Line No.", Rec."Item Line No.");
        POLine.SetRange("No.", Rec."Item No.");
        POLine.SetRange(POLine."Document Type", POLine."Document Type"::Order);
        if POLine.FindFirst() then begin
            POLine.Validate(Quantity, POQty);
            POLine.Validate("Qty. to Receive", POQty);
            POLine.Modify();
        end;
        //Message('%1', POQty);
        POLine.Reset();
        POLine.SetRange("Document No.", Rec."Document No.");
        POLine.SetRange("Line No.", Rec."Item Line No.");
        POLine.SetRange("No.", Rec."Item No.");
        POLine.SetRange(POLine."Document Type", POLine."Document Type"::"Return Order");
        if POLine.FindFirst() then begin
            if POLine.Quantity < POQty then
                Error('Bar code tracnking qty can not be exceed from SO Qty');
            POLine.Validate(POLine."Return Qty. to Ship", POQty);
            POLine.Modify();
        end;

        SOLine.Reset();
        SOLine.SetRange("Document No.", Rec."Document No.");
        SOLine.SetRange("Line No.", Rec."Item Line No.");
        SOLine.SetRange("No.", Rec."Item No.");
        SOLine.SetRange("Document Type", SOLine."Document Type"::Order);
        if SOLine.FindFirst() then begin
            SOLine.Validate(Quantity, POQty);
            SOLine.Modify();
        end;

        SOLine.Reset();
        SOLine.SetRange("Document No.", Rec."Document No.");
        SOLine.SetRange("Line No.", Rec."Item Line No.");
        SOLine.SetRange("No.", Rec."Item No.");
        SOLine.SetRange("Document Type", SOLine."Document Type"::"Return Order");
        if SOLine.FindFirst() then begin
            if SOLine.Quantity < POQty then
                Error('Bar code tracnking qty can not be exceed from SO Qty');
            SOLine.Validate(SOLine."Return Qty. to Receive", POQty);
            SOLine.Modify();
        end;

        TransLine.Reset();
        TransLine.SetRange("Document No.", Rec."Document No.");
        TransLine.SetRange("Line No.", Rec."Item Line No.");
        TransLine.SetRange(TransLine."Item No.", Rec."Item No.");
        if TransLine.FindFirst() then begin
            TransLine.Validate(Quantity, POQty);
            TransLine.Modify();
        end;


        IteMJnLine.Reset();
        IteMJnLine.SetRange("Document No.", Rec."Document No.");
        IteMJnLine.SetRange(IteMJnLine."Item No.", Rec."Item No.");
        if IteMJnLine.FindFirst() then begin
            IteMJnLine.Validate(Quantity, POQty);
            IteMJnLine.Modify();
        end;
    end;



    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        BarcodeTr: Record "Master Barcode Tracking";
        transhead: Record "Transfer Line";
        SaleLine: Record "Sales Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin
        // Message('%1..%2..%3', rec."Document No.", rec."Item No.", Rec."Item Line No.");


        transhead.Reset();
        transhead.SetRange("Document No.", Rec."Document No.");
        transhead.SetRange(transhead."Item No.", Rec."Item No.");
        if transhead.FindFirst() then begin
            Rec.Validate("Location Code", transhead."Transfer-from Code");
            Rec."Entry Type" := Rec."Entry Type"::Transfer;
        END;

        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange("No.", Rec."Item No.");
        if SaleLine.FindFirst() then begin
            Rec.Validate("Location Code", SaleLine."Location Code");
            Rec."Entry Type" := Rec."Entry Type"::Sales;

        END;

        PurLineLine.Reset();
        PurLineLine.SetRange("Document No.", Rec."Document No.");
        PurLineLine.SetRange("No.", Rec."Item No.");
        if PurLineLine.FindFirst() then begin
            Rec.Validate("Location Code", PurLineLine."Location Code");
            Rec."Entry Type" := Rec."Entry Type"::Purchase;

        END;

        IJL.Reset();
        IJL.SetRange("Document No.", Rec."Document No.");
        IJL.SetRange("Item No.", Rec."Item No.");
        if IJL.FindFirst() then begin
            Rec.Validate("Location Code", IJL."Location Code");
            // Rec."Item No." := IJL."Item No.";
            Rec."Entry Type" := Rec."Entry Type"::"Item Journal Line";

        END;

    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BarcodeTr: Record "Master Barcode Tracking";
        transhead: Record "Transfer Line";
        SaleLine: Record "Sales Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin

        BarcodeTr.Reset();
        BarcodeTr.SetRange("Document No.", rec."Document No.");
        BarcodeTr.SetRange("Item No.", rec."Item No.");
        BarcodeTr.SetRange("Item Line No.", rec."Item Line No.");
        if BarcodeTr.FindLast() then
            Rec."Line No." := BarcodeTr."Line No." + 10000
        ELSE
            Rec."Line No." := 10000;

        transhead.Reset();
        transhead.SetRange("Document No.", Rec."Document No.");
        transhead.SetRange(transhead."Item No.", Rec."Item No.");
        if transhead.FindFirst() then begin
            Rec.Validate("Location Code", transhead."Transfer-from Code");
            Rec."Entry Type" := Rec."Entry Type"::Transfer;
        END;

        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange("No.", Rec."Item No.");
        if SaleLine.FindFirst() then begin
            Rec.Validate("Location Code", SaleLine."Location Code");
            Rec."Entry Type" := Rec."Entry Type"::Sales;
        END;

        PurLineLine.Reset();
        PurLineLine.SetRange("Document No.", Rec."Document No.");
        PurLineLine.SetRange("No.", Rec."Item No.");
        if PurLineLine.FindFirst() then begin
            Rec."Location Code" := PurLineLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Purchase;
        END;

        IJL.Reset();
        IJL.SetRange("Document No.", Rec."Document No.");
        if IJL.FindFirst() then begin
            Rec.Validate("Location Code", IJL."Location Code");
            // Rec."Item No." := IJL."Item No.";
            Rec."Entry Type" := Rec."Entry Type"::"Item Journal Line";
        END;

    END;

    trigger OnAfterGetRecord()
    begin

    end;


}
