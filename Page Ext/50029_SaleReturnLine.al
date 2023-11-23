pageextension 50029 SaleReturnorderline extends "sales Return Order Subform"
{
    actions
    {
        addafter("Item Availability by")
        {
            action(BarcodeTracking)
            {
                //Promoted = true;
                ApplicationArea = All;
                RunObject = page "SO Barcode Tracking";
                RunPageLink = "SO No." = field("Document No."), "Item Line No." = field("Line No."), "Item No." = field("No.");
                trigger OnAction()
                var
                begin

                end;

            }
        }
    }

}