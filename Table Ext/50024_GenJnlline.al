tableextension 50024 genJnlLine extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Requisition No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50001; "Requisition Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50002; Application; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Application Master".Code;
        }
        field(50003; project; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Project Master".Code;
        }
        field(50004; "Delivery Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50005; POP; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50006; BQ; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50007; "End Customer"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Customer."No.";
        }
        field(50008; LT; TEXT[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50009; SPQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50010; MOQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50011; "Employee Code"; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50012; "Item Barcode No."; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50013; "Cost price"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50014; "Design Part No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Direct Unit Cost"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }

        field(50016; Rate; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50017; Brand; Code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Item Brand".Code;
        }
        field(50018; "Carton Barcode No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Sub Carton Barcode No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; Zone; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50024; "Product manager"; Text[50])
        {
            DataClassification = Tobeclassified;
        }

        field(50025; "Product manager Assistant"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(50026; "Product manager 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(50027; "Product manager Assistant 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
    }
}