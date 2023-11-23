table 50031 "POS2_Annexure"
{
    Caption = 'POS2_Annexure';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Account No"; Code[50])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
        }
        field(2; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; Invoice; Code[50])
        {
            Caption = 'Invoice';
            DataClassification = ToBeClassified;
        }
        field(5; POS; Decimal)
        {
            Caption = 'POS';
            DataClassification = ToBeClassified;
        }
        field(6; "sales Qty"; Decimal)
        {
            Caption = 'sales Qty';
            DataClassification = ToBeClassified;
        }
        field(7; POP; Decimal)
        {
            Caption = 'POP';
            DataClassification = ToBeClassified;
        }
        field(8; "Customer Name"; Code[50])
        {

            DataClassification = ToBeClassified;

        }
        field(9; "Value(pop)"; Decimal)
        {
            Caption = 'Value(pop)';
            DataClassification = ToBeClassified;
        }
        field(10; Month; Code[20])
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
        }
        field(11; Quarter; Code[10])
        {
            Caption = 'Quarter';
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Close;
        }
        field(15; Inserted; Boolean)
        {

            DataClassification = ToBeClassified;
        }
        field(16; "Customer No."; Code[50])
        {

            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                cust: Record Customer;
            begin
                cust.Reset();
                cust.get("Customer No.");
                "Customer Name" := cust.Name;
            end;
        }

    }
    keys
    {
        key(PK; "Account No")
        {
            Clustered = true;
        }
    }
}
