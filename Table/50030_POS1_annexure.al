table 50030 POS1
{
    Caption = 'POS1';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(2; "Part"; Code[20])
        {
            Caption = 'Part';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(3; "Opening STK"; Decimal)
        {
            Caption = 'Opening STK';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;

        }
        field(4; "O. Value"; Decimal)
        {
            Caption = 'O. Value';
            DataClassification = ToBeClassified;
        }
        field(5; "Purchase Qty"; Decimal)
        {
            Caption = 'Purchase Qty';
        }
        field(6; "purchase value"; Decimal)
        {
            Caption = 'purchase value';
            DataClassification = ToBeClassified;
        }
        field(7; "Total Reported"; Decimal)
        {
            Caption = 'Total Reported';
            DataClassification = ToBeClassified;
        }
        field(8; "sales Qty"; Decimal)
        {
            Caption = 'sales Qty';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(9; "sales value"; Decimal)
        {
            Caption = 'sales value';
            DataClassification = ToBeClassified;
        }
        field(10; "Closing STK"; Decimal)
        {
            Caption = 'Closing STK';
            DataClassification = ToBeClassified;
        }
        field(11; "C. Value @ POP"; Decimal)
        {
            Caption = 'C. Value @ POP';
            DataClassification = ToBeClassified;
        }
        field(12; "C. Value @ DCPL"; Decimal)
        {
            Caption = 'C. Value @ DCPL';
            DataClassification = ToBeClassified;
        }
        field(13; POP; Decimal)
        {
            Caption = 'POP';
            DataClassification = ToBeClassified;
        }
        field(14; POS; Decimal)
        {
            Caption = 'POS';
            DataClassification = ToBeClassified;
        }
        field(15; DCPL; Decimal)
        {
            Caption = 'DCPL';
            DataClassification = ToBeClassified;
        }
        field(16; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Close;
        }
        field(17; Inserted; Boolean)
        {

            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Account No.")
        {
            Clustered = true;
        }
    }
    var
        value: Record "Value Entry";
}
