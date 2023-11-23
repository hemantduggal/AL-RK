table 50015 "LC No"
{
    fields
    {
        field(1; "LC No."; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; LC_Date; date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "LC No.")
        {
            Clustered = true;
        }
    }
}