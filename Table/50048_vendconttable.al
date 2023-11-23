table 50048 Vendor_Contact
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contact No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Mobile No."; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Phone No."; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "E mail"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Designation; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Vendor No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(key1; "Contact No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}