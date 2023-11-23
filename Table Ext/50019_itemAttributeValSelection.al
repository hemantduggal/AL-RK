tableextension 50019 AttributeExt extends "Item Attribute Value Selection"
{
    fields
    {
        field(50000; Brand; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Brand".Code;
        }
    }
}