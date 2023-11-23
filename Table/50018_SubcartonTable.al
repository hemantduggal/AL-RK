table 50018 "SubCarton Table"
{
    fields
    {
        field(1; "PO No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(2; "Location Code"; Code[20])
        {
            DataClassification = Tobeclassified;

        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(4; "It PO No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(5; "Item Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(6; "Carton Barcode No."; Code[30])
        {
            DataClassification = Tobeclassified;

        }
        field(7; "Sub Carton Barcode No."; Code[30])
        {
            DataClassification = Tobeclassified;

        }
        field(8; "Item Barcode No."; code[30])
        {
            DataClassification = Tobeclassified;

        }
        field(9; "Line No."; Integer)
        {
            DataClassification = Tobeclassified;

        }

    }

    keys
    {
        key(Key1; "PO No.")
        {

            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GLAcc: Record 15;
        Item: Record 27;
}

