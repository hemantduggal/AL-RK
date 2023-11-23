pageextension 50008 GateInward extends "Inward Gate Entry"
{
    layout
    {
        addafter(Description)
        {
            field(Reason; Rec.Reason)
            {
                ApplicationArea = All;
            }
            field("Container No."; Rec."Container No.")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
            field("Driver Name"; Rec."Driver Name")
            {
                ApplicationArea = All;
            }
            field("Mobile No."; Rec."Mobile No.")
            {
                ApplicationArea = All;
            }
        }
    }
}