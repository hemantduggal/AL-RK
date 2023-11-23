table 50020 "Sada price List"
{
    fields
    {
        field(1; "Account No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(2; "Item No. (MPN)"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                recitem: Record Item;
            begin
                recitem.Reset();
                recitem.Get("Item No. (MPN)");
                "Item Name" := recitem.Description;
            end;
        }
        field(3; "Item Name"; code[50])
        {
            DataClassification = Tobeclassified;
        }
        field(4; "Customer No."; code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                recitem: Record Customer;
            begin
                recitem.Reset();
                recitem.Get("Customer No.");
                "Item Name" := recitem.Name;
            end;
        }
        field(5; "Customer Name"; code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(6; "End Customer Name"; code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(7; "Debit Number"; code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(8; "Item Start Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(9; "Item Expiry Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(10; Currency; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(11; "Debit Open Qty"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(12; "Debit Ship Qty"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(13; "Debit Rem. Qty"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(14; "Debit Open Qty Percentage"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(15; "Adj. Cost"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(16; "Adj. Resale"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(17; "DBC. (DCPL Price)"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(18; "Remaining Qty"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(19; "Buying Customer 1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Buying Customer 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Buying Customer 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Buying Customer 4"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Buying Customer 5"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Buying Customer Qty %1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Buying Customer Qty %2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Buying Customer Qty %3"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Buying Customer Qty %4"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Buying Customer Qty %5"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Expire in 15 days"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Expire in 30 days"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No", "Item No. (MPN)")
        {
            Clustered = true;
        }
    }
}