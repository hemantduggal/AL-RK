page 50018 "LC Master"
{
    SourceTable = "LC No";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(group)
            {

                field("LC No."; Rec."LC No.")
                {
                    Applicationarea = All;
                }
                field(Description; Rec.Description)
                {
                    Applicationarea = All;
                }
                field(LC_Date; Rec.LC_Date)
                {
                    Applicationarea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Applicationarea = All;
                }
            }
        }
    }
}