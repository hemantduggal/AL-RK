
page 50063 "PR Barcode Tracking"
{

    SourceTable = "Purchase Return Tracking";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Item Line No."; Rec."Item Line No.")
                {
                    Editable = false;
                    Applicationarea = All;
                }

                field("Location Code"; Rec."Location Code")
                {
                    Editable = true;
                    Applicationarea = All;
                }
                field("Master Barcode No."; Rec."Master Barcode No.")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Carton Barcode No."; Rec."Carton Barcode No.")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Product Barcode No."; Rec."Product Barcode No.")
                {
                    ApplicationArea = all;
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



    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        transhead: Record "Transfer Line";
        SaleLine: Record "Purchase Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin
        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange(SaleLine."No.", Rec."Item No.");
        SaleLine.SetRange("Line No.", Rec."Item Line No.");
        if SaleLine.FindFirst() then begin
            Rec."Location Code" := SaleLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Purchase;
        end;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BarcodeTr: Record "Purchase Return Tracking";
        transhead: Record "Transfer Line";
        SaleLine: Record "Purchase Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin
        BarcodeTr.Reset();
        BarcodeTr.SetRange("Document No.", Rec."Document No.");
        BarcodeTr.SetRange("Item No.", rec."Item No.");
        BarcodeTr.SetRange("Item Line No.", Rec."Item Line No.");
        if BarcodeTr.FindLast() then
            Rec."Line No." := BarcodeTr."Line No." + 10000
        else
            Rec."Line No." := 10000;

        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange(SaleLine."No.", Rec."Item No.");
        SaleLine.SetRange("Line No.", Rec."Item Line No.");
        if SaleLine.FindFirst() then begin
            Rec."Location Code" := SaleLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Purchase;
        end;
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        POTracking: Record "Master Barcode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductBarTracking: Record "Purchase Return Tracking";
        POtrack: Decimal;
        Cartontrc: Decimal;
        proBarTrc: Decimal;
        POQty: Decimal;
        POLine: Record "Purchase Line";
        SOLine: Record "Purchase Line";
        TransLine: Record "Purchase Line";
        IteMJnLine: Record "Item Journal Line";
    begin
        Clear(POtrack);
        Clear(Cartontrc);
        Clear(proBarTrc);
        Clear(POQty);


        ProductBarTracking.Reset();
        ProductBarTracking.SetRange("Document No.", Rec."Document No.");
        ProductBarTracking.SetRange("Item No.", Rec."Item No.");
        ProductBarTracking.SetRange("Item Line No.", Rec."Item Line No.");
        if ProductBarTracking.FindFirst() then
            repeat
                proBarTrc += 1;
            until ProductBarTracking.Next() = 0;

        SOLine.Reset();
        SOLine.SetRange("Document No.", Rec."Document No.");
        SOLine.SetRange("Line No.", Rec."Item Line No.");
        SOLine.SetRange(SOLine."No.", Rec."Item No.");
        if SOLine.FindFirst() then begin
            SOLine.Validate(Quantity, proBarTrc);
            SOLine.Modify();
        end;
    end;
}
