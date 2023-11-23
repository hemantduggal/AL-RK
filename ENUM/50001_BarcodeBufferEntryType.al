enum 50001 "Barcode Buffer Entry Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; " ") { }
    value(1; "Sales") { Caption = 'Sales'; }
    value(2; "Purchase") { Caption = 'Purchase'; }
    value(3; "Item Journal Line") { Caption = 'Item Journal Line'; }
    value(4; "Transfer") { Caption = 'Transfer'; }
    value(5; NRGP) { Caption = 'NRGP'; }
    value(6; Consumption) { Caption = 'Consumption'; }
}