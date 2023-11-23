tableextension 50000 ItemExt extends Item
{
    fields
    {
        modify(Description)
        {
            Caption = 'Product Name';
        }
        modify("Description 2")
        {
            Caption = 'Description';
        }
        field(50000; Brand; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Brand".Code;
        }
        field(50001; "SPQ(Std. product Qty)"; Decimal)
        {

            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50002; "MOQ(Minimum order Qty)"; Decimal)
        {

            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50003; "Item Origin"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Requested By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Requested Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "QC Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Used In Segment"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Barcode Tracking"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Customer Design Part No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Design Part"."Design Part No.";
        }
        field(50010; "Price Category"; Option)
        {
            OptionMembers = ,SADA,"Non-SADA";
            trigger OnValidate()
            var
            begin
                if xRec."Price Category" <> Rec."Price Category" then
                    PriceCategoryModificationDate := Today;
            end;
        }
        field(50011; "Allocation Type"; Option)
        {
            OptionMembers = ,Allocate,"Non- Allocate";
        }
        field(50012; "PriceCategoryModificationDate"; Date)
        {
            Caption = 'Price Category Modification Last Date';
            DataClassification = ToBeClassified;

        }
        field(50013; "Item Sub Category 1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Item Sub Category 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            var
                Itemcategory: Record "Item Category";
            begin
                Itemcategory.Reset();
                Itemcategory.SetRange(code, "Item Category Code");
                if Itemcategory.FindFirst() then begin
                    "Item Sub Category 1" := Itemcategory."Item Sub Category 1";
                    "Item Sub Category 2" := Itemcategory."Item Sub Category 2";
                end;
            end;
        }
        field(50015; "Formula USD"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50016; "Formula INR"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50017; "Buying Rate (USD)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50018; "Buying Rate (INR)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50019; "DCPL Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50020; "Purchase MOQ Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50021; "Purchase MOQ"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50022; "Sales MOQ Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50023; "Sales MOQ Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50024; "Item Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50025; "Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50026; "Purchase price"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50027; "Master Bar Code"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50028; "Sub Carton Bar Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Product Bar Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Minimum Qty Level"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50031; "Max Qty Level"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50032; "Reorder Qty Level"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50033; "Product Group"; code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50034; "Product Sub-Group"; code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50035; "Product Division"; code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50036; "PNL Code"; code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50037; "Maturity"; code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50038; "New Release Price"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50039; "Bulk Qty"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50040; "Lead Time"; text[10])
        {
            DataClassification = ToBeClassified;

        }
    }
    var
        c: Record Customer;
}