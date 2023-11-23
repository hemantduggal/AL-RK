pageextension 50026 postPurRcptSubform extends "Posted Purchase Rcpt. Subform"
{
    layout
    {

        modify(Description)
        {
            Caption = 'Manufacture Part No.';
        }

        addafter(Description)
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                Applicationarea = All;
            }
            field("Requisition Line No."; Rec."Requisition Line No.")
            {
                Applicationarea = All;
            }
            field(Application; Rec.Application)
            {
                Applicationarea = All;
            }
            field(project; Rec.project)
            {
                Applicationarea = All;
            }

            field(POP; Rec.POP)
            {
                Applicationarea = All;
            }
            field(BQ; Rec.BQ)
            {
                Applicationarea = All;
            }
            field("End Customer"; Rec."End Customer")
            {
                Applicationarea = All;
            }
            field(LT; Rec.LT)
            {
                Applicationarea = All;
            }
            field(SPQ; Rec.SPQ)
            {
                Applicationarea = All;
            }
            field(MOQ; Rec.MOQ)
            {
                Applicationarea = All;
            }
        }
    }
}