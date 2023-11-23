pageextension 50037 saleorderlist extends "Sales Order List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Short Close"; Rec."Short Close")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        UserSetRec: Record "User Setup";
    begin
        Rec.SetFilter("Short Close", '%1', false);
        UserSetRec.Get(UserId);
        if UserSetRec."HO User" = false then begin
            rec.SetRange("Shortcut Dimension 2 Code", UserSetRec.Branch);
            Rec.SetRange(Zone, UserSetRec.Zone);
            Rec.SetRange(Salesperson, UserSetRec.Salesperson);
        end;
    end;

    trigger OnOpenPage()
    var
        UserSetRec: Record "User Setup";
    begin
        Rec.SetFilter("Short Close", '%1', false);
        UserSetRec.Get(UserId);
        if UserSetRec."HO User" = false then begin
            rec.SetRange("Shortcut Dimension 2 Code", UserSetRec.Branch);
            Rec.SetRange(Zone, UserSetRec.Zone);
            Rec.SetRange(Salesperson, UserSetRec.Salesperson);
        end;
    end;
}