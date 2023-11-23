page 50034 "Line Wise Approval Setup"
{
    ApplicationArea = All;
    Caption = 'Line Wise Approval Setup';
    PageType = List;
    SourceTable = Linewiseapprovalsetup;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("On the Basis"; Rec."On the Basis")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the On the Basis field.';
                }
                field("Sale Quote Approval"; Rec."Sale Quote Approval")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Sale Quote Approval field.';
                }
                field("Sale RFQ Approval"; Rec."Sale RFQ Approval")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Sale RFQ Approval field.';
                }
                field("Email Id"; Rec."Email Id")
                {
                    Applicationarea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the User Name field.';
                }

                field("User ID"; Rec."User ID")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Category 5 %"; Rec."Category 5 %")
                {
                    Applicationarea = All;
                }
                field("Category 10 %"; Rec."Category 10 %")
                {
                    Applicationarea = All;
                }
                field("Category 15 %"; Rec."Category 15 %")
                {
                    Applicationarea = All;
                }
                field(Enable; Rec.Enable)
                {
                    Applicationarea = All;
                }
            }
        }
    }
}
