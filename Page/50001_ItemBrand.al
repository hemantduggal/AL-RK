page 50001 "Item Brand"
{

    SourceTable = "Item Brand";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Product manager"; Rec."Product manager")
                {
                    ApplicationArea = All;
                }
                field("Product manager 2"; Rec."Product manager 2")
                {
                    ApplicationArea = All;
                }
                field("Product manager Assistant"; Rec."Product manager Assistant")
                {
                    ApplicationArea = All;
                }
                field("Product manager Assistant 2"; Rec."Product manager Assistant 2")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}