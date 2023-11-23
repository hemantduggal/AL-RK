pageextension 50050 clepage extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Document Date")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field(Zone; Rec.Zone)
            {
                ApplicationArea = All;
            }

        }
    }
}