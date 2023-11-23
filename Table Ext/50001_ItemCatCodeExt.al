tableextension 50001 ItemcatCodeExt extends "Item Category"
{
    fields
    {
        field(50000; "Item Sub Category 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item category Sub Code 1".Code;
        }
        field(50001; "Item Sub Category 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item category Sub Code 2".Code;
        }
    }
}