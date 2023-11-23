report 50020 "Opening Stock Register"
{
    UsageCategory = Administration;
    Caption = 'Opening Stock Register';
    ApplicationArea = all;
    // ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\OpeningStockRegister.rdl';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Entry Type" = filter("Positive Adjmt."));
            RequestFilterFields = "Item No.", "Location Code", Brand;
            column(sno; sno) { }
            column(OpenAmt; OpenAmt) { }
            column(OpenQty; OpenQty) { }
            column(Brand; Brand) { }
            column(Posting_Date; format("Posting Date")) { }
            column(Document_No_; "Document No.") { }

            column(RecItemdesc; RecItem.Description) { }
            column(RecItemdesc2; RecItem."Description 2") { }
            column(Location_Code; "Location Code") { }
            column(Quantity; Quantity) { }
            column(RecItem; RecItem."Unit Cost") { }

            column(startdate; format(startdate)) { }
            column(Enddate; format(Enddate)) { }
            column(compinfo; compinfo.Name) { }
            trigger OnAfterGetRecord()
            var
            Begin
                Clear(OpenQty);
                Clear(OpenAmt);
                sno += 1;

                ILE.Reset();
                ILE.SetRange(ILE."Item No.", "Item No.");
                ILE.SetRange(ILE."Posting Date", 0D, Enddate - 1);
                if ILE.FindSet() then begin
                    ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                    ILE.CalcSums(ILE.Quantity);

                    OpenQty += ILE.Quantity;
                    OpenAmt += ILE."Cost Amount (Expected)" + ILE."Cost Amount (Actual)";
                end;



                ExcelBuffer.NewRow;

                ExcelBuffer.AddColumn(sno, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                RecItem.Reset();
                RecItem.SetRange("No.", "Item Ledger Entry"."Item No.");
                if RecItem.FindFirst() then;

                ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                ExcelBuffer.AddColumn("Posting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Document No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Location Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Quantity, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(RecItem."Unit Cost", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(RecItem."Unit Cost" * Quantity, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

            End;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", startdate, Enddate);
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
        ExcelBuffer.DELETEALL;

        sno := 0;
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
        ExcelBuffer.AddColumn('Opening Stock Register', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('S No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Brand Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Product', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Rate', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Op.Stock Value', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    trigger OnPostReport()
    begin
        /*
        ExcelBuffer.CreateNewBook('Opening Stock Register');
        ExcelBuffer.WriteSheet('Opening Stock Register', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Opening Stock Register', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        */
    end;

    var
        RecItem: Record Item;
        saleperpur: Record "Salesperson/Purchaser";
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
        compinfo: Record "Company Information";
        sno: Integer;
        ile: Record "Item Ledger Entry";
        OpenQty: Decimal;
        OpenAmt: Decimal;
}