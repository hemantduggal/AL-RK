page 50020 "Import Purhase Order"
{
    SourceTable = "Purchase Header";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = where("Import Type" = const(Import));
    CardPageId = "Purchase Order";
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
                field("Import Type"; Rec."Import Type")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}