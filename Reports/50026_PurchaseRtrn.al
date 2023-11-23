report 50026 "Purchase Return Report"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    // ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\purchReturn.rdl';
    dataset
    {
        dataitem("Return Shipment Header"; "Return Shipment Header")
        {
            // RequestFilterFields = "Posting Date";
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(No_; "No.")
            {

            }
            column(startdate; format(startdate)) { }
            column(Enddate; format(Enddate)) { }
            column(postdate; format(postdate))
            {

            }
            column(CompName; CompanyInfo.Name)
            {

            }
            column(Posting_Date; format("Posting Date"))
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Your_Reference; "Your Reference") { }
            dataitem("Return Shipment Line"; "Return Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = const(Item));

                column(No1_; "No.")
                {

                }
                column(RecItem; RecItem.Brand)
                {

                }
                column(Description; Description)
                {

                }
                column(Location_Code; "Location Code")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Return_Qty__Shipped_Not_Invd_; "Return Qty. Shipped Not Invd.")
                {

                }
                trigger OnAfterGetRecord()
                var
                Begin
                    Clear(INVNO);
                    Clear(invno1);
                    Clear(postdate);
                    ExcelBuffer.NewRow;
                    rsl.Reset();
                    rsl.SetRange("Document No.", "Return Shipment Line"."Document No.");
                    // rsl.SetFilter(Type, '%1', rsl.Type::" ");
                    rsl.SetRange("Line No.", 10000);
                    if rsl.FindFirst() then
                        INVNO := (CopyStr(rsl.Description, 13, 26));
                    invno1 := DelChr(INVNO, '=', ':');
                    //Message('%1', invno1);
                    pih.Reset();
                    pih.SetRange("No.", invno1);
                    if pih.FindFirst() then
                        postdate := pih."Posting Date"
                    else
                        postdate := 0D;

                    RecItem.Reset();
                    if RecItem.Get("Return Shipment Line"."No.") then;

                    ExcelBuffer.AddColumn(postdate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);

                    ExcelBuffer.AddColumn("Return Shipment Header"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Return Shipment Header"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Return Shipment Header"."Buy-from Vendor Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // RecItem.Reset();
                    //  if RecItem.Get("Return Shipment Line"."No.") then;
                    ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                    ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Return Shipment Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Return Shipment Line"."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Return Shipment Line"."Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Return Shipment Line".Quantity * "Return Shipment Line"."Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Return Shipment Header"."Your Reference", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Return Shipment Line"."Return Qty. Shipped Not Invd.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                end;
            }
            trigger OnPreDataItem()
            begin
                "Return Shipment Header".SetRange("Posting Date", startdate, Enddate);
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
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        ExcelBuffer.DELETEALL;


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
        ExcelBuffer.AddColumn('Purchase Return Group', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('INVOICE DATE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor NAME', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Product', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Brand Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Price', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Value', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Net POP', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Net POP Value', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Your Ref', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CTN', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Shipment', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    trigger OnPostReport()
    begin
        /*
        ExcelBuffer.CreateNewBook('Purchase Return');
        ExcelBuffer.WriteSheet('Purchase Return Sheet', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Purchase Return', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        */
    end;

    var
        CompanyInfo: Record "Company Information";

        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;
        RecItem: Record Item;
        INVNO: Code[30];
        pih: Record "Purch. Inv. Header";
        rsl: Record "Return Shipment Line";
        invno1: Code[30];
        postdate: Date;
}