pageextension 50042 GenJrnlExt extends "General Journal"
{
    layout
    {

    }
    actions
    {
        addafter(Post)
        {
            action(PayrollEntries)
            {
                //Promoted = true;
                Caption = 'Payroll Entries';
                ApplicationArea = All;
                RunObject = xmlport "Jrnl Jrnl Uploader";
                trigger OnAction()
                var
                begin

                end;

            }
        }
    }
}