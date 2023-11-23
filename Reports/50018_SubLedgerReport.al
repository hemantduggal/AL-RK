report 50018 SubLedgerReport
{
    UsageCategory = Administration;
    Caption = 'Sub Ledger Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SubLedger.rdl';

    dataset
    {
        dataitem("Sub Ledger Temp Table"; "Sub Ledger Temp Table")
        {
            DataItemTableView = sorting("Posting Date");
            column(startdate; format(startdate))
            {

            }
            column(Enddate; format(Enddate))
            {

            }
            column(Custno; Custno)
            {

            }
            column(recCustname; recCust.Name)
            {

            }
            column(CompanyInfoname; CompanyInfo.Name)
            {

            }
            column(Posting_Date; format("Posting Date"))
            { }
            column(Remarks; Remarks)
            {

            }
            column(Document_No; "Document No")
            { }

            column(Product_Name; "Product Name")
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(INR_Rate; "INR Rate")
            {

            }
            column(Debit_Amt; "Debit Amt")
            {

            }
            column(Credit_Amt; "Credit Amt")
            {

            }
            column(prodname; ItemRec.Description)
            {

            }
            column(brandname; ItemRec.Brand)
            {

            }
            column(OpeningBalance; OpeningBalance)
            {

            }
            column(rembal; Abs(rembal))
            {

            }
            column(Account; Account)
            {

            }
            column(salepersonname; salepersonname)
            {

            }
            column(recCustPaymentTerm; recCust."Payment Terms Code")
            {

            }
            column(Salesperson_Name; "Salesperson Name")
            {

            }
            column(Payment_Term; "Payment Term")
            {

            }
            trigger OnAfterGetRecord()
            var
            begin
                Clear(salepersonname);

                Clear(OpeningBalance);
                RecCLE.Reset();
                RecCLE.SetFilter("Posting Date", '%1..%2', startdate, Enddate - 1);
                RecCLE.SetRange("Customer No.", Custno);
                if RecCLE.FindFirst() then begin
                    RecCLE.CalcFields(Amount);
                    OpeningBalance := RecCLE.Amount;
                    saleper.Reset();
                    saleper.SetRange(Code, RecCLE."Salesperson Code");
                    if saleper.FindFirst() then
                        salepersonname := saleper.Name;
                    recCust.Reset();
                    if recCust.get(Custno) then;

                end;


                ItemRec.Reset();
                ItemRec.SetRange("No.", "Sub Ledger Temp Table"."Product Name");
                if ItemRec.FindFirst() then;

                if bool = false then
                    rembal := (rembal + "Debit Amt") - abs("Credit Amt") + OpeningBalance
                else
                    rembal := (rembal + "Debit Amt") - abs("Credit Amt");
                bool := true;


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
                field(Custno; Custno)
                {
                    Caption = 'Customer No';
                    ApplicationArea = all;
                    TableRelation = Customer."No.";
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

        subledcu.InsertData(Custno, startdate, Enddate);
        recCust.Reset();
        if recCust.get(Custno) then;

    end;

    var
        CompanyInfo: Record "Company Information";
        startdate: date;
        Enddate: date;
        recCust: Record Customer;
        RecCLE: Record "Cust. Ledger Entry";
        RecItem: Record Item;
        Custno: Code[10];
        subledcu: Codeunit 50006;
        ItemRec: Record Item;
        brandname: text[60];
        Cust: Record Customer;
        OpeningBalance: Decimal;
        bool: Boolean;
        rembal: Decimal;
        BAcc: Record "Bank Account";
        accname: Text[100];
        Paymetterm: Code[10];
        salepersonname: Text[50];
        saleper: Record "Salesperson/Purchaser";

}