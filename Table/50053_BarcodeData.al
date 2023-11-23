table 50053 "Barcode Data"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = Tobeclassified;

        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }

        field(4; "Item Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
    }
    keys
    {

        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}