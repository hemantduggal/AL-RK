tableextension 50029 GateentryLine extends "Gate Entry Line"
{
    fields
    {
        field(50000; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        modify("Source No.")
        {
            trigger OnAfterValidate()
            var
                SaleHead: Record "Sales Header";
                saleShiphead: Record "Sales Shipment Header";
                GEH: Record "Gate Entry Header";
            begin

                saleShiphead.Reset();
                saleShiphead.SetRange("No.", Rec."Source No.");
                if saleShiphead.FindFirst() then begin
                    GEH.Reset();
                    GEH.SetRange("No.", Rec."Gate Entry No.");
                    GEH.SetRange("Entry Type", Rec."Entry Type");
                    if GEH.FindFirst() then
                        GEH."Source No." := saleShiphead."Order No.";
                    // Message('%1', saleShiphead."Order No.");
                    GEH.Modify();
                    "Order No." := saleShiphead."Order No.";
                end;
            end;
        }

    }
}
