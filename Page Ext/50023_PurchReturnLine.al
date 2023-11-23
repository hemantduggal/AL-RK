pageextension 50023 PurchReturn extends "Purchase Return Order Subform"
{
    layout
    {
        modify(Description)
        {
            Caption = 'Manufacture Part No.';
        }
    }
    actions
    {
        addafter("Item Availability by")
        {
            action(BarcodeTracking)
            {
                //Promoted = true;
                ApplicationArea = All;
                RunObject = page "PR Barcode Tracking";
                RunPageLink = "Document No." = field("Document No."), "Item Line No." = field("Line No."), "Item No." = field("No.");
                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if ItemRec.Get(Rec."No.") then begin
                        if ItemRec."Master Bar Code" = false then
                            Error('You do not have permission to open master barcodetracking');
                    end else
                        Error('You do not have permission to open master barcodetracking');
                end;

            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        POTracking: Record "Master Barcode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductBarTracking: Record "Purchase Return Tracking";
    begin
        Clear(POTracking);
        Clear(CartonTracking);
        Clear(ProductBarTracking);


        ProductBarTracking.Reset();
        ProductBarTracking.SetRange("Document No.", Rec."Document No.");
        ProductBarTracking.SetRange("Item No.", Rec."No.");
        ProductBarTracking.SetRange("Item Line No.", Rec."Line No.");
        // ProductBarTracking.SetRange("Location Code", Rec."Location Code");
        if ProductBarTracking.FindFirst() then
            ProductBarTracking.DeleteAll();
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.Type := Rec.Type::Item;
    end;

}