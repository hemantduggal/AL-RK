
page 50057 "Carton Barcode Tracking"
{

    SourceTable = "Carton BarCode Tracking";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Item Line No."; Rec."Item Line No.")
                {
                    Editable = false;
                    Applicationarea = All;
                }

                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Applicationarea = All;
                }
                field("Master Barcode No."; Rec."Master Barcode No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Carton Barcode No."; Rec."Carton Barcode No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        CartonBar: Record "Product BarCode Tracking";
                    begin
                        CartonBar.Reset();
                        CartonBar.SetRange("Document No.", Rec."Document No.");
                        CartonBar.SetRange("Entry Type", Rec."Entry Type");
                        CartonBar.SetRange("Location Code", Rec."Location Code");
                        CartonBar.SetRange("Item No.", Rec."Item No.");
                        CartonBar.SetRange("Item Line No.", Rec."Item Line No.");
                        CartonBar.SetRange("Carton Barcode No.", xRec."Carton Barcode No.");
                        if CartonBar.FindFirst() then
                            Error('You do not have change the carton Barcode, Because line is already exist');
                    end;

                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action(CartonbarcodeTracking)
            {
                Caption = 'Product Barcode Tracking';
                //Promoted = true;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = page "Product Barcode Tracking";
                RunPageLink = "Document No." = field("Document No."), "Item Line No." = field("Item Line No."), "Item No." = field("Item No."),
                    "Master Barcode No." = field("Master Barcode No."), "Carton Barcode No." = field("Carton Barcode No.");
                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if ItemRec.Get(Rec."Item No.") then begin
                        if ItemRec."Product Bar Code" = false then
                            Error('You do not have permission to open master barcodetracking');
                    end else
                        Error('You do not have permission to open master barcodetracking');
                end;

            }
            action(Accept)
            {
                Image = Order;
                ApplicationArea = All;
                trigger OnAction()
                var
                begin
                    Rec.Status := Rec.Status::Accept;
                end;
            }
            action(Reject)
            {
                Image = Order;
                ApplicationArea = All;
                trigger OnAction()
                var
                begin
                    Rec.Status := Rec.Status::Reject;
                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        transhead: Record "Transfer Line";
        SaleLine: Record "Sales Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin
        transhead.Reset();
        transhead.SetRange("Document No.", Rec."Document No.");
        transhead.SetRange(transhead."Item No.", Rec."Item No.");
        if transhead.FindFirst() then begin
            Rec."Location Code" := transhead."Transfer-from Code";
            Rec."Entry Type" := Rec."Entry Type"::Transfer;
        end;

        IJL.Reset();
        IJL.SetRange("Document No.", Rec."Document No.");
        if IJL.FindFirst() then begin
            Rec."Location Code" := IJL."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::"Item Journal Line";
        end;
        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange(SaleLine."No.", Rec."Item No.");
        if SaleLine.FindFirst() then begin
            Rec."Location Code" := SaleLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Sales;
        end;
        PurLineLine.Reset();
        PurLineLine.SetRange("Document No.", Rec."Document No.");
        PurLineLine.SetRange(PurLineLine."No.", Rec."Item No.");
        if PurLineLine.FindFirst() then begin
            Rec."Location Code" := PurLineLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Purchase;
        end;


    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BarcodeTr: Record "Carton BarCode Tracking";
        transhead: Record "Transfer Line";
        SaleLine: Record "Sales Line";
        IJL: Record "Item Journal Line";
        PurLineLine: Record "Purchase Line";
    begin
        BarcodeTr.Reset();
        BarcodeTr.SetRange("Document No.", Rec."Document No.");
        BarcodeTr.SetRange("Item No.", rec."Item No.");
        BarcodeTr.SetRange("Item Line No.", Rec."Item Line No.");
        if BarcodeTr.FindLast() then
            Rec."Line No." := BarcodeTr."Line No." + 10000
        else
            Rec."Line No." := 10000;

        transhead.Reset();
        transhead.SetRange("Document No.", Rec."Document No.");
        transhead.SetRange(transhead."Item No.", Rec."Item No.");
        if transhead.FindFirst() then begin
            Rec.Validate("Location Code", transhead."Transfer-from Code");
            Rec."Entry Type" := Rec."Entry Type"::Transfer;

        END;
        IJL.Reset();
        IJL.SetRange("Document No.", Rec."Document No.");
        if IJL.FindFirst() then begin
            Rec."Location Code" := IJL."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::"Item Journal Line";
        end;
        SaleLine.Reset();
        SaleLine.SetRange("Document No.", Rec."Document No.");
        SaleLine.SetRange("No.", Rec."Item No.");
        if SaleLine.FindFirst() then begin
            Rec."Location Code" := SaleLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Sales;
        end;
        PurLineLine.Reset();
        PurLineLine.SetRange("Document No.", Rec."Document No.");
        PurLineLine.SetRange("No.", Rec."Item No.");
        if PurLineLine.FindFirst() then begin
            Rec."Location Code" := PurLineLine."Location Code";
            Rec."Entry Type" := Rec."Entry Type"::Purchase;
        end;
    end;


}
