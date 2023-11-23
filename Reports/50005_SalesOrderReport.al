report 50005 "Sales Order Report"
{
    UsageCategory = Administration;
    Caption = 'Sales Order Report ';
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesOrderReport.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Date Filter", "Location Filter";
            DataItemTableView = WHERE("Document Type" = const(order));

            column(CmpName; CompanyInfo.Name)
            {

            }
            column(CmpAdd; CompanyInfo.Address)
            {

            }
            column(CmpAdd2; CompanyInfo."Address 2")
            {

            }
            column(CmpCity; CompanyInfo.City)
            {

            }
            column(CmpPin; CompanyInfo."Post Code")
            {

            }
            column(CmpEmail; CompanyInfo."E-Mail")
            {

            }
            column(CmpPhone; CompanyInfo."Phone No.")
            {

            }
            column(CmpPic; CompanyInfo.Picture)
            {

            }
            column(CmpGST; CompanyInfo."GST Registration No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Sell_to_Address; "Sell-to Address")
            {

            }
            column(Sell_to_Address_2; "Sell-to Address 2")
            {

            }
            column(Sell_to_City; "Sell-to City")
            {

            }
            column(Sell_to_County; "Sell-to County")
            {

            }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(Bill_to_Address_2; "Bill-to Address 2")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Order_Date; format("Order Date"))
            {

            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(UID; format("UID Date"))
                {

                }
                column(Planned_Delivery_Date; format("Planned Delivery Date"))
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Brand; Brand)
                {

                }
                column(ItemNo; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount; Amount)
                {

                }
                column(AmountInWords; AmountInWords[1])
                {

                }
                trigger OnPreDataItem()
                var
                begin
                    TotalAmt := 0;
                end;

                trigger OnAfterGetRecord()
                var
                Begin
                    TotalAmt += Amount;

                    CLEAR(AmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWords, Round(TotalAmt), "Sales Header"."Currency Code");


                end;
            }
        }
    }

    trigger OnPreReport()
    var
    begin
        CompanyInfo.GET;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    trigger OnPostReport()
    begin

    end;

    var
        CompanyInfo: Record "Company Information";
        Check: Report CheckPrint;
        AmountInWords: array[2] of Text;
        TotalAmt: Decimal;
}