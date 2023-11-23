pageextension 50045 pscrmemo extends "Posted Sales Credit Memo"
{
    layout
    {
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("VAT Registration No.")
        {
            Visible = false;
        }

    }
    actions
    {
        addafter(Print)
        {
            action("Credit Memo Report")
            {
                Caption = 'Credit Memo Report';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ph: Record "Sales Cr.Memo Header";
                begin
                    ph.Reset();
                    ph.SetRange("No.", Rec."No.");
                    if ph.FindFirst() then
                        Report.Run(50012, true, false, ph);
                end;


            }
        }
    }
}