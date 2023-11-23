tableextension 50031 Vle extends "Vendor Ledger Entry"
{
    fields
    {

        field(50000; Remarks; text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50001; Narration; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50002; Zone; Code[10])
        {
            DataClassification = Tobeclassified;
        }
    }
}