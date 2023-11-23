page 50026 "Sada Price List"
{
    ApplicationArea = All;
    Caption = 'Sada Price List';
    PageType = List;
    SourceTable = "Sada price List";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No."; Rec."Account No.")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Adj. Cost"; Rec."Adj. Cost")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Adj. Cost field.';
                }
                field("Adj. Resale"; Rec."Adj. Resale")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Adj. Resale field.';
                }
                field(Currency; Rec.Currency)
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }

                field("Debit Number"; Rec."Debit Number")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Debit Number field.';
                }
                field("Debit Open Qty"; Rec."Debit Open Qty")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Debit Open Qty field.';
                }
                field("Debit Open Qty Percentage"; Rec."Debit Open Qty Percentage")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Debit Open Qty Percentage field.';
                }
                field("Debit Rem. Qty"; Rec."Debit Rem. Qty")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Debit Rem. Qty field.';
                }
                field("Debit Ship Qty"; Rec."Debit Ship Qty")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Debit Ship Qty field.';
                }
                field("End Customer Name"; Rec."End Customer Name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the End Customer Name field.';
                }
                field("Item Expiry Date"; Rec."Item Expiry Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Item Expiry Date field.';
                }
                field("Item Name"; Rec."Item Name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Item Name field.';
                }
                field("Item No. (MPN)"; Rec."Item No. (MPN)")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Item No. (MPN) field.';
                }
                field("Item Start Date"; Rec."Item Start Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Item Start Date field.';
                }
                field(Price; Rec."DBC. (DCPL Price)")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                    Applicationarea = All;
                }
                field("Buying Customer 1"; Rec."Buying Customer 1")
                {
                    Applicationarea = All;
                }
                field("Buying Customer 2"; Rec."Buying Customer 2")
                {
                    Applicationarea = All;
                }
                field("Buying Customer 3"; Rec."Buying Customer 3")
                {
                    Applicationarea = All;
                }
                field("Buying Customer 4"; Rec."Buying Customer 4")
                {
                    Applicationarea = All;
                }
                field("Buying Customer 5"; Rec."Buying Customer 5")
                {
                    Applicationarea = All;
                }
                field("Buying Customer Qty %1"; Rec."Buying Customer Qty %1")
                {
                    Applicationarea = All;
                }
                field("Buying Customer Qty %2"; Rec."Buying Customer Qty %2")
                {
                    Applicationarea = All;
                }
                field("Buying Customer Qty %3"; Rec."Buying Customer Qty %3")
                {
                    Applicationarea = All;
                }
                field("Buying Customer Qty %4"; Rec."Buying Customer Qty %4")
                {
                    Applicationarea = All;
                }
                field("Buying Customer Qty %5"; Rec."Buying Customer Qty %5")
                {
                    Applicationarea = All;
                }

                field("Expire in 15 days"; Rec."Expire in 15 days")
                {
                    Applicationarea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        days: Integer;
        expiredate: Date;
        daysleft: Integer;
        month: Integer;
        year: Integer;
    begin
        if Rec."Item Expiry Date" <> 0D then begin
            Clear(expiredate);
            days := Date2DMY(Rec."Item Expiry Date", 1);
            month := Date2DMY(Rec."Item Expiry Date", 2);
            year := Date2DMY(Rec."Item Expiry Date", 3);
            daysleft := days + 15;
            if daysleft <= 15 then begin
                expiredate := DMY2Date(daysleft, month, year);
                Rec."Expire in 15 days" := expiredate;
            end;
            if daysleft >= 30 then begin
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        days: Integer;
        expiredate: Date;
        daysleft: Integer;
        month: Integer;
        year: Integer;
    begin
        if Rec."Item Expiry Date" <> 0D then begin
            Clear(expiredate);
            days := Date2DMY(Rec."Item Expiry Date", 1);
            month := Date2DMY(Rec."Item Expiry Date", 2);
            year := Date2DMY(Rec."Item Expiry Date", 3);
            daysleft := days + 15;
            if daysleft <= 15 then begin
                expiredate := DMY2Date(daysleft, month, year);
                Rec."Expire in 15 days" := expiredate;
            end;
            if daysleft >= 30 then begin
            end;
        end;
    end;
}
