pageextension 50001 ItemcatExt extends "Item Category Card"
{
    layout
    {
        addafter(Code)
        {
            field("Item Sub Category 1"; Rec."Item Sub Category 1")
            {
                ApplicationArea = All;
            }
            field("Item Sub Category 2"; Rec."Item Sub Category 2")
            {
                ApplicationArea = All;
            }
        }
    }
}