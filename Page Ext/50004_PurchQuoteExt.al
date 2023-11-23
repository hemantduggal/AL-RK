pageextension 50004 PurchQuoteExt extends "Purchase Quote"
{
    layout
    {
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Caption = 'Price Including';
        }

        addafter("Order Date")
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        modify(Release)
        {
            trigger OnAfterAction()
            var
                purchLine: Record "Purchase Line";
            begin
                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::Quote);
                if purchLine.FindSet() then begin
                    repeat
                        purchLine.TestField("Direct Unit Cost");
                    //  purchLine.TestField("Unit Price (LCY)");
                    until purchLine.Next() = 0;
                end;
            end;
        }
        modify(MakeOrder)
        {
            trigger OnAfterAction()
            var
                purchLine: Record "Purchase Line";
            begin

                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::Quote);
                if purchLine.FindSet() then begin
                    repeat
                        if purchLine."Remaining Qty" > 0 then begin
                            purchLine."Remaining Qty" := purchLine."Remaining Qty" - purchLine."Make Order Qty";
                            purchLine.Modify();
                        end;
                    until purchLine.Next() = 0;

                end;
            end;

            trigger OnBeforeAction()
            var
                purchLine: Record "Purchase Line";
            begin
                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::Quote);
                if purchLine.FindSet() then begin
                    repeat
                        if purchLine."Remaining Qty" = 0 then
                            Error('you have already make order of total qty');
                    until purchLine.Next() = 0;
                end;
            end;
        }
    }
}