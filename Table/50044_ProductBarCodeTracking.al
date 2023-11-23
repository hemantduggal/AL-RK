table 50044 "Product BarCode Tracking"
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
        field(5; "Master Barcode No."; Text[30])
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
        field(8; "Carton Barcode No."; Text[30])
        {
            DataClassification = Tobeclassified;

        }
        field(9; "Product Barcode No."; Text[30])
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            var
                CartonBar: Record "Product BarCode Tracking";
            begin
                CartonBar.Reset();
                CartonBar.SetRange("Document No.", Rec."Document No.");
                CartonBar.SetRange("Location Code", Rec."Location Code");
                CartonBar.SetRange("Item No.", Rec."Item No.");
                CartonBar.SetRange("Item Line No.", Rec."Item Line No.");
                CartonBar.SetRange("Product Barcode No.", "Product Barcode No.");
                if CartonBar.FindFirst() then
                    Error('Alredy Product Barcode No. exist');
            end;
        }
        field(10; "Entry Type"; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = ,Purchase,Sales,Transfer,"Item Journal Line",,"Purchase Return","Sales Return";

        }
    }

    keys
    {

        key(Key1; "Document No.", "Item No.", "Item Line No.", "Line No.", "Master Barcode No.", "Carton Barcode No.")
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

