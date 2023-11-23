pageextension 50041 PostGateout extends "Posted Outward Gate Entry"
{
    layout
    {
        addafter(Description)
        {
            field("Container No."; Rec."Container No.")
            {
                ApplicationArea = All;
            }
            field("Transporter No."; Rec."Transporter No.")
            {
                ApplicationArea = All;
            }
            field("Source No."; Rec."Source No.")
            {
                Caption = 'Order No.';
                ApplicationArea = All;
            }
        }
    }
}