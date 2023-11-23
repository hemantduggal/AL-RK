page 50047 "EDD Master"
{
    ApplicationArea = All;
    Caption = 'EDD Master';
    PageType = List;
    SourceTable = EDDMaster;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("PO No"; Rec."PO No")
                {
                    ToolTip = 'Specifies the value of the PO No field.';
                }
                field("SO No"; Rec."SO No")
                {
                    ToolTip = 'Specifies the value of the SO No field.';
                }
                field("Sale Order Item"; Rec."Sale Order Item")
                {
                    ToolTip = 'Specifies the value of the Sale Order Item field.';
                }
                field("Schedule Line"; Rec."Schedule Line")
                {
                    ToolTip = 'Specifies the value of the Schedule Line field.';
                }
                field("Part no."; Rec."Part no.")
                {
                    ToolTip = 'Specifies the value of the Part no. field.';
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ToolTip = 'Specifies the value of the Requested Date field.';
                }
                field(EDD; Rec.EDD)
                {
                    ToolTip = 'Specifies the value of the EDD field.';
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    ToolTip = 'Specifies the value of the Ordered Qty field.';
                }
                field("Scheduled Qty"; Rec."Scheduled Qty")
                {
                    ToolTip = 'Specifies the value of the Scheduled Qty field.';
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
            }
        }
    }
}
