
page 50058 "Product Barcode Tracking"
{

    SourceTable = "Product BarCode Tracking";
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
                    Editable = false;
                    Applicationarea = All;
                }
                field("Master Barcode No."; Rec."Master Barcode No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Carton Barcode No."; Rec."Carton Barcode No.")
                {
                    Editable = false;
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
        SaleLine: Record "Sales Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin
        transhead.Reset();
        transhead.SetRange("Document No.", Rec."Document No.");
        transhead.SetRange(transhead."Item No.", Rec."Item No.");
        if transhead.FindFirst() then begin
            Rec."Location Code" := transhead."Transfer-from Code";
            Rec."Entry Type" := Rec."Entry Type"::Transfer;
        end;

        IJL.Reset();
        IJL.SetRange("Document No.", Rec."Document No.");
        if IJL.FindFirst() then begin
            Rec."Location Code" := IJL."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::"Item Journal Line";
        end;
        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange(SaleLine."No.", Rec."Item No.");
        if SaleLine.FindFirst() then begin
            Rec."Location Code" := SaleLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Sales;
        end;
        PurLineLine.Reset();
        PurLineLine.SetRange("Document No.", Rec."Document No.");
        PurLineLine.SetRange(PurLineLine."No.", Rec."Item No.");
        if PurLineLine.FindFirst() then begin
            Rec."Location Code" := PurLineLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Purchase;
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BarcodeTr: Record "Product BarCode Tracking";
        transhead: Record "Transfer Line";
        SaleLine: Record "Sales Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin
        BarcodeTr.Reset();
        BarcodeTr.SetRange("Document No.", Rec."Document No.");
        BarcodeTr.SetRange("Item No.", rec."Item No.");
        BarcodeTr.SetRange("Item Line No.", Rec."Item Line No.");
        BarcodeTr.SetRange("Master Barcode No.", Rec."Master Barcode No.");
        BarcodeTr.SetRange("Carton Barcode No.", Rec."Carton Barcode No.");
        if BarcodeTr.FindLast() then
            Rec."Line No." := BarcodeTr."Line No." + 10000
        else
            Rec."Line No." := 10000;
        transhead.Reset();
        transhead.SetRange("Document No.", Rec."Document No.");
        transhead.SetRange(transhead."Item No.", Rec."Item No.");
        if transhead.FindFirst() then begin
            Rec."Location Code" := transhead."Transfer-from Code";
            Rec."Entry Type" := Rec."Entry Type"::Transfer;
        end;

        IJL.Reset();
        IJL.SetRange("Document No.", Rec."Document No.");
        if IJL.FindFirst() then begin
            Rec."Location Code" := IJL."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::"Item Journal Line";
        end;
        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange(SaleLine."No.", Rec."Item No.");
        if SaleLine.FindFirst() then begin
            Rec."Location Code" := SaleLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Sales;
        end;
        PurLineLine.Reset();
        PurLineLine.SetRange(PurLineLine."No.", Rec."Item No.");
        PurLineLine.SetRange("Document No.", Rec."Document No.");
        if PurLineLine.FindFirst() then begin
            Rec."Location Code" := PurLineLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Purchase;
        end;


    end;


}
