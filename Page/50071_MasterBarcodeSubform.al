
page 50071 "Master Barcode Subform"
{

    SourceTable = "Master Barcode Tracking";
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

                field("Carton Barcode No."; Rec."Carton Barcode No.")
                {
                    Caption = 'Master Barcode No.';
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