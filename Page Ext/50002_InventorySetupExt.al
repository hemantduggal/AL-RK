pageextension 50002 InventoryExt extends "Inventory Setup"
{
    layout
    {
        addafter("Package Nos.")
        {
            field("Requisition Nos"; Rec."Requisition Nos")
            {
                ApplicationArea = All;
            }
            field("Sales RFQ Nos"; Rec."Sales RFQ Nos")
            {
                ApplicationArea = All;
            }
        }
    }
}