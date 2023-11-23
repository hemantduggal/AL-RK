pageextension 50009 BlnktPurchorderExt extends "Blanket Purchase Order"
{
    layout
    {
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including';
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

            field("Account ID"; Rec."Account ID")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                purchLine: Record "Purchase Line";
            begin
                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::"Blanket Order");
                if purchLine.FindSet() then begin
                    repeat
                        purchLine.TestField("Direct Unit Cost");
                    // purchLine.TestField("Unit Price (LCY)");
                    until purchLine.Next() = 0;
                end;
            end;
        }
    }
}