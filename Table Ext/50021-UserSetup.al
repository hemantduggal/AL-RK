tableextension 50021 UserSetup extends "User Setup"
{
    fields
    {
        field(50000; "Purchase Order Creation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Quote,Order,Invoice;
        }
        field(50001; "Purchase Order"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Edit,Create,View;
        }
        field(50002; "Purchase Quote"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Edit,Create,View;
        }
        field(50003; "Posted Purchase Receipt"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Edit,Create,View;
        }
        field(50004; "Posted Purchase Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Edit,Create,View;
        }
        field(50005; Branch; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Branch';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(50006; Zone; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(50007; "Salesperson"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }
        field(50008; "Product manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "HO User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Sale Quote"; option)
        {
            OptionMembers = " ",Edit,Create,View;
        }
    }
}