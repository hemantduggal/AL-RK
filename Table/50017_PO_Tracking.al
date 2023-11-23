table 50017 "PO Tracking"
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

        field(4; "Item Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(5; "Carton Barcode No."; Text[30])
        {
            DataClassification = Tobeclassified;

        }
        field(6; "Line No."; Integer)
        {
            DataClassification = Tobeclassified;

        }
        field(7; Status; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = ,Accept,Reject;

        }

    }

    keys
    {

        key(Key1; "PO No.", "Item No.", "Item Line No.", "Line No.")
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

