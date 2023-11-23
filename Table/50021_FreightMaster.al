table 50021 "Freight Master"
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
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}