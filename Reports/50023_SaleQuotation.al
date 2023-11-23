report 50023 "Sale Quotation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout/saleQuote.rdl';
    //PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.";
            column(Your_Reference; "Your Reference")
            {

            }
            column(Quote_Validity; "Quote Validity")
            {

            }
            column(No; "No.")
            {

            }
            column(compinfonae; compinfo.Name)
            {

            }
            column(compinfoaddress1; compinfo.Address)
            {

            }
            column(compinfoaddress2; compinfo."Address 2")
            {

            }
            column(compinfocity; compinfo.City)
            {

            }
            column(compinfostate; compinfo."State Code") { }
            column(compinfoWeb; compinfo."Home Page") { }
            column(PurchaseNo; "No.")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Document_Date; format("Document Date"))
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
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Sell_to_County; "Sell-to County")
            {
            }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            {
            }

            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }


            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                column(Document_No_; "Document No.")
                {

                }
                column(Customer_Part_No_; "Customer Part No.")
                {

                }
                column(sno; sno)
                {

                }
                column(Remarks; Remarks)
                {

                }
                column(No_; "No.")
                {

                }
                column(Description; Description)
                {
                }

                column(Quantity; Quantity)
                {
                }
                column(Unit_Price__LCY_; "Unit Price")
                {

                }
                /*
                column(Unit_Price__LCY_; "Unit Price (LCY)")
                {
                }
            */


                column(Amount; Amount)
                {
                }
                column(RfqDate; format(RfqDate))
                {

                }
                column(ItemBrand; RecItem.Brand)
                {

                }
                column(TAmount; TAmount)
                {

                }
                column(AmountInWords; AmountInWords[1])
                {

                }
                column(SPQ; SPQ)
                {

                }
                column(MOQ; MOQ)
                {

                }
                column(LT; LT)
                {

                }
                trigger OnAfterGetRecord()
                var
                    REqHead: Record "Requisition Header";
                    ReqLine: Record "Requisition Lines";
                begin
                    sno += 1;
                    TAmount += Amount;
                    RecItem.Reset();
                    if RecItem.Get("Sales Line"."No.") then;


                    CLEAR(AmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText1(AmountInWords, Round(TAmount), "Sales Header"."Currency Code");

                end;

            }
            trigger OnAfterGetRecord()
            var

            begin

            end;
        }
    }
    trigger OnPreReport()
    var
    begin
        sno := 0;
        compinfo.Get;
        compinfo.CalcFields(compinfo.Picture);
    end;

    var
        compinfo: Record "Company Information";
        Vend: Record Vendor;
        RfqDate: Date;
        RFQHead: Record "Sales RFQ Header";
        RecItem: Record Item;
        TAmount: Decimal;
        Check: Report CheckPrint;
        AmountInWords: array[2] of Text;
        sno: Integer;
}
