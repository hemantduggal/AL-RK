page 50070 "Barcode Data"
{
    Caption = 'Barcode Data';
    PageType = Document;
    SourceTable = "Barcode Data";
    ApplicationArea = All;
    // Editable = false;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Line No."; Rec."Item Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(MasterScanBarcode; MasterScanBarcode)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   IF GETLASTERRORTEXT <> '' THEN
                        //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                        // CurrPage.MasterBarcode.PAGE.SaleLineMasterScanBarcode(MasterScanBarcode);
                        CLEAR(MasterScanBarcode);
                        CurrPage.UPDATE;
                    end;
                }
                field(CartonScanBarcode; CartonScanBarcode)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   IF GETLASTERRORTEXT <> '' THEN
                        //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                        // CurrPage.SalesLines.PAGE.SaleLineCartonScanBarcode(CartonScanBarcode);
                        CLEAR(CartonScanBarcode);
                        CurrPage.UPDATE;
                    end;
                }
                field(ProductScanBarcode; ProductScanBarcode)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   IF GETLASTERRORTEXT <> '' THEN
                        //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                        //   CurrPage.SalesLines.PAGE.SaleLineProductScanBarcode(CartonScanBarcode);
                        CLEAR(ProductScanBarcode);
                        CurrPage.UPDATE;
                    end;
                }
            }
            part(MasterBarcode; "Master Barcode Subform")
            {
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("Document No.");
                ApplicationArea = All;
                Editable = false;
            }
            part(CartonBarcode; "Carton Barcode Subform")
            {
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("Document No.");
                ApplicationArea = All;
                Editable = false;
            }
            part(ProductBarcode; "Product Barcode Subform")
            {
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("Document No.");
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    var
        MasterScanBarcode: Code[20];
        CartonScanBarcode: Code[20];
        ProductScanBarcode: Code[20];
}