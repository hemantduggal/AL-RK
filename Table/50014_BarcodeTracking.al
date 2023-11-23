table 50014 "Barcode Tracking"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "TO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "From Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(5; "To Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(6; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Item Barcode No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "TO No.", "Item No.", "Item Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
