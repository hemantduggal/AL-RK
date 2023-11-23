table 50028 Linewiseapprovalsetup
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "User Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Sale RFQ Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sale Quote Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "On the Basis"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Item,Quantity,"Unit price","Price Category","Less Margin","Allocation","Remaining Qty","Price Update","Brand Approval","FAE Line Approval";
        }
        field(7; "Category 5 %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Category 10 %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Category 15 %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Email Id"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Designation; Option)
        {
            OptionMembers = " ","Sales Head","Purchase Head";
        }
        field(12; Enable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Entry No", "User ID")
        {
            Clustered = true;
        }
    }
}