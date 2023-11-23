table 50004 "Requisition Header"
{

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            DataClassification = Tobeclassified;

            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                IF "Requisition No." <> xRec."Requisition No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Requisition Nos");
                    NoSeriesMgt.SetSeries("Requisition No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Document Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(4; "Department Code"; Code[30])
        {
            DataClassification = Tobeclassified;
            // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(5; "Employee Code"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Employee."No.";
        }
        field(6; "To Location"; Code[30])
        {
            DataClassification = Tobeclassified;
            TableRelation = Location.Code;

        }
        field(7; Remarks; text[100])
        {
            DataClassification = Tobeclassified;
        }

        field(8; "No. Series"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "No. Series";
        }
        field(9; "Shortcut Dimenssion 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            CaptionClass = '1,2,1';
        }

        field(10; "Shortcut Dimenssion 2"; Code[20])
        {
            Caption = 'Shortcut Dimenssion 2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            CaptionClass = '1,2,2';
        }
        field(11; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                if VendorRec.Get("Vendor No.") then
                    "Vendor Name" := VendorRec.Name
                else
                    "Vendor Name" := '';
            end;
        }
        field(12; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "User ID"; Text[30])
        {

            DataClassification = Tobeclassified;
        }
    }

    keys
    {
        key(Key1; "Requisition No.")
        {

            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF "Requisition No." = '' THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Requisition Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Requisition Nos", Rec."No. Series", 0D, "Requisition No.", "No. Series");
        END;
    end;

    var
        RecVendor: Record 23;
        SalesSetup: Record 311;
        PurchSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit 396;
        UserSetupMgt: Codeunit 5700;
}

