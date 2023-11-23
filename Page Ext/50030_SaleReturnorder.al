pageextension 50030 SaleReturn extends "Sales Return Order"
{
    layout
    {

        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Registration No.")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including';
        }

        addafter("Document Date")
        {
            field("Return Receipt No."; Rec."Return Receipt No.")
            {
                ApplicationArea = All;
            }
            field("Return Receipt No. Series"; Rec."Return Receipt No. Series")
            {
                ApplicationArea = All;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        /*
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                purchLine: Record "Sales Line";
            begin

                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::"Return Order");
                if purchLine.FindSet() then begin
                    repeat
                        purchLine.TestField("Unit Cost");
                        purchLine.TestField("Unit Price");
                    until purchLine.Next() = 0;
                end;
            end;
        }
        */
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                v: Page "Sales Return Order";
                TLRec: Record "Sales Line";
                ItemRec: Record Item;
                BarCodeTrack: Record "Master Barcode Tracking";
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");

                TLRec.Reset();
                TLRec.SetRange("Document No.", Rec."No.");
                TLRec.SetRange("Document Type", Rec."Document Type");
                if TLRec.FindFirst() then
                    repeat
                        if ItemRec.Get(TLRec."No.") then begin
                            if ItemRec."Barcode Tracking" = true then begin
                                BarCodeTrack.Reset();
                                BarCodeTrack.SetRange("Document No.", TLRec."Document No.");
                                BarCodeTrack.SetRange("Entry Type", BarCodeTrack."Entry Type"::Sales);
                                BarCodeTrack.SetRange("Item No.", TLRec."No.");
                                if Not BarCodeTrack.FindFirst() then
                                    Error('Please attach barcode tracking on this item %1', TLRec."No.");
                            end;
                        end;
                    until TLRec.Next() = 0;
            end;
        }
    }
}
