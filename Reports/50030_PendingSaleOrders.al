report 50030 PendingSalesOrders
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Pending Sales Order Report';
    //  ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\PendingSaleOrder.rdl';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
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
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Your_Reference; "Your Reference") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Location_Codeheader; "Location Code") { }
            column(Shipment_Date; format("Shipment Date")) { }
            column(Customer_PO_No_; "Customer PO No.") { }
            column(Zone; Zone) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.") WHERE("Document Type" = CONST(Order));

                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Item1Brand; Item1.Brand) { }
                column(Brand; Brand) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Location_CodeLine; "Location Code") { }
                column(Quantity; Quantity) { }
                column(Unit_Cost; "Unit Cost") { }
                column(Remarks; Remarks) { }
                column(Confirm_Date; format("Confirm Date"))
                { }
                column(Unit_Price; "Unit Price") { }
                column(Requested_Delivery_Date; Format("Requested Delivery Date")) { }
                column(UID_Date; Format("UID Date")) { }
                column(Estimated_Date; Format("Estimated Date")) { }
                column(Availablestock; Availablestock) { }
                trigger OnAfterGetRecord()
                var
                Begin
                    Clear(Availablestock);
                    Item1.Reset();
                    Item1.SetRange("No.", "Sales Line"."No.");
                    if Item1.FindFirst() then;
                    Item1.CalcFields(Inventory);
                    Availablestock := Item1.Inventory;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                saleper.Reset();
                saleper.SetRange(Code, "Sales Header"."Salesperson Code");
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
        Availablestock: Decimal;
}