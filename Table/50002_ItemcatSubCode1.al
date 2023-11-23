table 50002 "Item category Sub Code 1"
{
    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; code[50])
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