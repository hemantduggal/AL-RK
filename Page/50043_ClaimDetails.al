page 50043 ClaimDetails
{
    ApplicationArea = All;
    Caption = 'ClaimDetails';
    PageType = List;
    SourceTable = Claim_Detail;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            field(ToDate; ToDate)
            {
                Caption = 'To Date';
                Applicationarea = All;
            }
            repeater(General)
            {
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(DCPL; Rec.DCPL)
                {
                    ToolTip = 'Specifies the value of the DCPL field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Debit No."; Rec."Debit No.")
                {
                    ToolTip = 'Specifies the value of the Debit No. field.';
                }
                field(INV; Rec.INV)
                {
                    ToolTip = 'Specifies the value of the INV field.';
                }
                field("P/N"; Rec."P/N")
                {
                    ToolTip = 'Specifies the value of the P/N field.';
                }
                field(POP; Rec.POP)
                {
                    ToolTip = 'Specifies the value of the POP field.';
                }
                field(POS; Rec.POS)
                {
                    ToolTip = 'Specifies the value of the POS field.';
                }
                field("Sales QTY"; Rec."Sales QTY")
                {
                    ToolTip = 'Specifies the value of the Sales QTY field.';
                }
                field("Value Claim"; Rec."Value Claim")
                {
                    ToolTip = 'Specifies the value of the Value Claim field.';
                }
                field("WK Date"; Rec."WK Date")
                {
                    ToolTip = 'Specifies the value of the WK Date field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Update)
            {
                Promoted = true;
                trigger OnAction()
                var
                    ILE_REC: Record "Item Ledger Entry";
                    OpeningStock: Decimal;
                    OpeningStockPurchase: Decimal;
                    pos1: Record POS2_Annexure;
                    sadaprice: Record "Sada price List";
                    recitem: Record Item;
                begin
                    pos1.Reset();
                    pos1.SetFilter(Status, '%1', pos1.Status::Close);
                    if pos1.FindSet() then begin
                        repeat
                            Rec.Init();
                            Rec."P/N" := pos1."Part No.";
                            Rec.Insert();
                            Rec.Date := pos1.Date;
                            Rec."sales Qty" := pos1."sales Qty";
                            Rec.INV := pos1.Invoice;
                            Rec.POS := pos1.POS;
                            Rec.POP := pos1.POP;
                            Rec."Customer Name" := pos1."Customer name";
                            recitem.Reset();
                            recitem.Get(Rec."P/N");
                            Rec.DCPL := recitem."DCPL Price";
                            Rec."Value Claim" := (Rec.DCPL - Rec.POP) * Rec."Sales QTY";
                            Rec.Modify();
                        until pos1.Next() = 0;
                    end;

                end;
            }
            action(Open)
            {
                Promoted = true;
                trigger OnAction()
                begin

                    rec.Status := rec.Status::Open;
                    Rec.Modify();
                end;
            }
            action(Close)
            {
                Promoted = true;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    MoveData(rec."P/N");
                    rec.Status := rec.Status::Close;
                    Rec.Modify();
                end;
            }
        }

    }
    procedure MoveData(AccNo: Code[50])
    var
        POSHIS: Record Claim_Historical_Detail;
        POSHIS1: Record Claim_Historical_Detail;
        Pos1: Record Claim_Detail;
    begin
        POSHIS1.Reset();
        if POSHIS1.FindLast() then;
        Pos1.Reset();
        Pos1.SetRange("P/N", AccNo);
        if Pos1.FindFirst() then begin
            POSHIS.Init();
            POSHIS."Entry No" := POSHIS1."Entry No" + 1;
            POSHIS.Insert();
            POSHIS."P/N" := Pos1."P/N";
            POSHIS."Sales QTY" := Pos1."Sales QTY";
            POSHIS."WK Date" := Pos1."WK Date";
            POSHIS."Debit No." := Pos1."Debit No.";
            POSHIS.Date := Pos1.Date;
            POSHIS.INV := Pos1.INV;
            POSHIS.POS := Pos1.POS;
            POSHIS.POP := Pos1.POP;
            POSHIS."Customer Name" := Pos1."Customer Name";
            POSHIS.DCPL := Pos1.DCPL;
            POSHIS."Value Claim" := Pos1."Value Claim";
            POSHIS.Modify();

        end;
    end;

    var
        Todate: Date;
}

