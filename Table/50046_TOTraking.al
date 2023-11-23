table 50046 "TO Tracking"
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
            trigger OnValidate()
            var
                BarCOdeLedGErENtr: Record "Barcode Ledger Entry";
            begin
                BarCOdeLedGErENtr.Reset();
                BarCOdeLedGErENtr.SetRange(BarCOdeLedGErENtr."item No.", "Item No.");
                BarCOdeLedGErENtr.SetRange("Location Code", "Location Code");
                BarCOdeLedGErENtr.SetRange("Master Barcode No.", "Master Barcode No.");
                if NOT BarCOdeLedGErENtr.FindFirst() then
                    Error('Master barcode does not exist');
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
        field(8; "Carton Barcode No."; Text[30])
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            var
                BarCOdeLedGErENtr: Record "Barcode Ledger Entry";
            begin
                BarCOdeLedGErENtr.Reset();
                BarCOdeLedGErENtr.SetRange(BarCOdeLedGErENtr."item No.", "Item No.");
                BarCOdeLedGErENtr.SetRange("Location Code", "Location Code");
                BarCOdeLedGErENtr.SetRange("Carton Barcode No.", "Carton Barcode No.");
                if BarCOdeLedGErENtr.FindFirst() then
                    "Master Barcode No." := BarCOdeLedGErENtr."Master Barcode No."
                else
                    Error('Carton barcode does not exist');
            end;
        }
        field(9; "Product Barcode No."; Text[30])
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            var
                BarCOdeLedGErENtr: Record "Barcode Ledger Entry";
            begin
                BarCOdeLedGErENtr.Reset();
                BarCOdeLedGErENtr.SetRange(BarCOdeLedGErENtr."item No.", "Item No.");
                BarCOdeLedGErENtr.SetRange("Location Code", "Location Code");
                BarCOdeLedGErENtr.SetRange("Product Barcode No.", "Product Barcode No.");
                if BarCOdeLedGErENtr.FindFirst() then begin
                    "Master Barcode No." := BarCOdeLedGErENtr."Master Barcode No.";
                    "Carton Barcode No." := BarCOdeLedGErENtr."Carton Barcode No.";
                end else
                    Error('Product barcode does not exist');
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

