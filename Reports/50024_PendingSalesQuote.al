report 50024 PendingSalesQuote
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Pending Sales Quote Report';
    //  ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\PendingSaleQuote.rdl';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";

            column(No_; "No.")
            {

            }
            column(CompanyInfoName; CompanyInfo.Name)
            {

            }
            column(startdate; format(startdate)) { }
            column(Enddate; format(Enddate)) { }
            column(Document_Date; format("Document Date")) { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Your_Reference; "Your Reference") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Location_Code; "Location Code") { }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.") WHERE("Document Type" = CONST(Quote), partially = filter(false));

                column(Description; Description) { }
                column(Item1Brand; Item1.Brand) { }
                column(Quantity; Quantity) { }
                column(Unit_Cost; "Unit Cost") { }
                column(Remarks; Remarks) { }
                column(Requested_Delivery_Date; Format("Requested Delivery Date")) { }
                column(UID_Date; Format("UID Date")) { }
                column(Estimated_Date; Format("Estimated Date")) { }

                trigger OnAfterGetRecord()
                var
                Begin
                    Item1.Reset();
                    Item1.SetRange("No.", "Sales Line"."No.");
                    if Item1.FindFirst() then;

                    MakeBody();
                end;
            }
            trigger OnPreDataItem()
            begin
                Makeheader();
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
        ExcelBuffer.DELETEALL
    end;

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('Pending Sales Quote');
        ExcelBuffer.WriteSheet('Pending Sales Quote Sheet', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Pending Sales Quote', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
    end;

    var
        CompanyInfo: Record "Company Information";
        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;
        RecItem: Record item;
        Item1: Record Item;

    Local procedure Makeheader()
    var
        myInt: Integer;
    begin
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
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Pending Sales Quote', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(Enddate, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Your Ref.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Payment Term', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Product Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Brand', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Qty', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance Qty.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Rate', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gross Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('RD', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CD', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ED', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("Sales Header"."Document Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Sales Header"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Your Reference", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Payment Terms Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
        RecItem.Reset();
        RecItem.SetRange("No.", "Sales Line"."No.");
        if RecItem.FindFirst() then;
        ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn("Sales Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line"."Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line".Quantity * "Sales Line"."Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line".Remarks, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn("Sales Line"."Requested Delivery Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::date);
        ExcelBuffer.AddColumn("Sales Line"."UID Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::date);
        ExcelBuffer.AddColumn("Sales Line"."Estimated Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::date);
    end;
}