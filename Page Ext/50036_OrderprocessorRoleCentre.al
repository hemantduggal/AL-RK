
pageextension 50036 RoleCentre extends "SO Processor Activities"
{
    layout
    {
        addbefore("For Release")
        {
            cuegroup("Item To Be Expired")
            {
                Caption = 'Item To Be Expired';
                field("Item Expired Within 15days"; Rec."Item Expired Within 15days")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Expired Within 15days';
                    DrillDownPageID = "Sada Price List";
                    trigger OnDrillDown()
                    begin
                        // ShowOrders1(FieldNo("Item Expired Within 15days"));
                    end;
                }
            }
        }
    }
    procedure ShowOrders1(FieldNumber: Integer)
    var
        SalesHeader: Record "Sada price List";
    begin
        FilterOrders1(SalesHeader, FieldNumber);
        PAGE.Run(PAGE::"Sada Price List", SalesHeader);
    end;

    local procedure FilterOrders1(var SalesHeader: Record "Sada price List"; FieldNumber: Integer)
    begin

    end;
}
