report 50028 "Stock Valuation New Report"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    // ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\StockValuation.rdl';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(CompanyInfo; CompanyInfo.Name)
            {

            }
            column(startdate; startdate)
            {

            }
            column(Enddate; Enddate)

            { }
            column(Item_No_; "Item No.")
            { }
            column(Quantity; Quantity)
            { }
            column(Location_Code; "Location Code")
            { }
            column(RecItemdesc; RecItem.Description)
            { }
            column(RecItemusdrate; RecItem."Buying Rate (USD)")
            {

            }
            column(RecItem; RecItem."Buying Rate (INR)")
            { }
            column(RecItemsearchdesc; RecItem."Search Description")
            {

            }
            column(RecItembrand; RecItem.Brand)
            {

            }
            column(RecItemtype; RecItem."Item Category Code")
            {

            }
            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", startdate, Enddate);
            end;

            trigger OnAfterGetRecord()
            begin
                RecItem.Reset();
                RecItem.SetRange("No.", "Item Ledger Entry"."Item No.");
                if RecItem.FindFirst() then;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(startdate; startdate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = all;
                }
                field(Enddate; Enddate)
                {
                    Caption = 'End Date';
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnPreReport()
    var
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        startdate: date;
        Enddate: date;
        sno: Integer;
        Qty: Decimal;
        RecItem: Record Item;
}