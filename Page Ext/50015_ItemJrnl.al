pageextension 50015 ItemJrnlExt extends "Item Journal"
{
    layout
    {

    }
    actions
    {
        addafter(Post)
        {
            action(BarcodeTracking)
            {
                //Promoted = true;
                ApplicationArea = All;
                RunObject = page "Master Barcode Tracking";
                Promoted = true;
                PromotedCategory = Process;
                RunPageLink = "Document No." = field("Document No."), "Item Line No." = field("Line No."), "Item No." = field("Item No.");

                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if ItemRec.Get(Rec."Item No.") then begin
                        if ItemRec."Master Bar Code" = false then
                            Error('You do not have permission to open master barcodetracking');
                    end else
                        Error('You do not have permission to open master barcodetracking');
                end;
            }

            action(BarcodeTrackingForNegative)
            {
                //Promoted = true;
                ApplicationArea = All;
                RunObject = page "Item JN Tracking";
                Promoted = true;
                PromotedCategory = Process;
                RunPageLink = "Document No." = field("Document No."), "Item Line No." = field("Line No."), "Item No." = field("Item No.");

                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if Rec."Entry Type" <> Rec."Entry Type"::"Negative Adjmt." then
                        Error('Entry Type must be Negative Adjmt.');
                    if ItemRec.Get(Rec."Item No.") then begin
                        if ItemRec."Master Bar Code" = false then
                            Error('You do not have permission to open master barcodetracking');
                    end else
                        Error('You do not have permission to open master barcodetracking');


                end;
            }

        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var

                ItemRec: Record Item;
                IJLRec: Record "Item Journal Line";
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");

            END;
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        POTracking: Record "Master Barcode Tracking";
        CartonTracking: Record "Carton BarCode Tracking";
        ProductBarTracking: Record "Product BarCode Tracking";
    begin
        Clear(POTracking);
        Clear(CartonTracking);
        Clear(ProductBarTracking);

        POTracking.Reset();
        POTracking.SetRange("Document No.", Rec."Document No.");
        POTracking.SetRange("Entry Type", POTracking."Entry Type"::Purchase);
        POTracking.SetRange("Item No.", Rec."Item No.");
        POTracking.SetRange("Item Line No.", Rec."Line No.");
        POTracking.SetRange("Location Code", Rec."Location Code");
        if POTracking.FindFirst() then
            POTracking.DeleteAll();

        CartonTracking.Reset();
        CartonTracking.SetRange("Document No.", Rec."Document No.");
        CartonTracking.SetRange("Entry Type", POTracking."Entry Type"::Purchase);
        CartonTracking.SetRange("Item No.", Rec."Item No.");
        CartonTracking.SetRange("Item Line No.", Rec."Line No.");
        CartonTracking.SetRange("Location Code", Rec."Location Code");
        if CartonTracking.FindFirst() then
            CartonTracking.DeleteAll();

        ProductBarTracking.Reset();
        ProductBarTracking.SetRange("Document No.", Rec."Document No.");
        ProductBarTracking.SetRange("Entry Type", POTracking."Entry Type"::Purchase);
        ProductBarTracking.SetRange("Item No.", Rec."Item No.");
        ProductBarTracking.SetRange("Item Line No.", Rec."Line No.");
        ProductBarTracking.SetRange("Location Code", Rec."Location Code");
        if ProductBarTracking.FindFirst() then
            ProductBarTracking.DeleteAll();
    end;


}