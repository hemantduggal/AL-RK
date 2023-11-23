table 50013 "Terms Condition Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(3; Remarks; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(4; Remarks1; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Caption';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }
}