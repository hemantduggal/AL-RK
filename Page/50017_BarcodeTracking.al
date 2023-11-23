
page 50017 "Barcode Tracking"
{

    SourceTable = "Barcode Tracking";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("TO No."; Rec."TO No.")
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
                field("From Location"; Rec."From Location")
                {
                    Applicationarea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    Applicationarea = All;
                }
                field("Item Barcode No."; Rec."Item Barcode No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BarcodeTr: Record "Barcode Tracking";
        transhead: Record "Transfer Header";
    begin
        BarcodeTr.Reset();
        BarcodeTr.SetRange("TO No.", Rec."TO No.");
        BarcodeTr.SetRange("Item No.", rec."Item No.");
        BarcodeTr.SetRange("Item Line No.", Rec."Item Line No.");
        if BarcodeTr.FindLast() then
            Rec."Line No." := BarcodeTr."Line No." + 10000
        else
            Rec."Line No." := 10000;

        if transhead.Get(Rec."TO No.") then begin
            Rec."From Location" := transhead."Transfer-from Code";
            Rec."To Location" := transhead."Transfer-to Code";
        end;
    end;
    /*
        trigger OnInsertRecord(BelowxRec: Boolean): Boolean
        var
            BarcodeTr: Record "Barcode Tracking";
        begin
            BarcodeTr.Reset();
            BarcodeTr.SetRange("TO No.", Rec."TO No.");
            BarcodeTr.SetRange("Item No.", rec."Item No.");
            BarcodeTr.SetRange("Item Line No.", Rec."Item Line No.");
            if BarcodeTr.FindLast() then
                Rec."Line No." := BarcodeTr."Line No." + 10000
            else
                Rec."Line No." := 10000;
        end;

    */
}
