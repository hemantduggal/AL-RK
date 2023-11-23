page 50042 POS2
{
    ApplicationArea = All;
    Caption = 'POS2';
    PageType = List;
    SourceTable = POS2_Annexure;
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
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Invoice; Rec.Invoice)
                {
                    ToolTip = 'Specifies the value of the Invoice field.';
                }
                field(POS; Rec.POS)
                {
                    ToolTip = 'Specifies the value of the POS field.';
                }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field(Quarter; Rec.Quarter)
                {
                    ToolTip = 'Specifies the value of the Quarter field.';
                }
                field(POP; Rec.POP)
                {
                    ToolTip = 'Specifies the value of the POP field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Account No field.';

                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer name field.';
                    Editable = false;
                }


                field("Part No."; Rec."Part No.")
                {
                    ToolTip = 'Specifies the value of the Part No. field.';
                }

                field("Value(pop)"; Rec."Value(pop)")
                {
                    ToolTip = 'Specifies the value of the Value(pop) field.';
                }
                field("sales Qty"; Rec."sales Qty")
                {
                    ToolTip = 'Specifies the value of the sales Qty field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the sales Qty field.';
                    Editable = false;
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
                    pos1: Record POS1;
                    sadaprice: Record "Sada price List";
                    Pos2: Record POS2_Annexure;
                begin

                    pos1.Reset();
                    pos1.SetFilter(Status, '%1', pos1.Status::Close);
                    // Pos1.SetFilter(Inserted, '%1', false);
                    if pos1.FindFirst() then begin
                        repeat
                            Pos2.SetRange("Account No", pos1."Account No.");
                            if Pos2.FindFirst() then begin
                                Pos2."Part No." := pos1.Part;
                                Pos2."sales Qty" := pos1."sales Qty";
                                Pos2.POP := pos1.POP;
                                Pos2."Value(pop)" := Rec.POP * Rec."sales Qty";
                                Pos2.Modify();
                            end else begin
                                Pos2.Init();
                                Pos2."Account No" := pos1."Account No.";
                                // Pos2.Insert();
                                Pos2."Part No." := pos1.Part;
                                Pos2."sales Qty" := pos1."sales Qty";
                                Pos2.POP := pos1.POP;
                                Pos2."Value(pop)" := Pos2.POP * Pos2."sales Qty";
                                Pos2.Insert();
                            end;
                        until pos1.Next() = 0;
                        pos1.Inserted := true;
                        pos1.Modify();
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
                    MoveData(rec."Account No");
                    rec.Status := rec.Status::Close;

                    Rec.Modify();
                end;
            }
        }

    }
    procedure MoveData(AccNo: Code[20])
    var
        POSHIS: Record "POS2_Historical data";
        POSHIS1: Record "POS2_Historical data";
        Pos1: Record POS2_Annexure;
    begin
        POSHIS1.Reset();
        if POSHIS1.FindLast() then;
        Pos1.Reset();
        Pos1.SetRange("Account No", AccNo);
        if Pos1.FindFirst() then begin
            POSHIS.Init();
            POSHIS."Entry No" := POSHIS1."Entry No" + 1;
            POSHIS.Insert();
            POSHIS."Account No" := Pos1."Account No";
            POSHIS."Part No." := Pos1."Part No.";
            POSHIS.Date := Pos1.Date;
            POSHIS.Invoice := Pos1.Invoice;
            POSHIS.POS := Pos1.POS;
            POSHIS."sales Qty" := Pos1."sales Qty";
            POSHIS.POP := Pos1.POP;
            POSHIS."Customer name" := Pos1."Customer name";
            POSHIS."Value(pop)" := Pos1."Value(pop)";
            POSHIS.Month := Pos1.Month;
            POSHIS.Quarter := Pos1.Quarter;
            POSHIS.Modify();

        end;
    end;

    var
        Todate: Date;
}