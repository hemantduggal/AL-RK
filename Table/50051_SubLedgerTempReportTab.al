table 50051 "Sub Ledger Temp Table"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(3; "Account"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Product Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Brand; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "INR Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Credit Amt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Debit Amt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Salesperson Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Payment Term"; code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        key(Key1; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {

        }
    }
}