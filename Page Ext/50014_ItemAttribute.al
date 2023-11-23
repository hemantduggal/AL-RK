pageextension 50014 ItemAttributeExt extends "Item Attribute Value List"
{
    layout
    {
        addafter("Unit of Measure")
        {
            field(Brand; Rec.Brand)
            {
                ApplicationArea = All;
            }
        }
    }
}