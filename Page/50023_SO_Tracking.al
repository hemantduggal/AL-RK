
page 50023 "SO Barcode Tracking"
{

    SourceTable = "SO Tracking";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("SO No."; Rec."SO No.")
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
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BarcodeTr: Record "SO Tracking";
        transhead: Record "Sales Line";
    begin
        BarcodeTr.Reset();
        BarcodeTr.SetRange("SO No.", Rec."SO No.");
        BarcodeTr.SetRange("Item No.", rec."Item No.");
        BarcodeTr.SetRange("Item Line No.", Rec."Item Line No.");
        if BarcodeTr.FindLast() then
            Rec."Line No." := BarcodeTr."Line No." + 10000
        else
            Rec."Line No." := 10000;

        transhead.SetRange("Document No.", Rec."SO No.");
        if transhead.FindFirst() then
            Rec."Location Code" := transhead."Location Code";
    end;

}
