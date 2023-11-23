page 50030 "FAE List"
{
    ApplicationArea = All;
    Caption = 'FAE List';
    PageType = List;
    SourceTable = "FAE Header";
    UsageCategory = Lists;
    CardPageId = "FAE card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Opportunity Document No."; Rec."Opportunity Document No.")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Opportunity Document No. field.';
                }
                field("Opportunity Date"; Rec."Opportunity Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Opportunity Date field.';
                }
                field("Opportunity Status"; Rec."Opportunity Status")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Opportunity Status field.';
                }
                field("Product Segment"; Rec."Product Segment")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Product Segment field.';
                }
                field("Customer Buyer"; Rec."Customer Buyer")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Customer Buyer field.';
                }
            }
        }
    }
}
