table 50012 "Terms Condition Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Material",Service;
        }

    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
}