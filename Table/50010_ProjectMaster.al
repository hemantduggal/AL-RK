table 50010 "Project Master"
{
    fields
    {
        field(1; Code; code[40])
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