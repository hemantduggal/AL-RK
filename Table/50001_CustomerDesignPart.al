table 50001 "Customer Design Part"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Brand; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Design Part No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Design Part No.", "Item No.")
        {
            Clustered = true;
        }
    }
}