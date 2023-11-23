tableextension 50018 SaleShipline extends "Sales Shipment Line"
{
    fields
    {


        field(50000; Brand; code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Item Brand".Code;
        }

        field(50001; LT; TEXT[10])
        {
            DataClassification = Tobeclassified;
        }

        field(50002; SPQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50003; MOQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50004; "Commission %"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50005; "Customer Part No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "RFQ Doc No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50007; "Salesperson Code"; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50008; "RFQ Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50009; Application; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Application Master".Code;
        }
        field(50010; project; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Project Master".Code;
        }
        field(50011; "Cost price"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50012; Rate; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50013; "Margin is Less"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(50014; "Price Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(50015; Remarks; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50016; "Allocation Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(50017; "Line Approval Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(50018; "Remaining Approval Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }

        field(50019; "FAE Opportunity Document No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50020; "Fullfillment Type"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = ',Inventory,UID';
            OptionMembers = ,Inventory,UID;
        }
        field(50021; "UID Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50022; "UID"; code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50023; "Part No."; code[20])
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            begin
                UID := "Part No." + '_' + format("UID Date");
            end;
        }
    }
}