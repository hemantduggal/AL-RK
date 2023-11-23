table 50035 Claim_Historical_Detail
{
    Caption = 'Claim_Historical_Data';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "P/N"; Code[50])
        {
            Caption = 'P/N';
            DataClassification = ToBeClassified;
        }
        field(2; "Sales QTY"; Decimal)
        {
            Caption = 'Sales QTY';
            DataClassification = ToBeClassified;
        }
        field(3; "WK Date"; Date)
        {
            Caption = 'WK Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Debit No."; Code[20])
        {
            Caption = 'Debit No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(6; INV; Code[20])
        {
            Caption = 'INV';
            DataClassification = ToBeClassified;
        }
        field(7; POS; Decimal)
        {
            Caption = 'POS';
            DataClassification = ToBeClassified;
        }
        field(8; POP; Decimal)
        {
            Caption = 'POP';
            DataClassification = ToBeClassified;
        }
        field(9; "Customer Name"; Code[50])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(10; DCPL; Decimal)
        {
            Caption = 'DCPL';
            DataClassification = ToBeClassified;
        }
        field(11; "Value Claim"; Decimal)
        {
            Caption = 'Value Claim';
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Close;
        }
        field(13; "Entry No"; Integer)
        {

            DataClassification = ToBeClassified;
        }
        field(15; Inserted; Boolean)
        {

            DataClassification = ToBeClassified;
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
