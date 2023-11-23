report 50033 "Sale Return Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //ProcessingOnly = true;
    //  DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\saleReturn.rdl';
    dataset
    {
        dataitem("Return Shipment Header"; "Return Shipment Header")
        {
            column(No_; "No.") { }
            dataitem("Return Receipt Header"; "Return Receipt Header")
            {

            }
        }
    }
}