pageextension 50033 saleinv extends "Sales Invoice"
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
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                var
                    VendLedgPage: Page "Posted Outward GateEntry List";
                    VendorLedgerEntry: Record "Posted Gate Entry Header";
                begin
                    VendorLedgerEntry.Reset();
                    // VendorLedgerEntry.SetFilter("Entry Type", '%1', VendorLedgerEntry."Entry Type"::Outward);
                    //VendorLedgerEntry.SetRange("Source No.", Rec."No.");
                    VendLedgPage.SETTABLEVIEW(VendorLedgerEntry);
                    VendLedgPage.LOOKUPMODE(TRUE);
                    if (VendLedgPage.RunModal() = Action::LookupOK) then begin
                        VendLedgPage.GetRecord(VendorLedgerEntry);
                        Rec."Gate Entry No." := VendorLedgerEntry."No.";
                    end;
                end;
            }
            field("FAE Opportunity Document No."; Rec."FAE Opportunity Document No.")
            {
                ApplicationArea = All;
            }
            field("So Type"; Rec."So Type")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                faeHead: Record "FAE Header";
                SIH: Record "Sales Invoice Header";
                SIL: Record "Sales Invoice Line";
                TotLineAmt: Decimal;
            begin
                Rec.TestField("Gate Entry No.");
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");


                /*
                                Clear(TotLineAmt);
                                SIL.Reset();
                                SIL.SetRange("FAE Opportunity Document No.", Rec."FAE Opportunity Document No.");
                                if SIL.FindSet() then begin
                                    repeat
                                        TotLineAmt += SIL."Line Amount";
                                    until SIL.Next() = 0;
                                end;
                                if Rec."Currency Code" = 'USD' then begin
                                    if TotLineAmt > 1000 then begin
                                        faeHead.Reset();
                                        faeHead.SetRange("Opportunity Document No.", Rec."FAE Opportunity Document No.");
                                        if faeHead.FindFirst() then
                                            faeHead."Opportunity Status" := faeHead."Opportunity Status"::Win;
                                        faeHead.Modify();
                                    end;
                                end else begin
                                    if TotLineAmt > 80000 then begin
                                        faeHead.Reset();
                                        faeHead.SetRange("Opportunity Document No.", Rec."FAE Opportunity Document No.");
                                        if faeHead.FindFirst() then
                                            faeHead."Opportunity Status" := faeHead."Opportunity Status"::Win;
                                        faeHead.Modify();
                                    end;
                                end;
                */
            end;
        }
    }
}