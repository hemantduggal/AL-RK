page 50044 "POS Historical Data"
{
    ApplicationArea = All;
    Caption = 'POS1 Historical Data';
    PageType = List;
    SourceTable = POS1Historical;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("C. Value @ DCPL"; Rec."C. Value @ DCPL")
                {
                    ToolTip = 'Specifies the value of the C. Value @ DCPL field.';
                }
                field("C. Value @ POP"; Rec."C. Value @ POP")
                {
                    ToolTip = 'Specifies the value of the C. Value @ POP field.';
                }
                field("Closing STK"; Rec."Closing STK")
                {
                    ToolTip = 'Specifies the value of the Closing STK field.';
                }
                field(DCPL; Rec.DCPL)
                {
                    ToolTip = 'Specifies the value of the DCPL field.';
                }
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("O. Value"; Rec."O. Value")
                {
                    ToolTip = 'Specifies the value of the O. Value field.';
                }
                field("Opening STK"; Rec."Opening STK")
                {
                    ToolTip = 'Specifies the value of the Opening STK field.';
                }
                field(POP; Rec.POP)
                {
                    ToolTip = 'Specifies the value of the POP field.';
                }
                field(POS; Rec.POS)
                {
                    ToolTip = 'Specifies the value of the POS field.';
                }
                field("Part"; Rec."Part")
                {
                    ToolTip = 'Specifies the value of the Part field.';
                }
                field("Purchase Qty"; Rec."Purchase Qty")
                {
                    ToolTip = 'Specifies the value of the Purchase Qty field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Total Reported"; Rec."Total Reported")
                {
                    ToolTip = 'Specifies the value of the Total Reported field.';
                }
                field("purchase value"; Rec."purchase value")
                {
                    ToolTip = 'Specifies the value of the purchase value field.';
                }
                field("sales Qty"; Rec."sales Qty")
                {
                    ToolTip = 'Specifies the value of the sales Qty field.';
                }
                field("sales value"; Rec."sales value")
                {
                    ToolTip = 'Specifies the value of the sales value field.';
                }
            }
        }
    }
}
