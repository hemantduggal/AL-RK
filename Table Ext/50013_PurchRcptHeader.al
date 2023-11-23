tableextension 50013 PurRcptHeadExt extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; Remarks; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50001; "Requisition No."; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Requisition Header"."Requisition No.";

        }
        field(50002; "Customer Refrence No."; Text[30])
        {
            DataClassification = Tobeclassified;
        }
        field(50003; "Account ID"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "AccountID Master".AccountID;

        }
        field(50004; "LC Applicable"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(50005; "LC No."; code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "LC No"."LC No.";
        }
        field(50006; "Customer No."; code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = Customer."No.";
        }
        field(50007; "No. of packing"; code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50008; "Short Close"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(50009; "CHA Vendor No."; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50010; "Shipping Line Vendor"; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50011; "Import Type"; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = ,Import,Domestic;
        }
        field(50012; "PO Type"; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = ,Regular,Sample;
        }
        field(50013; "SO No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50014; "SO Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50015; "SO Cust No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50016; "End Customer"; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50017; "Refrence No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50018; "Opp. Refrence No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50019; Zone; Code[10])
        {
            DataClassification = Tobeclassified;
        }
    }
}