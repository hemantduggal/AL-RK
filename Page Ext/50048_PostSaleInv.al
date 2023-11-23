pageextension 50048 postsalinv extends "Posted Sales Invoice"
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
            action("Tax Invoice Report")
            {
                Caption = 'Tax Invoice Report';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ph: Record "Sales Invoice Header";
                begin
                    ph.Reset();
                    ph.SetRange("No.", Rec."No.");
                    if ph.FindFirst() then
                        Report.Run(50006, true, false, ph);
                end;


            }
        }
    }
}