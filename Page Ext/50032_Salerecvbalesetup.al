pageextension 50032 "sale&recvbalesetup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Order Nos.")
        {
            field("FAE Opportunity document No."; Rec."FAE Opportunity document No.")
            {
                ApplicationArea = All;
                TableRelation = "No. Series".Code;
            }
        }
    }
}
