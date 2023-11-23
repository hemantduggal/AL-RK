report 50000 "Purchase Order Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout/PurchaseOrder.rdl';
    //PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.";
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
            column(Buy_from_Vendor_No; "Buy-from Vendor No.")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Document_Date; format("Document Date"))
            {
            }
            column(Buy_from_Address; "Buy-from Address")
            {
            }
            column(Buy_from_Address_2; "Buy-from Address 2")
            {
            }
            column(Buy_from_City; "Buy-from City")
            {
            }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code")
            {
            }
            column(Buy_from_County; "Buy-from County")
            {
            }
            column(Buy_from_Post_Code; "Buy-from Post Code")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }


            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                column(Document_No_; "Document No.")
                {

                }

                column(Description; Description)
                {
                }
                column(Brand_Name; "Brand Name")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price__LCY_; "Unit Cost")
                {

                }
                /*
                column(Unit_Price__LCY_; "Unit Price (LCY)")
                {
                }
            */
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {
                }

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
                trigger OnAfterGetRecord()
                var
                    REqHead: Record "Requisition Header";
                    ReqLine: Record "Requisition Lines";
                begin
                    TAmount += Amount;
                    RecItem.Reset();
                    if RecItem.Get("Purchase Line"."No.") then;
                    REqHead.Reset();
                    REqHead.SetRange("Requisition No.", "Purchase Line"."Requisition No.");
                    if REqHead.FindFirst() then
                        RfqDate := REqHead."Posting Date";

                    CLEAR(AmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText1(AmountInWords, Round(TAmount), "Purchase Header"."Currency Code");

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
}