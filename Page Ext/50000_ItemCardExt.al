pageextension 50000 ItemcardExt extends "Item Card"
{
    layout
    {

        modify("Manufacturer Code")
        {
            Visible = false;
        }
        modify("No.")
        {
            Caption = 'Manufacturer Part No.';
            Visible = true;
        }
        movebefore(Description; "No.")
        modify(Description)
        {
            Caption = 'Product Name';
        }
        modify("Search Description")
        {
            Caption = 'Description';
        }
        moveafter(Description; "Search Description")
        addafter("Search Description")
        {
            field("Lead Time"; Rec."Lead Time")
            {
                ApplicationArea = All;
            }

            field("Minimum Qty Level"; Rec."Minimum Qty Level")
            {
                ApplicationArea = All;
            }

            field("Max Qty Level"; Rec."Max Qty Level")
            {
                ApplicationArea = All;
            }

            field("Reorder Qty Level"; Rec."Reorder Qty Level")
            {
                ApplicationArea = All;
            }
            field("Purchase price"; Rec."Purchase price")
            {
                ApplicationArea = All;
            }
            field("Margin %"; Rec."Margin %")
            {
                ApplicationArea = All;
            }

            field(Brand; Rec.Brand)
            {
                ApplicationArea = All;
            }
            field("SPQ(Std. product Qty)"; Rec."SPQ(Std. product Qty)")
            {
                Caption = 'SPQ';
                ApplicationArea = All;
            }
            field("MOQ(Minimum order Qty)"; Rec."MOQ(Minimum order Qty)")
            {
                Caption = 'MOQ';
                ApplicationArea = All;
            }
            field("Item Origin"; Rec."Item Origin")
            {
                ApplicationArea = All;
            }
            field("Requested By"; Rec."Requested By")
            {
                ApplicationArea = All;
            }
            field("Requested Date"; Rec."Requested Date")
            {
                ApplicationArea = All;
            }
            field("QC Item"; Rec."QC Item")
            {
                ApplicationArea = All;
            }
            field("Used In Segment"; Rec."Used In Segment")
            {
                ApplicationArea = All;
            }
            field("Barcode Tracking"; Rec."Barcode Tracking")
            {
                ApplicationArea = All;
            }
            field("Customer Design Part No."; Rec."Customer Design Part No.")
            {
                ApplicationArea = All;
            }
            field("Price Category"; Rec."Price Category")
            {
                ApplicationArea = All;
            }
            field("Allocation Type"; Rec."Allocation Type")
            {
                ApplicationArea = All;
            }
            field(PriceCategoryModificationDate; Rec.PriceCategoryModificationDate)
            {
                Caption = 'Price Category Modification date';
                ApplicationArea = All;
                trigger OnValidate()
                var
                begin
                    if xRec."Price Category" <> Rec."Price Category" then
                        Rec.PriceCategoryModificationDate := Today;
                end;
            }
            field("Item Sub Category 1"; Rec."Item Sub Category 1")
            {
                ApplicationArea = All;
            }
            field("Item Sub Category 2"; Rec."Item Sub Category 2")
            {
                ApplicationArea = All;
            }
            field("Formula USD"; Rec."Formula USD")
            {
                ApplicationArea = All;
            }
            field("Formula INR"; Rec."Formula INR")
            {
                ApplicationArea = All;
            }
            field("Buying Rate (INR)"; Rec."Buying Rate (INR)")
            {
                ApplicationArea = All;
            }
            field("Buying Rate (USD)"; Rec."Buying Rate (USD)")
            {
                ApplicationArea = All;

            }
            field("DCPL Price"; Rec."DCPL Price")
            {
                ApplicationArea = All;

            }
            field("Purchase MOQ"; Rec."Purchase MOQ")
            {
                ApplicationArea = All;

            }
            field("Purchase MOQ Qty"; Rec."Purchase MOQ Qty")
            {
                ApplicationArea = All;

            }
            field("Sales MOQ Qty"; Rec."Sales MOQ Qty")
            {
                ApplicationArea = All;

            }
            field("Sales MOQ Value"; Rec."Sales MOQ Value")
            {
                ApplicationArea = All;

            }
            field("Item Weight"; Rec."Item Weight")
            {
                ApplicationArea = All;

            }
            field("Master Bar Code"; Rec."Master Bar Code")
            {
                ApplicationArea = all;
            }
            field("Sub Carton Bar Code"; Rec."Sub Carton Bar Code")
            {
                ApplicationArea = all;
            }
            field("Product Bar Code"; Rec."Product Bar Code")
            {
                ApplicationArea = all;
            }
            field("Product Group"; Rec."Product Group")
            {
                ApplicationArea = All;
            }
            field("Product Sub-Group"; Rec."Product Sub-Group")
            {
                ApplicationArea = All;
            }
            field("Product Division"; Rec."Product Division")
            {
                ApplicationArea = All;
            }
            field("PNL Code"; Rec."PNL Code")
            {
                ApplicationArea = All;
            }
            field(Maturity; Rec.Maturity)
            {
                ApplicationArea = All;
            }
            field("New Release Price"; Rec."New Release Price")
            {
                ApplicationArea = All;
            }
            field("Bulk Qty"; Rec."Bulk Qty")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(CopyItem)
        {
            action("Cust Design Part No.")
            {
                Promoted = true;
                ApplicationArea = All;
                RunObject = page "Customer Design Part No.";
                trigger OnAction()
                begin

                end;

            }

        }
    }
}