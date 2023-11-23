page 50046 "POS2 Historical Data"
{
    ApplicationArea = All;
    Caption = 'POS2 Historical Data';
    PageType = List;
    SourceTable = "POS2_Historical data";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Customer name"; Rec."Customer name")
                {
                    ToolTip = 'Specifies the value of the Customer name field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field(Invoice; Rec.Invoice)
                {
                    ToolTip = 'Specifies the value of the Invoice field.';
                }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field(POP; Rec.POP)
                {
                    ToolTip = 'Specifies the value of the POP field.';
                }
                field(POS; Rec.POS)
                {
                    ToolTip = 'Specifies the value of the POS field.';
                }
                field("Part No."; Rec."Part No.")
                {
                    ToolTip = 'Specifies the value of the Part No. field.';
                }
                field(Quarter; Rec.Quarter)
                {
                    ToolTip = 'Specifies the value of the Quarter field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Value(pop)"; Rec."Value(pop)")
                {
                    ToolTip = 'Specifies the value of the Value(pop) field.';
                }
                field("sales Qty"; Rec."sales Qty")
                {
                    ToolTip = 'Specifies the value of the sales Qty field.';
                }
            }
        }
    }
}
