pageextension 50039 CompInfo extends "Company Information"
{
    layout
    {
        addafter(Name)
        {
            field("Udyam No."; Rec."Udyam No.")
            {
                ApplicationArea = All;
            }
        }
    }
}