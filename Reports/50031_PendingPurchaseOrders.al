report 50031 PendingPurchOrders
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Pending Purchase Order Report';
    //  ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\PendingPurchaseOrder.rdl';
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = WHERE("Document Type" = CONST(Order));
            column(No_; "No.")
            {

            }

            column(CompanyInfoName; CompanyInfo.Name)
            {

            }
            column(startdate; format(startdate)) { }
            column(Enddate; format(Enddate)) { }
            column(Document_Date; format("Document Date")) { }
            column(salepername; saleper.Name) { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Your_Reference; "Your Reference") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Location_Codeheader; "Location Code") { }
            column(Shipment_Date; format("Expected Receipt Date")) { }
            column(Refrence_No_; "Refrence No.") { }
            column(Opp__Refrence_No_; "Opp. Refrence No.") { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.") WHERE("Document Type" = CONST(Order));
                column(ItemNo; "No.") { }

                column(Estimated_Date; Format("Estimated Date")) { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Item1Brand; Item1.Brand) { }
                column(Brand_Name; "Brand Name") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Location_CodeLine; "Location Code") { }
                column(Quantity; Quantity) { }
                column(Unit_Cost; "Unit Cost") { }
                column(Remarks; Remarks) { }
                column(Item1DCPLPrice; Item1."DCPL Price")
                { }
                column(POP; POP) { }
                column(End_Customer; "End Customer") { }
                column(Application; Application) { }
                column(Confirm_Date; Format("Confirm Date")) { }

                trigger OnAfterGetRecord()
                var
                Begin
                    Item1.Reset();
                    Item1.SetRange("No.", "Purchase Line"."No.");
                    if Item1.FindFirst() then;


                end;
            }
            trigger OnAfterGetRecord()
            begin
                saleper.Reset();
                saleper.SetRange(Code, "Purchase Header"."Purchaser Code");
                if saleper.FindFirst() then;
            end;

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
        CompanyInfo.GET;

    end;

    trigger OnPostReport()
    begin

    end;

    var
        CompanyInfo: Record "Company Information";
        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;
        RecItem: Record item;
        Item1: Record Item;
        saleper: Record "Salesperson/Purchaser";

}