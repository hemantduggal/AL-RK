page 50011 "Barcode Ledger Entries"
{
    SourceTable = "Barcode Ledger Entry";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    //  SourceTableView = sorting
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Applicationarea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Applicationarea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Applicationarea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Applicationarea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Applicationarea = All;
                }
                field("item No."; Rec."item No.")
                {
                    Applicationarea = All;
                }
                field(Qty; Rec.Qty)
                {
                    Applicationarea = All;
                }
                field("Item Line No."; Rec."Item Line No.")
                {
                    Applicationarea = All;
                }
                field("ILE No."; Rec."ILE No.")
                {
                    Applicationarea = All;
                }
                field("Master Barcode No."; Rec."Master Barcode No.")
                {
                    Applicationarea = All;
                }
                field("Carton Barcode No."; Rec."Carton Barcode No.")
                {
                    Applicationarea = All;
                }
                field("Product Barcode No."; Rec."Product Barcode No.")
                {
                    Applicationarea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        DocTypeOrder: Text[50];
        DocNoOrder: Code[20];
        ReqLine: Record 50001;
        PL: Record 39;
        PL1: Record 39;
        LineNo: Integer;



}

