pageextension 50035 Purchorderlist extends "Purchase Order List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Short Close"; Rec."Short Close")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        Rec.SetFilter("Short Close", '%1', false);
    end;

    trigger OnOpenPage()
    var
    begin
        Rec.SetFilter("Short Close", '%1', false);
    end;
}