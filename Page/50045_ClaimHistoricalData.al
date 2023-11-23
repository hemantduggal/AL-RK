page 50045 "Claim Historical Data"
{
    ApplicationArea = All;
    Caption = 'Claim Historical Data';
    PageType = List;
    SourceTable = Claim_Historical_Detail;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("P/N"; Rec."P/N")
                {
                    ToolTip = 'Specifies the value of the POP field.';
                }
                field(POP; Rec.POP)
                {
                    ToolTip = 'Specifies the value of the POP field.';
                }
                field(POS; Rec.POS)
                {
                    ToolTip = 'Specifies the value of the POS field.';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }


                field("sales Qty"; Rec."sales Qty")
                {
                    ToolTip = 'Specifies the value of the sales Qty field.';
                }
                field("WK Date"; Rec."WK Date")
                {
                    ToolTip = 'Specifies the value of the sales value field.';
                }
                field(DCPL; Rec.DCPL)
                {
                    ToolTip = 'Specifies the value of the sales value field.';
                }
                field("Debit No."; Rec."Debit No.")
                {
                    ToolTip = 'Specifies the value of the sales value field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the sales value field.';
                }
            }
        }
    }
}
