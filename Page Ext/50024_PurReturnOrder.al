pageextension 50024 PurReturn extends "Purchase Return Order"
{
    layout
    {

        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }

        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including';
        }
        addafter("Document Date")
        {
            field("Return Shipment No. Series"; Rec."Return Shipment No. Series")
            {
                ApplicationArea = All;

            }
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
                ApplicationArea = All;

            }
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = All;

            }
            field("Return Shipment No."; Rec."Return Shipment No.")
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
                        purchLine: Record "Purchase Line";
                    begin

                        purchLine.Reset();
                        purchLine.SetRange("Document No.", Rec."No.");
                        purchLine.SetRange("Document Type", purchLine."Document Type"::"Return Order");
                        if purchLine.FindSet() then begin
                            repeat
                                purchLine.TestField("Direct Unit Cost");
                                purchLine.TestField("Unit Price (LCY)");
                            until purchLine.Next() = 0;
                        end;
                    end;
                }
                */

        modify(Post)
        {
            trigger OnBeforeAction()
            var
                TLRec: Record "Purchase Line";
                ItemRec: Record Item;
                BarCodeTrack: Record "Purchase Return Tracking";
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
                                BarCodeTrack.SetRange("Entry Type", BarCodeTrack."Entry Type"::Purchase);
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