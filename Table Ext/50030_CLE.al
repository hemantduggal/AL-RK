tableextension 50030 cle extends "Cust. Ledger Entry"
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