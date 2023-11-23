page 50027 "Account ID Master List"
{
    ApplicationArea = All;
    Caption = 'Account ID Master List';
    PageType = List;
    SourceTable = "AccountID Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(AccountID; Rec.AccountID)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}