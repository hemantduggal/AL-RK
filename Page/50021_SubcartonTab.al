page 50021 "Subcarton List"
{
    SourceTable = "SubCarton Table";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(group)
            {

                field("PO No."; Rec."PO No.")
                {
                    Applicationarea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Applicationarea = All;

                }
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                }
                field("It PO No."; Rec."It PO No.")
                {
                    Applicationarea = All;
                }
                field("Item Line No."; Rec."Item Line No.")
                {
                    Applicationarea = All;
                }
                field("Carton Barcode No."; Rec."Carton Barcode No.")
                {
                    Applicationarea = All;

                }
                field("Sub Carton Barcode No."; Rec."Sub Carton Barcode No.")
                {
                    Applicationarea = All;

                }
                field("Item Barcode No."; Rec."Item Barcode No.")
                {
                    Applicationarea = All;

                }
                field("Line No."; Rec."Line No.")
                {
                    Applicationarea = All;

                }
            }
        }
    }
}