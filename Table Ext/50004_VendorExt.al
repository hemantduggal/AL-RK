tableextension 50004 VendorExt1 extends Vendor
{
    fields
    {
        field(50000; "Vendor Registration No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50001; "Vendor Registration Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50002; Remarks; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50003; Zone; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50004; "Owner Name"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50005; "Contact No.1"; Text[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50006; "Contact No.2"; Text[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50007; "Contact No.3"; Text[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50008; "Email-Id 1"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50009; "Email-Id 2"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50010; "SalesPerson"; Code[100])
        {
            DataClassification = Tobeclassified;
            //TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50011; "Account Name"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
    }
}