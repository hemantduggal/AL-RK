table 50033 POS1Historical
{
    Caption = 'POS1 Historical Data';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(3; "Part"; Code[20])
        {
            Caption = 'Part';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(4; "Opening STK"; Decimal)
        {
            Caption = 'Opening STK';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;

        }
        field(5; "O. Value"; Decimal)
        {
            Caption = 'O. Value';
            DataClassification = ToBeClassified;
        }
        field(6; "Purchase Qty"; Decimal)
        {
            Caption = 'Purchase Qty';
        }
        field(7; "purchase value"; Decimal)
        {
            Caption = 'purchase value';
            DataClassification = ToBeClassified;
        }
        field(8; "Total Reported"; Decimal)
        {
            Caption = 'Total Reported';
            DataClassification = ToBeClassified;
        }
        field(9; "sales Qty"; Decimal)
        {
            Caption = 'sales Qty';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(10; "sales value"; Decimal)
        {
            Caption = 'sales value';
            DataClassification = ToBeClassified;
        }
        field(11; "Closing STK"; Decimal)
        {
            Caption = 'Closing STK';
            DataClassification = ToBeClassified;
        }
        field(12; "C. Value @ POP"; Decimal)
        {
            Caption = 'C. Value @ POP';
            DataClassification = ToBeClassified;
        }
        field(13; "C. Value @ DCPL"; Decimal)
        {
            Caption = 'C. Value @ DCPL';
            DataClassification = ToBeClassified;
        }
        field(14; POP; Decimal)
        {
            Caption = 'POP';
            DataClassification = ToBeClassified;
        }
        field(15; POS; Decimal)
        {
            Caption = 'POS';
            DataClassification = ToBeClassified;
        }
        field(16; DCPL; Decimal)
        {
            Caption = 'DCPL';
            DataClassification = ToBeClassified;
        }
        field(17; Status; Option)
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
    var
        value: Record "Value Entry";
}
