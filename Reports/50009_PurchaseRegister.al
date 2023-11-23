report 50009 "Purchase Register"
{
    UsageCategory = Administration;
    Caption = 'Purchase Register Report';
    ApplicationArea = all;
    //ProcessingOnly = true;
    // DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\purchaseRegister.rdl';
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.", "Posting Date";
            DataItemTableView = sorting("Posting Date");
            column(No_; "No.")
            {

            }
            column(startdate; format(startdate)) { }
            column(Enddate; format(Enddate)) { }
            column(Your_Reference; "Your Reference") { }
            column(Invoice_Disc__Code; "Invoice Disc. Code")
            {

            }
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
            column(Posting_Date; format("Posting Date")) { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(No1_; "No.")
                {

                }

                column(RecItemDesc; RecItem.Description) { }
                column(RecItembrand; RecItem.Brand) { }
                column(Quantity; Quantity) { }
                column(Location_Code; "Location Code") { }
                column(Unit_Cost; "Unit Cost") { }
                column(Amount; Amount) { }
                column(POP; POP) { }
                trigger OnAfterGetRecord()
                var
                Begin
                    IGST_perc := 0;
                    IGST_Amt := 0;
                    CGST_perc := 0;
                    CGST_Amt := 0;
                    SGST_perc := 0;
                    SGST_Amt := 0;
                    TotalGST := 0;
                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Purch. Inv. Line"."Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Purch. Inv. Line"."Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "Purch. Inv. Line"."No.");
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

                    totalgst := CGST_Amt + SGST_Amt + IGST_Amt;


                    RecItem.Reset();
                    if RecItem.Get("Purch. Inv. Line"."No.") then;

                    if ExportToExcel = true then begin
                        ExcelBuffer.NewRow;
                        ExcelBuffer.AddColumn("Purch. Inv. Header"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn("Purch. Inv. Header"."Buy-from Vendor Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        RecItem.Reset();
                        if RecItem.Get("Purch. Inv. Line"."No.") then;
                        ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        // else
                        //   ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                        ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purch. Inv. Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Purch. Inv. Line"."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Purch. Inv. Line"."Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Purch. Inv. Line".Amount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Purch. Inv. Line".POP, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Purch. Inv. Line".POP * "Purch. Inv. Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('1', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    end;
                End;
            }
            trigger OnPreDataItem()
            begin
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
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('Purchase Book Register Group', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.NewRow;

                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('DATE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('VENDOR NAME', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('PRODUCT', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('BRAND NAME', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('QUANTITY', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('LOCATION', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('INVOICE PRICE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('INVOICE VALUE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('NET POP', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('POP VALUE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('YOUR REF.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('CTN', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('SHIPMENT', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

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
            ExcelBuffer.CreateNewBook('Purchase Register');
            ExcelBuffer.WriteSheet('Purchase Register Sheet', CompanyName, UserId);
            ExcelBuffer.CloseBook();
            ExcelBuffer.SetFriendlyFilename(StrSubstNo('Purchase Register', CurrentDateTime, UserId));
            ExcelBuffer.OpenExcel();
        end;
        */
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record "Customer";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGST_perc: Decimal;
        IGST_Amt: Decimal;
        CGST_perc: Decimal;
        CGST_Amt: Decimal;
        SGST_perc: Decimal;
        SGST_Amt: Decimal;
        TotalGST: Decimal;
        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;
        RecItem: Record Item;
        ExportToExcel: Boolean;

}