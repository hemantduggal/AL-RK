pageextension 50046 ppurcrmemo extends "Posted Purchase Credit Memo"
{
    layout
    {
        modify("VAT Reporting Date")
        {
            Visible = false;
        }

    }
    actions
    {
        addafter("&Print")
        {
            action("Debit Note Report")
            {
                Caption = 'Debit Note Report';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ph: Record "Purch. Cr. Memo Hdr.";
                begin
                    ph.Reset();
                    ph.SetRange("No.", Rec."No.");
                    if ph.FindFirst() then
                        Report.Run(50002, true, false, ph);
                end;


            }
        }
    }
}