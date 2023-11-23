report 50004 "Sales Register"
{
    UsageCategory = Administration;
    Caption = 'Sales Register Report';
    ApplicationArea = all;
    // ProcessingOnly = true;
    // DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SaleRegister.rdl';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Posting Date";

            column(No_; "No.")
            {

            }
            column(startdate; format(startdate))
            { }
            column(Enddate; format(Enddate))
            { }
            column(Posting_Date; format("Posting Date"))
            { }

            column(Invoice_Disc__Code; "Invoice Disc. Code")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(CompName; CompanyInfo.Name)
            {

            }
            column(CompAdd1; CompanyInfo.Address)
            {

            }
            column(CompAdd2; CompanyInfo."Address 2")
            {

            }
            column(CompCity; CompanyInfo.City)
            {

            }
            column(CompPostCode; CompanyInfo."Post Code")
            {

            }
            column(Comppic; CompanyInfo.Picture)
            {

            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {

            }
            column(CompCountry; CompanyInfo.County)
            {

            }
            column(CompCountryCode; CompanyInfo."Country/Region Code")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(CustName; Cust.Name)
            {

            }
            column(saleperpurname; saleperpur.Name)
            { }
            column(Order_No; "Order No.")
            { }
            column(Customer_PO_No_; "Customer PO No.")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = const(Item));

                column(No1_; "No.")
                {

                }
                column(Remarks; Remarks) { }
                column(IGST_Amt; IGST_Amt1) { }
                column(IGST_perc; IGST_perc) { }
                column(CGST_Amt; CGST_Amt1) { }
                column(CGST_perc; CGST_perc) { }
                column(SGST_Amt; SGST_Amt1) { }
                column(SGST_perc; SGST_perc) { }
                column(profit; profit) { }
                column(profitper1; profitper1) { }
                column(TotalGST; TotalGST) { }
                column(ItemDesc; RecItem.Description) { }
                column(Brand; Brand) { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(RecItemBuyingRateUSD; RecItem."Buying Rate (USD)") { }
                column(RecItemBuyingRateINR; RecItem."Buying Rate (INR)") { }
                column(currencycode; currencycode) { }
                column(Location_Code; "Location Code") { }

                trigger OnAfterGetRecord()
                var
                Begin
                    Clear(profitper1);
                    Clear(currencycode);
                    profit := 0;
                    profitper := 0;
                    IGST_perc := 0;
                    IGST_Amt := 0;
                    CGST_perc := 0;
                    CGST_Amt := 0;
                    SGST_perc := 0;
                    SGST_Amt := 0;
                    TotalGST := 0;
                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "Sales Invoice Line"."No.");
                    IF DetailedGSTLedgerEntry.FINDSET THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IGST_perc := DetailedGSTLedgerEntry."GST %";
                                IGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SGST_perc := DetailedGSTLedgerEntry."GST %";
                                SGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CGST_perc := DetailedGSTLedgerEntry."GST %";
                                CGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                    CGST_Amt1 := CGST_Amt;
                    SGST_Amt1 := SGST_Amt;
                    IGST_Amt1 := IGST_Amt;
                    totalgst := CGST_Amt + SGST_Amt + IGST_Amt;


                    saleperpur.Reset();
                    saleperpur.SetRange(code, "Sales Invoice Header"."Salesperson Code");
                    if saleperpur.FindFirst() then;

                    RecItem.Reset();
                    if RecItem.Get("Sales Invoice Line"."No.") then;

                    if "Sales Invoice Header"."Currency Code" = '' then
                        currencycode := 'INR'
                    else
                        currencycode := "Sales Invoice Header"."Currency Code";
                    profit := "Sales Invoice Line"."Unit Price" - RecItem."Buying Rate (INR)";
                    if RecItem."Buying Rate (INR)" > 0 then
                        profitper := (profit / RecItem."Buying Rate (INR)") * 100;
                    profitper1 := Round(profitper, 0.01, '>');

                    if ExportToExcel = true then begin
                        ExcelBuffer.NewRow;
                        ExcelBuffer.AddColumn("Sales Invoice Header"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn("Sales Invoice Header"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(saleperpur.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Sales Invoice Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Sales Invoice Line".brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Sales Invoice Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Unit Price", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(CGST_Amt, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(SGST_Amt, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(IGST_Amt, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(TotalGST, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price") + TotalGST, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(RecItem."Buying Rate (USD)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(RecItem."Buying Rate (INR)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);

                        if "Sales Invoice Header"."Currency Code" = '' then
                            ExcelBuffer.AddColumn('INR', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text)
                        else
                            ExcelBuffer.AddColumn("Sales Invoice Header"."Currency Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        profit := "Sales Invoice Line"."Unit Price" - RecItem."Buying Rate (INR)";
                        if RecItem."Buying Rate (INR)" > 0 then
                            profitper := (profit / RecItem."Buying Rate (INR)") * 100;
                        profitper1 := Round(profitper, 0.01, '>');
                        ExcelBuffer.AddColumn(Round(profitper, 0.01, '>'), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);


                        ExcelBuffer.AddColumn("Sales Invoice Line".Remarks, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


                        ///calculate total
                        totqty += "Sales Invoice Line".Quantity;
                        totrate += "Sales Invoice Line"."Unit Price";
                        totgross += "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                        totcgst += CGST_Amt;
                        totigst += IGST_Amt;
                        totsgst += SGST_Amt;
                        totgstamt += TotalGST;
                        totnet := totgross + totgstamt;
                        totprof += Round(profitper, 0.01, '>');
                    end;
                End;

            }
            trigger OnPreDataItem()
            begin
                Clear(totqty);
                Clear(totrate);
                Clear(totgross);
                Clear(TotalGST);
                Clear(totigst);
                Clear(totsgst);
                Clear(totcgst);
                Clear(totnet);
                Clear(totprof);
                if ExportToExcel = true then begin
                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CompanyInfo.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('Sales Book SALES IN INR', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.NewRow;

                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('DATE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('INVOICE No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('EXECUTIVE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('CUSTOMER NAME', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('PART No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('BRAND', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('QUANTITY', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('RATE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('GROSS', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('CGST', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('SGST', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('IGST', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('TOTAL GST', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('NET', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('USD PRICE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('INR PRICE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('CURRENCY CODE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('LOCATION', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('PROFIT %', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                end;
            end;

            trigger OnPostDataItem()
            begin
                if ExportToExcel = true then begin
                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('Total', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(totqty, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totrate, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totgross, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totcgst, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totsgst, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totigst, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totgstamt, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totnet, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(totprof, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                end;
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
                field(ExportToExcel; ExportToExcel)
                {

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
        ExcelBuffer.DELETEALL
    end;

    trigger OnPostReport()
    begin
        /*
        if ExportToExcel = true then begin
            ExcelBuffer.CreateNewBook('Sales Register');
            ExcelBuffer.WriteSheet('Sales Register Sheet', CompanyName, UserId);
            ExcelBuffer.CloseBook();
            ExcelBuffer.SetFriendlyFilename(StrSubstNo('Sales Register', CurrentDateTime, UserId));
            ExcelBuffer.OpenExcel();
        end;
        */
    end;

    var
        profitper1: Decimal;
        currencycode: Code[10];
        saleperpur: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        Cust: Record "Customer";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGST_perc: Decimal;

        CGST_perc: Decimal;
        IGST_Amt1: Decimal;
        CGST_Amt1: Decimal;
        SGST_Amt1: Decimal;
        SGST_perc: Decimal;
        IGST_Amt: Decimal;
        CGST_Amt: Decimal;
        SGST_Amt: Decimal;
        TotalGST: Decimal;
        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;
        RecItem: Record Item;
        compinfo: Record "Company Information";
        profit: Decimal;
        profitper: Decimal;
        totqty: Decimal;
        totrate: Decimal;
        totgross: Decimal;
        totcgst: Decimal;
        totigst: Decimal;
        totsgst: Decimal;
        totgstamt: Decimal;
        totnet: Decimal;
        totprof: Decimal;
        ExportToExcel: Boolean;
}