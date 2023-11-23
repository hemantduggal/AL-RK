table 50042 "Master Barcode Tracking"
{
    fields
    {
        field(1; "Document No."; Code[20])
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
            trigger OnValidate()
            var
                CartonBar: Record "Carton BarCode Tracking";
            begin
                CartonBar.Reset();
                CartonBar.SetRange("Document No.", Rec."Document No.");
                CartonBar.SetRange("Entry Type", Rec."Entry Type");
                CartonBar.SetRange("Location Code", Rec."Location Code");
                CartonBar.SetRange("Item No.", Rec."Item No.");
                CartonBar.SetRange("Item Line No.", Rec."Item Line No.");
                CartonBar.SetRange("Carton Barcode No.", "Carton Barcode No.");
                if CartonBar.FindFirst() then
                    Error('Alredy Master Barcode No. exist');
            end;

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
        field(8; "Entry Type"; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = ,Purchase,Sales,Transfer,"Item Journal Line","Purchase Return","Sales Return";

        }

    }

    keys
    {

        key(Key1; "Document No.", "Item No.", "Item Line No.", "Line No.")
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

