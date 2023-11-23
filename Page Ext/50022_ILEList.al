pageextension 50022 ILE extends "Item Ledger Entries"
{
    layout
    {
        addafter("Location Code")
        {
            field("Item Barcode No."; Rec."Item Barcode No.")
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