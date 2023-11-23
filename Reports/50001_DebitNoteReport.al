report 50001 "Debit Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout/DebitNote.rdl';
    //PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
        }
    }
}