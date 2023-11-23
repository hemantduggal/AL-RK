table 50025 "FAE Header"
{

    fields
    {
        field(1; "Opportunity Document No."; Code[20])
        {
            Caption = 'Opportunity Document No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                IF "Opportunity Document No." <> xRec."Opportunity Document No." THEN BEGIN
                    salesetup.GET;
                    NoSeriesMgt.TestManual(salesetup."FAE Opportunity document No.");
                    NoSeriesMgt.SetSeries("Opportunity Document No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Sales Organization"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer Buyer"; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(4; "Customer Buyer E-mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Design RegistrationProjectName"; Text[50])
        {
            Caption = 'Design Registration Project Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Production Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Project Description"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Project Created By(User Name)"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Project Created On"; Date)
        {
            Caption = 'Project Created On(Document Creation Date)';
            DataClassification = ToBeClassified;
        }
        field(10; "Product Segment"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Segment Master".Code;
        }
        field(11; "Program/Lead"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Opportunity Status"; Option)
        {
            OptionMembers = " ",Approved,Reject,Closed,Win,Lost;
            OptionCaption = ' ,Approved,Reject,Closed,Win,Lost';

        }
        field(13; "Opportunity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Support FAE"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Account Manager"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            trigger OnValidate()
            var
                SH: Record "Sales Header";
                days: Integer;
                RemainDays: Integer;
                day1: Integer;
            begin


                /*
                                SH.Reset();
                                SH.SetRange("No.", Rec."Sale Order No.");
                                if SH.FindFirst() then begin
                                    days := Date2DMY(SH."Document Date", 1);
                                    RemainDays := Today - SH."Document Date";
                                    // Message('%1....%2..', days, RemainDays);
                                    if RemainDays > 30 then begin
                                        Error('You cannot link so to the respective opportunity after 30 days of SO creation');
                                    end else begin
                                        "SO Link Approval Status" := "SO Link Approval Status"::"Pending For Approval";
                                        Message('SO Link Approval Request send');
                                    end;
                                end;
                                */
            end;

        }
        field(17; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                RecCust: Record Customer;
            begin
                RecCust.Reset();
                RecCust.Get("Customer No.");
                "Customer Name" := RecCust.Name;
            end;


        }
        field(18; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(19; "No. Series"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "No. Series";
        }
        field(20; "Document Date"; Date)
        {
            DataClassification = Tobeclassified;

        }
        field(21; "Posting Date"; Date)
        {
            DataClassification = Tobeclassified;

        }
        field(22; "Location Code"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Location.Code;
        }
        field(23; "SO Link Approval Status"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending For Approval",Approved;

        }
    }
    keys
    {
        key(PK; "Opportunity Document No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

        IF "Opportunity Document No." = '' THEN BEGIN
            salesetup.GET;
            salesetup.TESTFIELD("FAE Opportunity document No.");
            NoSeriesMgt.InitSeries(salesetup."FAE Opportunity document No.", Rec."No. Series", 0D, "Opportunity Document No.", "No. Series");
        END;
    end;

    var
        salesetup: Record "Sales & Receivables Setup";

        NoSeriesMgt: Codeunit 396;
}