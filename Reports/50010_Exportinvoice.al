report 50010 Export_Invoice_Report
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Exportinvoice.rdl';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Bill_to_Name; "Bill-to Name")
            { }
            column(Bill_to_Address; "Bill-to Address")
            { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            { }
            column(Sell_to_E_Mail; "Sell-to E-Mail")
            { }
            column(Order_No_; "Order No.")
            { }
            column(Tax_Area_Code; "Tax Area Code")
            { }
            column(Bal__Account_No_; "Bal. Account No.") { }
            column(Posting_Date; "Posting Date") { }
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(CompanyInfo; CompanyInfo.Address) { }
            column(CompanyInfoBankname; CompanyInfo."Bank Name") { }
            column(CompanyInfoAcc; CompanyInfo."Bank Account No.") { }
            column(CompanyInfoIFSC; CompanyInfo."Bank Branch No.") { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");

                column(Document_No_; "Document No.")
                { }
                column(Description; Description)
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_Cost; "Unit Cost")
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(Amount; Amount)
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(Marks; Marks)
                { }
                column(TotalAmount; TotalAmount)
                { }
                column(AmountInWords; AmountInWords)
                { }
                column(TotalAmountINR; TotalAmountINR) { }
                column(codeINR; codeINR) { }


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    SIL: Record "Sales Invoice Line";

                begin
                    Marks += 1;
                    SIL.Reset();
                    SIL.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    IF SIL.FindSet() then;
                    IF "Line No." = SIL."Line No." then begin
                        TotalAmount += SIL.Amount;
                        RepCheck.InitTextVariable();
                        RepCheck.FormatNoText(NoText, TotalAmount, '');
                        AmountInWords := NoText[1];
                        if currency.FindFirst() then;
                        // TotalAmountINR := TotalAmount * currency.ExchangeRate(Today, 'INR');
                        //codeINR := currency.ExchangeRate(Today, 'INR')


                    end;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
    begin
        CompanyInfo.GET;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        myInt: Integer;
        Marks: Integer;
        RepCheck: Report CheckPrint;
        NoText: array[2] of Text;
        AmountInWords: Text;
        SIL: Record "Sales Invoice Line";
        TotalAmount: Decimal;
        currency: Record "Currency Exchange Rate";
        TotalAmountINR: Decimal;
        codeINR: Decimal;
        CompanyInfo: Record "Company Information";
}