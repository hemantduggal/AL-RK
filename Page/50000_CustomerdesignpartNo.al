page 50000 "Customer Design Part No."
{

    SourceTable = "Customer Design Part";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Design Part No."; Rec."Design Part No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Brand; Rec.Brand)
                {
                    ApplicationArea = All;
                }


            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Cust Design Part No.")
            {
                Caption = 'Import Cust Design Part No.';
                Promoted = true;
                ApplicationArea = All;
                RunObject = xmlport ImportCustDesignpartNo;

            }
        }
    }
}