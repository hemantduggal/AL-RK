/// <summary>
/// Report BillwiseagingReportcopy (ID 50017).
/// </summary>
report 50017 BillwiseagingReportcopy
{
    UsageCategory = Administration;
    Caption = 'Bill Wise Customer Ageing copy';
    ApplicationArea = all;
    //ProcessingOnly = true;
    //DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\BillwiseAging.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Document Type" = const(Invoice), Open = const(true));
            column(thirty; "0-30")
            {

            }
            column(thirtysixty; "31-60")
            {

            }
            column(sixtyninty; "61-90")
            {

            }
            column(nintyonetwenty; "91-120")
            {

            }
            column(onetwentyoneeighty; "121-180")
            {

            }
            column(greateroneeighty; ">180")
            {

            }
            column(startdate; format(startdate)) { }
            column(ToDate; format(ToDate)) { }
            column(Document_No_; "Document No.")
            {

            }
            column(cust; cust.CalcFields("Balance (LCY)"))
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Balance; Balance)
            { }
            column(Posting_Date; format("Posting Date"))
            { }
            column(Document_Type; "Document Type")
            { }
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(CompanyAddress; CompanyInfo.Address)
            {

            }
            column(CompanyAdd2; CompanyInfo."Address 2")
            {

            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {

            }
            column(Due_Date; format("Due Date"))
            {

            }
            column(Original_Amount; "Original Amount")
            {

            }
            column(Remaining_Amount; "Remaining Amount")
            {

            }
            column(Remarks; Remarks)
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(col1Days; col1Days)
            { }
            column(col2Days; col2Days)
            { }
            column(col3Days; col3Days)
            { }
            column(col4Days; col4Days)
            { }
            column(col5Days; col5Days)
            { }
            column(col6Days; col6Days)
            { }
            column(TOtalAMt; TOtalAMt)
            { }
            column(TOtalAMt1; TOtalAMt1)
            { }
            column(calculateage; calculateage) { }
            column(paymentterm; paymentterm) { }
            column(TOtalAMt2; TOtalAMt2) { }

            column(TOtalRemainAMt; TOtalRemainAMt) { }

            column(TOtalAMt3; TOtalAMt3) { }
            column(TOtalAMt4; TOtalAMt4) { }
            column(TOtalAMt5; TOtalAMt5) { }
            column(TOtalAMt6; TOtalAMt6) { }
            column(TOtalAMtcolwise; TOtalAMtcolwise) { }
            trigger OnAfterGetRecord()
            var

            begin
                Clear(calculateage);
                Clear(paymentterm);
                Clear(col1Days);
                Clear(col2Days);
                Clear(col3Days);
                Clear(col4Days);
                Clear(col5Days);
                Clear(col6Days);
                Clear(startdatedays);
                Clear(enddatedays);

                ///////////
                startdatedays := (startdate - "Due Date");
                enddatedays := (ToDate - "Due Date");
                NoOfdays := (ToDate - "Due Date");
                //Message('%1', NoOfdays);
                if "0-30" = true then begin
                    if (NoOfdays >= 0) And (NoOfdays <= 30) then
                        col1Days := "Cust. Ledger Entry"."Remaining Amount";
                end;
                if "31-60" = true then begin
                    if (NoOfdays > 30) And (NoOfdays <= 60) then
                        col2Days := "Cust. Ledger Entry"."Remaining Amount";
                end;
                if "61-90" = true then begin
                    if (NoOfdays > 60) And (NoOfdays <= 90) then
                        col3Days := "Cust. Ledger Entry"."Remaining Amount";
                end;
                if "91-120" = true then begin
                    if (NoOfdays > 90) And (NoOfdays <= 120) then
                        col5Days := "Cust. Ledger Entry"."Remaining Amount";

                end;
                if "121-180" = true then begin
                    if (NoOfdays > 120) And (NoOfdays <= 180) then
                        col5Days := "Cust. Ledger Entry"."Remaining Amount";
                end;
                if ">180" = true then begin
                    if (NoOfdays > 180) then
                        col6Days := "Cust. Ledger Entry"."Remaining Amount";
                end;

                ///////////////////
                if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Invoice then begin
                    sih.Reset();
                    sih.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                    if sih.FindFirst() then
                        paymentterm := sih."Payment Terms Code";
                end else
                    if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::"Credit Memo" then begin
                        sCMH.Reset();
                        sCMH.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                        if sCMH.FindFirst() then
                            paymentterm := sCMH."Payment Terms Code";
                    end else
                        if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::"Credit Memo" then begin
                            RSH.Reset();
                            RSH.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                            if RSH.FindFirst() then
                                paymentterm := RSH."Payment Terms Code";
                        end;



                cust.Reset();
                if cust.get("Customer No.") then begin
                    cust.CalcFields("Balance (LCY)");
                    Balance := cust."Balance (LCY)";
                end;

                calculateage := "Due Date" - ToDate;
                /// /////


                if "Cust. Ledger Entry"."Remaining Amount" <> 0 then begin

                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn("Cust. Ledger Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Cust. Ledger Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    /////////

                    ExcelBuffer.AddColumn(paymentterm, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    //  calculateage := "Due Date" - ToDate;
                    ExcelBuffer.AddColumn(calculateage, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Cust. Ledger Entry"."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Cust. Ledger Entry"."Original Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(col1Days, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(col2Days, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(col3Days, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(col4Days, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(col5Days, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(col6Days, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Cust. Ledger Entry"."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    TOtalAMt += "Original Amount";
                    TOtalRemainAMt += "Remaining Amount";
                    TOtalAMt1 += col1Days;
                    TOtalAMt2 += col2Days;
                    TOtalAMt3 += col3Days;
                    TOtalAMt4 += col4Days;
                    TOtalAMt5 += col5Days;
                    TOtalAMt6 += col6Days;
                    TOtalAMtcolwise += "Cust. Ledger Entry"."Remaining Amount";





                    // Message('%1', Balance);
                end;
            end;

            trigger OnPostDataItem()
            begin
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Totals', FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TOtalAMt, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TOtalRemainAMt, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                ExcelBuffer.AddColumn(TOtalAMt1, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TOtalAMt2, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TOtalAMt3, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TOtalAMt4, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TOtalAMt5, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TOtalAMt6, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TOtalAMtcolwise, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

            end;

            trigger OnPreDataItem()
            var
            begin

                //SetRange("Due Date", 0D, ToDate)
                /*
                                if ToDate = 0D then begin
                                    ToDate := Today;
                                    SetRange("Due Date");
                                end else
                                */
                SetRange("Due Date", startdate, ToDate);
                SetRange("Customer No.", CustomerNo);
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
                field(CustomerNo; CustomerNo)
                {
                    Caption = 'Customer No';
                    TableRelation = Customer."No.";
                    ApplicationArea = All;
                }
                group("Date Filter")
                {
                    Caption = 'Date Filters';
                    field(startdate; startdate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field("0-30"; "0-30")
                    {
                        ApplicationArea = All;
                    }
                    field("31-60"; "31-60")
                    {
                        ApplicationArea = All;
                    }
                    field("61-90"; "61-90")
                    {
                        ApplicationArea = All;
                    }
                    field("91-120"; "91-120")
                    {
                        ApplicationArea = All;
                    }
                    field("121-180"; "121-180")
                    {
                        ApplicationArea = All;
                    }
                    field(">180"; ">180")
                    {
                        ApplicationArea = All;
                    }

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


        ExcelBuffer.NewRow;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo.Name, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo.Address, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo."Address 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bill Wise Customer Aging Report', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ToDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher No', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Credit Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Age', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('( 0 - 30 ) Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('( 31 - 60 ) Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('( 61 - 90 ) Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('( 91 - 120 ) Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('( 121 - 180 ) Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('(>=181) Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("Cust. Ledger Entry"."Customer Name", FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


    end;

    trigger OnPostReport()
    begin
        /*
                ExcelBuffer.CreateNewBook('customer Aging Report');
                ExcelBuffer.WriteSheet('Customer Aging Report', CompanyName, UserId);
                ExcelBuffer.CloseBook();
                ExcelBuffer.SetFriendlyFilename(StrSubstNo('Customer Aging Report', CurrentDateTime, UserId));
                ExcelBuffer.OpenExcel();
        */
    end;

    var
        CustomerNo: Code[20];
        RecCust: Record "Cust. Ledger Entry";
        ExcelBuffer: Record "Excel Buffer";
        ToDate: Date;
        col1Days: Decimal;
        col2Days: Decimal;
        col3Days: Decimal;
        col4Days: Decimal;
        col5Days: Decimal;
        col6Days: Decimal;
        NoOfdays: Integer;
        CompanyInfo: Record "Company Information";
        TOtalAMt: Decimal;
        TOtalRemainAMt: Decimal;
        TOtalAMt1: Decimal;
        TOtalAMt2: Decimal;
        TOtalAMt3: Decimal;
        TOtalAMt4: Decimal;
        TOtalAMt5: Decimal;
        TOtalAMt6: Decimal;
        TOtalAMtcolwise: Decimal;
        cust: Record Customer;
        Balance: Decimal;
        sih: Record "Sales Invoice Header";
        sCMH: Record "Sales Cr.Memo Header";
        paymentterm: Code[20];
        RSH: Record "Return Shipment Header";
        startdate: Date;
        calculateage: Integer;
        startdatedays: Integer;
        enddatedays: Integer;
        "0-30": boolean;
        "31-60": boolean;
        "61-90": boolean;
        "91-120": Boolean;
        "121-180": boolean;
        ">180": boolean;
        RemainAmt: Decimal;
}