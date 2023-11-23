table 50006 "Sales RFQ Header"
{

    fields
    {
        field(1; "RFQ Doc No."; Code[20])
        {
            DataClassification = Tobeclassified;

            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                IF "RFQ Doc No." <> xRec."RFQ Doc No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Sales RFQ Nos");
                    NoSeriesMgt.SetSeries("RFQ Doc No.");
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
        field(4; "Customer No."; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.Reset();
                Cust.get("Customer No.");
                "Customer Name" := Cust.Name;
                Zone := Cust.Zone;
                Salesperson := Cust."Salesperson Code";
                "Contact person" := Cust."Purchase person";
                "Contact No." := Cust."Contact No.2";

            end;
        }
        field(5; "Customer Name"; text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(6; "Original Customer Name"; text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(7; Remarks; text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "No. Series";
        }
        field(9; Location; code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = Location.Code;
        }
        field(10; Salesperson; code[20])
        {
            DataClassification = Tobeclassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }
        field(14; "Approval Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(15; Type; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = ,RFQ,Order;

        }
        field(16; "Currency Code"; Code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = Currency.Code;

        }
        field(17; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Quote Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Your Ref."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; Zone; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(22; "Dummy Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Contact person"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Contact No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }

    }

    keys
    {
        key(Key1; "RFQ Doc No.")
        {

            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        UserSetRec: Record "User Setup";
    begin

        IF "RFQ Doc No." = '' THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Sales RFQ Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Sales RFQ Nos", Rec."No. Series", 0D, "RFQ Doc No.", "No. Series");
        END;

        "Document Date" := WorkDate;
        "Posting Date" := WorkDate;
        UserSetRec.Get(UserId);
        Zone := UserSetRec.Zone;
        Salesperson := UserSetRec.Salesperson;
        "Shortcut Dimension 2 Code" := UserSetRec.Branch;
    end;

    var
        RecVendor: Record 23;
        SalesSetup: Record 311;
        PurchSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit 396;
        UserSetupMgt: Codeunit 5700;
}

