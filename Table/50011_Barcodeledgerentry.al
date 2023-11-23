table 50011 "Barcode Ledger Entry"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Document Type"; Enum "Barcode Ledger Document Type")
        {
            Caption = 'Document Type';
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Location Code"; Code[20])
        {
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;
        }
        field(6; "item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Item Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "ILE No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Carton Barcode No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Sub Carton Barcode No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Item Barcode No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Master Barcode No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Product Barcode No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Entry Type"; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = ,Purchase,Sales,Transfer,"Item Journal Line";

        }
        field(16; "Serial No"; Text[30])
        {
            DataClassification = Tobeclassified;

        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}