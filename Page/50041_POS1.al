page 50041 POS1
{
    ApplicationArea = All;
    Caption = 'POS1';
    PageType = List;
    SourceTable = POS1;
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
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                    trigger OnValidate()
                    var
                        ILE_REC: Record "Item Ledger Entry";
                        OpeningStock: Decimal;
                    begin
                        Clear(OpeningStock);
                        ILE_REC.Reset();
                        ILE_REC.SetFilter("Posting Date", '%1..%2', 0D, ToDate - 1);
                        ILE_REC.SetRange("Item No.", Rec.Part);
                        if ILE_REC.FindSet() then begin
                            repeat
                                OpeningStock += ILE_REC."Remaining Quantity";
                            Until ILE_REC.Next() = 0;
                        end;
                        Rec."Opening STK" := OpeningStock;
                    end;
                }
                field("Part"; Rec."Part")
                {
                    ToolTip = 'Specifies the value of the Part field.';
                    ApplicationArea = All;
                }
                field("O. Value"; Rec."O. Value")
                {
                    ToolTip = 'Specifies the value of the Part field.';
                    ApplicationArea = All;
                }
                field("sales Qty"; Rec."sales Qty")
                {
                    ToolTip = 'Specifies the value of the sales Qty field.';
                    ApplicationArea = All;

                }
                field(POP; Rec.POP)
                {
                    ToolTip = 'Specifies the value of the POP field.';
                    ApplicationArea = All;
                }
                field(DCPL; Rec.DCPL)
                {
                    ToolTip = 'Specifies the value of the DCPL field.';
                    ApplicationArea = All;
                }
                field(POS; Rec.POS)
                {
                    ToolTip = 'Specifies the value of the POS field.';
                    ApplicationArea = All;
                }
                field("Closing STK"; Rec."Closing STK")
                {
                    ToolTip = 'Specifies the value of the Closing STK field.';
                    ApplicationArea = All;
                    Editable = false;
                }


                field("C. Value @ DCPL"; Rec."C. Value @ DCPL")
                {
                    ToolTip = 'Specifies the value of the C. Value @ DCPL field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("C. Value @ POP"; Rec."C. Value @ POP")
                {
                    ToolTip = 'Specifies the value of the C. Value @ POP field.';
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Opening STK"; Rec."Opening STK")
                {
                    ToolTip = 'Specifies the value of the Opening STK field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Purchase Qty"; Rec."Purchase Qty")
                {
                    ToolTip = 'Specifies the value of the Purchase Qty field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Reported"; Rec."Total Reported")
                {
                    ToolTip = 'Specifies the value of the Total Reported field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("purchase value"; Rec."purchase value")
                {
                    ToolTip = 'Specifies the value of the purchase value field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("sales value"; Rec."sales value")
                {
                    ToolTip = 'Specifies the value of the sales value field.';

                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
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
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        if ToDate = 0D then
                            Error('Please Enter the date');
                        Clear(OpeningStockPurchase);
                        Clear(OpeningStock);
                        ILE_REC.Reset();
                        ILE_REC.SetFilter("Posting Date", '%1..%2', 0D, ToDate - 1);
                        ILE_REC.SetRange("Item No.", Rec.Part);
                        if ILE_REC.FindSet() then begin
                            repeat
                                OpeningStock += ILE_REC."Remaining Quantity";
                            Until ILE_REC.Next() = 0;
                        end;

                        ILE_REC.Reset();
                        ILE_REC.SetFilter("Posting Date", '%1..%2', 0D, ToDate);
                        ILE_REC.SetRange("Entry Type", ILE_REC."Entry Type"::Purchase);
                        ILE_REC.SetRange("Item No.", Rec.Part);
                        if ILE_REC.FindSet() then begin
                            repeat
                                OpeningStockPurchase += ILE_REC."Remaining Quantity";
                            Until ILE_REC.Next() = 0;
                        end;
                        Rec."Opening STK" := OpeningStock;
                        Rec."Purchase Qty" := OpeningStockPurchase;

                        Rec."Total Reported" := Rec."Opening STK" + Rec."Purchase Qty";
                        Rec."purchase value" := Rec."Purchase Qty" + Rec.POP;
                        Rec."sales value" := Rec."sales Qty" * Rec.pop;
                        Rec."Closing STK" := Rec."Total Reported" - Rec."sales Qty";
                        Rec."C. Value @ POP" := Rec."Closing STK" * Rec.POP;
                        Rec."C. Value @ DCPL" := Rec."Closing STK" * Rec.DCPL;
                        Rec.Modify();
                    END;
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
                    MoveData(rec."Account No.");
                    rec.Status := rec.Status::Close;
                    Rec.Modify();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec."purchase value" := Rec."Purchase Qty" * Rec.POP;
    end;

    trigger OnOpenPage()
    begin
        Rec."purchase value" := Rec."Purchase Qty" * Rec.POP;
    end;

    var
        ToDate: Date;

    procedure MoveData(AccNo: Code[20])
    var
        POSHIS: Record POS1Historical;
        POSHIS1: Record POS1Historical;
        Pos1: Record POS1;
    begin
        POSHIS1.Reset();
        if POSHIS1.FindLast() then;
        Pos1.Reset();
        Pos1.SetRange("Account No.", AccNo);
        if Pos1.FindFirst() then begin
            POSHIS.Init();
            POSHIS."Entry No" := POSHIS1."Entry No" + 1;
            POSHIS.Insert();
            POSHIS."Account No." := Rec."Account No.";
            POSHIS."Part" := Rec.Part;
            POSHIS."Opening STK" := Rec."Opening STK";
            POSHIS."O. Value" := Rec."O. Value";
            POSHIS."Purchase Qty" := Rec."Purchase Qty";
            POSHIS."purchase value" := Rec."purchase value";
            POSHIS."Total Reported" := Rec."Total Reported";
            POSHIS."sales Qty" := Rec."sales Qty";
            POSHIS."sales value" := Rec."sales value";
            POSHIS."Closing STK" := Rec."Closing STK";
            POSHIS."C. Value @ POP" := Rec."C. Value @ POP";
            POSHIS."C. Value @ DCPL" := Rec."C. Value @ DCPL";
            POSHIS.POP := Rec.POP;
            POSHIS.POS := Rec.POS;
            POSHIS.DCPL := Rec.DCPL;
            POSHIS.Modify();
        end;
    end;

}
