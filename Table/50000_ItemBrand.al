table 50000 "Item Brand"
{
    fields
    {
        field(1; Code; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Product manager"; Text[50])
        {
            DataClassification = Tobeclassified;
        }

        field(4; "Product manager Assistant"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(5; "Product manager 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(6; "Product manager Assistant 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}