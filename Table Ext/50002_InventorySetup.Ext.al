tableextension 50002 InventorySetup extends "Inventory Setup"
{
    fields
    {
        field(50000; "Requisition Nos"; Code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "No. Series";
        }
        field(50001; "Sales RFQ Nos"; Code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "No. Series";
        }
    }
}