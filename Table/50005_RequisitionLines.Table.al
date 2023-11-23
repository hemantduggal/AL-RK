table 50005 "Requisition Lines"
{
    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                ReqHead: Record "Requisition Header";
                RecItem: Record Item;
            begin
                RecItem.Reset();
                RecItem.get("Item No.");
                Description := RecItem.Description;
                UOM := RecItem."Base Unit of Measure";
                Brand := RecItem.Brand;
                MOQ := RecItem."MOQ(Minimum order Qty)";
                SPQ := RecItem."SPQ(Std. product Qty)";
                LT := RecItem."Lead Time";
                "Description 2" := RecItem."Search Description";
                ReqHead.Reset();
                ReqHead.Get("Requisition No.");
                "Shortcut Dimenssion 1" := ReqHead."Shortcut Dimenssion 1";
                "Shortcut Dimenssion 2" := ReqHead."Shortcut Dimenssion 2";
                "Vendor No." := ReqHead."Vendor No.";
                "Vendor Name" := ReqHead."Vendor Name";
                "User ID" := ReqHead."User ID";
                "Location Code" := ReqHead."To Location";
                "Employee Code" := ReqHead."Employee Code";
                "Posting Date" := ReqHead."Posting Date";


            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(4; Quantity; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(5; UOM; Text[30])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Unit of Measure".Code;

        }

        field(6; "Department Code"; Code[30])
        {
            DataClassification = Tobeclassified;
            // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(7; "Employee Code"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Employee."No.";
        }
        field(8; Rate; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(9; Brand; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Item Brand".Code;
        }
        field(10; POP; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(11; BQ; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(12; Application; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Application Master".Code;
        }
        field(13; project; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Project Master".Code;
        }
        /*
        field(14; Customer; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Customer."No.";
        }
        */
        field(15; LT; TEXT[10])
        {
            DataClassification = Tobeclassified;
        }
        field(16; SPQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(17; MOQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(18; "Direct unit Cost"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 3;
        }
        field(19; "Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }

        field(20; "Location Code"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Location.Code;
        }
        field(21; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Shortcut Dimenssion 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            CaptionClass = '1,2,1';
        }

        field(23; "Shortcut Dimenssion 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            CaptionClass = '1,2,2';
        }
        field(24; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Item,FA;
            //Editable = false;
        }
        field(27; "Replenishment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Blanket Order","Purchase Quote","Purchase Order","Transfer Order";
            trigger OnValidate()
            begin

            end;
        }
        field(28; "Vendor No."; Code[20])
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
        field(29; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released,"PO Created","Goods Received";
        }
        field(30; "Description 2"; Text[50])
        {
            Caption = 'Description';
            DataClassification = Tobeclassified;
        }
        field(31; "User ID"; Text[30])
        {

            DataClassification = Tobeclassified;
        }
    }

    keys
    {
        key(Key1; "Requisition No.", "Line No.")
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

