table 50024 "SalesRFQ Planning  Line"
{
    fields
    {
        field(1; "RFQ Doc No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = IF (Type = CONST(FA)) "Fixed Asset"."No."
            ELSE
            IF (Type = CONST(Item)) Item."No.";
            /*
                        trigger OnValidate()
                        var
                            RecItem: Record Item;
                            saleRfq: Record "Sales RFQ Header";
                            Sadapr: Record "Sada price List";
                        begin
                            RecItem.Reset();
                            RecItem.get("Item No.");
                            Description := RecItem.Description;
                            UOM := RecItem."Base Unit of Measure";
                            saleRfq.Reset();
                            saleRfq.Get("RFQ Doc No.");
                            Salesperson := saleRfq.Salesperson;
                            "Customer No." := saleRfq."Customer No.";
                            "Document Date" := saleRfq."Document Date";


                            if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
                                Sadapr.Reset();
                                Sadapr.SetRange("Item No. (MPN)", "Item No.");
                                Sadapr.SetRange("Customer No.", "Customer No.");
                                Sadapr.SetFilter("Item Start Date", '>= %1', "Document Date");
                                Sadapr.SetFilter("Item Expiry Date", '<=%1', "Document Date");
                                if Sadapr.FindFirst() then begin
                                    Rate := Sadapr."Adj. Cost";
                                end else begin
                                    Rate := RecItem."DCPL Price";
                                end;
                            end;
                        end;
                        */
        }
        field(3; Description; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(4; Quantity; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(5; "Customer No."; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(6; UOM; Text[30])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Unit of Measure".Code;

        }

        field(7; "Direct Unit Cost"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = Tobeclassified;
        }

        field(8; Rate; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(9; Brand; Code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Item Brand".Code;
        }
        field(10; Application; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Application Master".Code;
        }
        field(11; project; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Project Master".Code;
        }
        field(12; Salesperson; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(13; "Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(14; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Item,FA;
            //Editable = false;
        }
        field(15; "Cost price"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(16; "Design Part No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Document Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(18; "Replenishment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","sales Quote","sales Order";
            trigger OnValidate()
            begin

            end;
        }
        field(19; "Location Code"; Code[30])
        {
            DataClassification = Tobeclassified;
            TableRelation = Location.Code;
        }
        field(21; LT; TEXT[10])
        {
            DataClassification = Tobeclassified;
        }
        field(22; SPQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(23; MOQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(31; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Confirm Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(34; "Estimated Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(50035; "Cancelation reason"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50036; Cancel; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(37; "Product manager"; Text[50])
        {
            DataClassification = Tobeclassified;
        }

        field(38; "Product manager Assistant"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(39; "Product manager 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(40; "Product manager Assistant 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(41; "Customer Part No."; Text[50])
        {
            DataClassification = Tobeclassified;
            // TableRelation = "Customer Design Part"."Design Part No.";
        }
        field(42; "Description 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
    }

    keys
    {
        key(Key1; "RFQ Doc No.", "Line No.")
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

