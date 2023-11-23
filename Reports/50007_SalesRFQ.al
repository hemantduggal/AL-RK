report 50007 SalesRFQReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\RFQCustom.rdl';
    dataset
    {
        dataitem("Sales RFQ Header"; "Sales RFQ Header")
        {
            column(Your_Ref; "Your Ref.")
            {

            }

            column(Contact_No_; "Contact No.")
            { }
            column(Contact_person; "Contact person")
            {

            }
            column(CompanyInfoname; CompanyInfo.Name)
            {

            }
            column(CompanyInfoadd1; CompanyInfo.Address)
            {

            }
            column(CompanyInfoAdd2; CompanyInfo."Address 2")
            {

            }
            column(CompanyInfo; CompanyInfo.City)
            {

            }
            column(CompanyInfopost; CompanyInfo."Post Code")
            {

            }
            column(CompanyInfgst; CompanyInfo."GST Registration No.")
            {

            }
            column(CompanyInfoph; CompanyInfo."Phone No.")
            {

            }
            column(Custadd; Cust.Address)
            {

            }
            column(Custadd2; Cust."Address 2")
            {

            }
            column(Custstate; Cust."State Code")
            {

            }
            column(Custpaymentterm; Cust."Payment Terms Code")
            {

            }
            column(Custcity; Cust.City)
            {

            }
            column(RFQ_Doc_No_; "RFQ Doc No.")
            { }
            column(Customer_No_; "Customer No.")
            { }
            column(Customer_Name; "Customer Name")
            { }
            column(Original_Customer_Name; "Original Customer Name")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(Location; Location)
            { }
            column(Salesperson; Salesperson)
            { }

            dataitem("Sales RFQ Line"; "Sales RFQ Line")
            {
                DataItemLinkReference = "Sales RFQ Header";
                DataItemLink = "RFQ Doc No." = field("RFQ Doc No.");
                column(RFQ_Doc_No_l;
                "RFQ Doc No.")
                { }
                column(Application; Application)
                { }
                column(project; project)
                {

                }
                column(Design_Part_No_; "Design Part No.")
                { }
                column(Description; Description)
                { }
                column(Quantity; Quantity)
                { }
                column(Cost_price; "Direct Unit Cost")
                { }

                column(Amount; Rate)
                { }
                column(Remarks; Remarks)
                { }
                column(Document_Date; "Document Date")
                { }
                column(Item_No_; "Item No.")
                { }
                column(Total_Amount; Total_Amount)
                { }
                column(Brand; Brand)
                { }

                column(AmtWithWordsTaxAmt; AmtWithWordsTaxAmt)
                { }
                column(AmountInWords; AmountInWords[1])
                {

                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    SL: Record "Sales RFQ Line";

                begin

                    Total_Amount += Rate;

                    CLEAR(AmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWords, Round(Total_Amount), "Sales RFQ Header"."currency Code");

                end;




            }
            trigger OnAfterGetRecord()
            var
            begin
                Cust.Reset();
                Cust.SetRange("No.", "Sales RFQ Header"."Customer No.");
                if Cust.FindFirst() then;
            end;
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
    begin
        CompanyInfo.GET;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        myInt: Integer;
        Amount: Decimal;
        Total_Amount: Decimal;
        Saleline: Record "Sales RFQ Line";
        AmtWithWordsTaxAmt: Text;
        Check: Report CheckPrint;
        AmountInWords: array[2] of Text;
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
}