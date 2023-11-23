report 50003 MasterBarc
{
    UsageCategory = Administration;
    Caption = 'update brand';
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            trigger OnAfterGetRecord()
            var
                recitem: Record Item;
            begin
                recitem.Reset();
                recitem.SetRange("No.", "Item Ledger Entry"."Item No.");
                if recitem.FindFirst() then
                    "Item Ledger Entry".Brand := recitem.Brand;
                "Item Ledger Entry".Modify();
            end;
        }
    }
}