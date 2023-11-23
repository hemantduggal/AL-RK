table 50022 "Brand Master"
{
    fields
    {
        field(1; Code; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Brand".Code;
        }
        field(2; Description; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Purchase Order","Sales Order","Sales RFQ","Sales Quote","FAE Design",Pricing;
        }
        field(4; "Type of Notification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Doc Header","Doc Line Item Approval","Sada price Expiry Date","Sada Price Debit Open Qty";

        }
        field(5; Department; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Purchase,Sales,Marketing,FAE,Pricing;
        }
        field(6; "Brand Owner"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Email; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Email2; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Email3; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Email4; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(11; Email5; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Sales Person"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(13; "User Id"; Code[50])
        {
            DataClassification = Tobeclassified;
            TableRelation = "User Setup"."User ID";
        }
        field(14; "Approver 1"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(15; "Approver 2"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(16; "Product manager"; Text[50])
        {
            DataClassification = Tobeclassified;
        }

        field(17; "Product manager Assistant"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(18; "Product manager 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(19; "Product manager Assistant 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }

    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}