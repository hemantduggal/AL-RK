page 50016 "Short Close SO"
{

    SourceTable = "Sales Header";
    SourceTableView = where("Short Close" = const(true));
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Sales Order";
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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
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