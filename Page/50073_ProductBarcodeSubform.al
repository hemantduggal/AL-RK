
page 50073 "Product Barcode Subform"
{

    SourceTable = "Product BarCode Tracking";
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    // InsertAllowed = true;
    //ModifyAllowed = true;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(group)
            {

                field("Document No."; Rec."Document No.")
                {
                    Applicationarea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                }
                field("Item Line No."; Rec."Item Line No.")
                {
                    Applicationarea = All;
                }

                field("Location Code"; Rec."Location Code")
                {
                    Applicationarea = All;
                }

                field("Product Barcode No."; Rec."Product Barcode No.")
                {

                    ApplicationArea = all;

                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}