pageextension 50016 locExt extends "Location Card"
{
    layout
    {
        addafter(Name)
        {
            field("Location Type"; Rec."Location Type")
            {
                ApplicationArea = All;
            }
        }
    }
}