page 50012 "Short Close PO"
{

    SourceTable = "Purchase Header";
    SourceTableView = where("Short Close" = const(true));
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Purchase Order";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Short Close"; Rec."Short Close")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}