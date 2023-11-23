report 50019 "Opening Balance Register"
{
    UsageCategory = Administration;
    Caption = 'Opening Balance Register';
    ApplicationArea = all;
    // ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\OpeningBalanceRegister.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            // RequestFilterFields = "Salesperson Code";
            column(compinfo; compinfo.Name) { }
            column(startdate; Format(startdate)) { }
            column(Enddate; Format(Enddate)) { }
            column(sno; sno) { }
            column(Posting_Date; format("Posting Date")) { }
            column(Document_No_; "Document No.") { }
            column(Customer_Name; "Customer Name") { }
            column(OpeningBalance; OpeningBalance) { }
            column(Creditamt; Creditamt) { }
            column(debitamt; debitamt) { }
            column(Narration; Narration) { }
            column(Remarks; Remarks) { }
            column(salepersonname; salepersonname)
            {

            }

            trigger OnAfterGetRecord()
            var
            Begin
                Clear(OpeningBalance);
                sno += 1;
                RecCLE.SetFilter("Posting Date", '%1..%2', startdate, Enddate - 1);
                RecCLE.SetRange("Customer No.", "Cust. Ledger Entry"."Customer No.");
                if RecCLE.FindSet() then begin
                    repeat
                        RecCLE.CalcFields(Amount);
                        OpeningBalance += RecCLE.Amount;
                    until RecCLE.Next() = 0;
                end;

                RecCust.Reset();
                RecCust.SetRange("No.", "Cust. Ledger Entry"."Customer No.");
                if RecCust.FindFirst() then;
                saleperson.Reset();
                saleperson.SetRange(Code, "Cust. Ledger Entry"."Salesperson Code");
                if saleperson.FindFirst() then;

                if Salepersn <> '' then
                    salepersonname := saleperson.Name;

                if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment then
                    Creditamt := OpeningBalance
                else
                    debitamt := OpeningBalance;


                ExcelBuffer.NewRow;
                if Salepersn <> '' then begin
                    if bool = false then begin
                        ExcelBuffer.AddColumn('SalesPerson', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(saleperson.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        bool := true;
                    end;
                end;
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn(sno, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Posting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Document No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Customer Name", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment then begin
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(OpeningBalance, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                end else begin
                    ExcelBuffer.AddColumn(OpeningBalance, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                end;
                ExcelBuffer.AddColumn(Narration, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Remarks, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

            End;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", startdate, Enddate);
                if Salepersn <> '' then
                    "Cust. Ledger Entry".SetRange("Salesperson Code", Salepersn);
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
                field(Salepersn; Salepersn)
                {
                    Caption = 'SalesPerson Code';
                    ApplicationArea = all;
                    TableRelation = "Salesperson/Purchaser".Code;
                }
            }
        }
    }

    trigger OnPreReport()
    var
    begin
        bool := false;
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
        ExcelBuffer.AddColumn('Opening Balances Report', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('S No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('NAME', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Debit Amt.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Credit Amt.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Narration', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);





    end;

    trigger OnPostReport()
    begin
        /*
        ExcelBuffer.CreateNewBook('Opening Balance Register');
        ExcelBuffer.WriteSheet('Opening Balance Register', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Opening Balance Register', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        */
    end;



    var
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
        RecItem: Record Item;
        compinfo: Record "Company Information";
        sno: Integer;
        RecCLE: Record "Cust. Ledger Entry";
        OpeningBalance: Decimal;
        RecCust: Record Customer;
        saleperson: Record "Salesperson/Purchaser";
        bool: Boolean;
        Salepersn: Code[20];
        Creditamt: Decimal;
        debitamt: Decimal;
        salepersonname: Text[50];
}