pageextension 50056 saleshiplist extends "Posted Sales Shipments"
{
    layout
    {

    }
    trigger OnAfterGetRecord()
    var
        UserSetRec: Record "User Setup";
    begin
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
        UserSetRec.Get(UserId);
        if UserSetRec."HO User" = false then begin
            rec.SetRange("Shortcut Dimension 2 Code", UserSetRec.Branch);
            Rec.SetRange(Zone, UserSetRec.Zone);
            Rec.SetRange(Salesperson, UserSetRec.Salesperson);
        end;
    end;
}