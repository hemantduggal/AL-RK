
page 50050 "PO Carton Tracking"
{

    SourceTable = "Carton BarCode Tracking";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("PO No."; Rec."PO No.")
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



    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BarcodeTr: Record "PO Tracking";
        transhead: Record "Purchase Line";
    begin
        BarcodeTr.Reset();
        BarcodeTr.SetRange("PO No.", Rec."PO No.");
        BarcodeTr.SetRange("Item No.", rec."Item No.");
        BarcodeTr.SetRange("Item Line No.", Rec."Item Line No.");
        if BarcodeTr.FindLast() then
            Rec."Line No." := BarcodeTr."Line No." + 10000
        else
            Rec."Line No." := 10000;

        transhead.SetRange("Document No.", Rec."PO No.");
        if transhead.FindFirst() then
            Rec."Location Code" := transhead."Location Code";
    end;


}
