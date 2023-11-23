pageextension 50020 SaleQuoteExt extends "Sales Quote"
{
    layout
    {
        modify("Location Code")
        {
            Caption = 'Location';
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including';
        }
        modify("Quote Valid Until Date")
        {
            Visible = false;
        }
        addafter("Location Code")
        {
            field("Quote Validity"; Rec."Quote Validity")
            {
                Caption = 'Quote Validity in Days';
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("RFQ Doc No."; Rec."RFQ Doc No.")
            {
                ApplicationArea = All;
            }
            field("Cancelation reason"; Rec."Cancelation reason")
            {
                Applicationarea = All;
            }
            field(Zone; Rec.Zone)
            {
                ApplicationArea = All;
            }

        }
        moveafter("Order Date"; "Salesperson Code")
    }
    actions
    {

        modify(Release)
        {
            trigger OnBeforeAction()
            var
                purchLine: Record "Sales Line";
            begin

                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::Quote);
                if purchLine.FindSet() then begin
                    repeat
                        //   purchLine.TestField("Unit Cost");
                        purchLine.TestField("Unit Price");
                    until purchLine.Next() = 0;
                end;
            end;
        }

        addafter(MakeOrder)
        {
            action(PurchOrderReport)
            {
                Caption = 'Sales Quote Report';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ph: Record "Sales Header";
                begin
                    ph.Reset();
                    ph.SetRange("No.", Rec."No.");
                    if ph.FindFirst() then
                        Report.Run(50023, true, false, ph);
                end;


            }
        }
        modify(MakeOrder)
        {
            trigger OnBeforeAction()
            var
                SL: Record "Sales Line";
                SL1: Record "Sales Line";
            begin
                SL.Reset();
                if Rec."Document Type" = Rec."Document Type"::Quote then begin
                    SL.SetRange("Document No.", Rec."No.");
                    if SL.FindFirst() then begin
                        repeat
                            SL.TestField("Unit Price");

                        until SL.Next() = 0;
                    end;
                end;
                SL1.Reset();
                if Rec."Document Type" = Rec."Document Type"::Quote then begin
                    SL1.SetRange("Document No.", Rec."No.");
                    SL1.SetRange(Partially, true);
                    if not SL1.FindSet() then begin
                        Error('You have not select the item line for make to order');
                    end;
                end;
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        usersetup: Record "User Setup";
    begin
        usersetup.Get(UserId);
        if usersetup."HO User" <> true then begin
            usersetup.SetFilter("Sale Quote", '%1', usersetup."Sale Quote"::View);
            if usersetup.FindFirst() then
                Error('You have not permission to delete record');
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        usersetup: Record "User Setup";
    begin
        usersetup.Get(UserId);
        if usersetup."HO User" <> true then begin
            usersetup.SetFilter("Sale Quote", '%1', usersetup."Sale Quote"::View);
            if usersetup.FindFirst() then
                Error('You have not permission to delete record');

        end;
    end;

    trigger OnModifyRecord(): Boolean
    var
        usersetup: Record "User Setup";
    begin
        usersetup.Get(UserId);
        if usersetup."HO User" <> true then begin
            usersetup.SetFilter("Sale Quote", '%1', usersetup."Sale Quote"::View);
            if usersetup.FindFirst() then
                Error('You have not permission to delete record');
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        usersetup: Record "User Setup";
    begin
        usersetup.Get(UserId);
        if usersetup."HO User" <> true then begin
            usersetup.SetFilter("Sale Quote", '%1', usersetup."Sale Quote"::View);
            if usersetup.FindFirst() then
                Error('You have not permission to delete record');
        end;
    end;

}