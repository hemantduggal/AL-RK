tableextension 50008 Customerext1 extends Customer
{
    fields
    {
        field(50000; "Temporary Credit Limit"; Decimal)
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            begin

            end;
        }
        field(50001; "Tender No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50002; "Tender Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50003; "Remaining Credit Limit"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(50004; "Email id"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "PAN No."; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Freight Term"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Freight Master".Code;
        }
        field(50007; "TAN No."; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "MSME No."; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "TDS Declaration"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "TemporaryCrPeriod(From Date)"; Date)
        {
            Caption = 'Temporary Credit Limit (From Date)';
            DataClassification = ToBeClassified;
        }
        field(50011; "TemporaryCrPeriod(To Date)"; Date)
        {
            Caption = 'Temporary Credit Limit (To Date)';
            DataClassification = ToBeClassified;
        }
        field(50012; "Credit Limit Remaining"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Purchase person"; Code[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50014; Zone; Code[20])
        {
            DataClassification = Tobeclassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(50015; Remarks; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50016; "Owner Name"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50017; "Contact No.1"; Text[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50018; "Contact No.2"; Text[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50019; "Contact No.3"; Text[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50020; "Emal-Id 1"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50021; "Emal-Id 2"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50022; "Old Salesperson"; Code[20])
        {
            DataClassification = Tobeclassified;
            // TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50023; "Account Person Name"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50024; MSME; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(50025; Freight; Option)
        {
            DataClassification = Tobeclassified;
            OptionMembers = "To Pay","To Paid";
        }
    }

}
