report 50035 "Sales RFQ Register Report"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    // ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\SaleRFQRegister.rdl';
    dataset
    {
        dataitem("Sales RFQ Header"; "Sales RFQ Header")
        {
            // RequestFilterFields = "Posting Date";
            column(CompanyInfoName; CompanyInfo.Name)
            {

            }
            column(startdate; Format(startdate)) { }
            column(Enddate; Format(Enddate)) { }
            column(Document_Date; Format("Document Date")) { }
            column(RFQ_Doc_No_; "RFQ Doc No.")
            {

            }
            column(Your_Ref_; "Your Ref.") { }
            column(Customer_Name; "Customer Name") { }
            column(custpaymentterm; cust."Payment Terms Code") { }


            dataitem("Sales RFQ Line"; "Sales RFQ Line")
            {
                DataItemLinkReference = "Sales RFQ Header";
                DataItemLink = "RFQ Doc No." = field("RFQ Doc No.");
                //  DataItemTableView = where("Quote Created" = const(false));

                column(RFQ_Doc_No_Line; "RFQ Doc No.") { }
                column(Location_Code; "Location Code") { }
                column(Description; Description) { }
                column(Brand; Brand) { }
                column(Quantity; Quantity) { }
                column(Rate; Rate) { }
                column(Remarks; Remarks) { }
                column(Request_Date; Format("Request Date")) { }
                column(Confirm_Date; Format("Confirm Date")) { }
                column(Estimated_Date; Format("Estimated Date")) { }
                trigger OnAfterGetRecord()
                var
                Begin
                    cust.Reset();
                    cust.SetRange("No.", "Sales RFQ Header"."Customer No.");
                    if cust.FindFirst() then;

                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn("Sales RFQ Header"."Document Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Sales RFQ Header"."RFQ Doc No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Sales RFQ Header"."Your Ref.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Sales RFQ Header"."Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                    ExcelBuffer.AddColumn(cust."Payment Terms Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Sales RFQ Line"."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    RecItem.Reset();
                    RecItem.SetRange("No.", "Sales RFQ Line"."Item No.");
                    if RecItem.FindFirst() then;
                    ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Sales RFQ Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Sales RFQ Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Sales RFQ Line".Rate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Sales RFQ Line".Quantity * "Sales RFQ Line".Rate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Sales RFQ Line".Remarks, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Sales RFQ Line"."Request Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Sales RFQ Line"."Confirm Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Sales RFQ Line"."Estimated Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);

                end;
            }
            trigger OnPreDataItem()
            begin
                "Sales RFQ Header".SetRange("Posting Date", startdate, Enddate);
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

        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        ExcelBuffer.DELETEALL;


        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('DATE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Your Ref.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer NAME', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
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

    trigger OnPostReport()
    begin
        /*
        ExcelBuffer.CreateNewBook('SalesRFQ');
        ExcelBuffer.WriteSheet('SalesRFQ Sheet', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('SalesRFQ', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        */
    end;

    var
        CompanyInfo: Record "Company Information";

        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;
        RecItem: Record Item;
        cust: Record Customer;
}