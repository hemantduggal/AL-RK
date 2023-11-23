table 50034 "POS2_Historical data"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {

            DataClassification = ToBeClassified;
        }
        field(2; "Account No"; Code[50])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
        }
        field(3; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(5; Invoice; Code[50])
        {
            Caption = 'Invoice';
            DataClassification = ToBeClassified;
        }
        field(6; POS; Decimal)
        {
            Caption = 'POS';
            DataClassification = ToBeClassified;
        }
        field(7; "sales Qty"; Decimal)
        {
            Caption = 'sales Qty';
            DataClassification = ToBeClassified;
        }
        field(8; POP; Decimal)
        {
            Caption = 'POP';
            DataClassification = ToBeClassified;
        }
        field(9; "Customer name"; Code[50])
        {
            Caption = 'Customer name';
            DataClassification = ToBeClassified;
        }
        field(10; "Value(pop)"; Decimal)
        {
            Caption = 'Value(pop)';
            DataClassification = ToBeClassified;
        }
        field(11; Month; Code[20])
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
        }
        field(12; Quarter; Code[10])
        {
            Caption = 'Quarter';
            DataClassification = ToBeClassified;
        }
        field(13; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Close;
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
