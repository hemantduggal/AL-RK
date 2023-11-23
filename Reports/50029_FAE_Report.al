report 50029 "FAE Report"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    //   ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\FAEReport.rdl';
    dataset
    {
        dataitem("FAE Header"; "FAE Header")
        {
            // RequestFilterFields = "Posting Date";
            column(CompName; CompanyInfo.Name)
            {

            }
            column(startdate; Format(startdate))
            {

            }
            column(Enddate; Format(Enddate))
            {

            }
            column(Opportunity_Document_No_; "Opportunity Document No.")
            {

            }
            column(Customer_Name; "Customer Name") { }
            column(Opportunity_Date; "Opportunity Date")
            {

            }
            column(Product_Segment; "Product Segment")
            {

            }
            column(Support_FAE; "Support FAE")
            {

            }
            column(Opportunity_Status; "Opportunity Status")
            { }
            dataitem("FAE Line"; "FAE Line")
            {
                DataItemLink = "Opportunity Document No." = field("Opportunity Document No.");
                //  DataItemTableView = where("Assembly No." = filter('<>%1'''));

                column(Assembly_Name; "Assembly Name")
                {

                }
                column(CUSTTYPE; CUSTTYPE)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Margin; Margin)
                {

                }
                column(DC_NonDC; DC_NonDC)
                {

                }
                column(Sq1; Sq1)
                {

                }
                column(Eq1; Eq1)
                {

                }
                column(Region; Region)
                {

                }
                column(Brand; Brand)
                {

                }
                column(Remarks; Remarks)
                {

                }
                column(RecItemBuyingrate; RecItem."Buying Rate (INR)") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Opportunity_Document_Noline; "Opportunity Document No.") { }

                trigger OnAfterGetRecord()
                var
                Begin
                    Clear(startyear);
                    Clear(Endyear);
                    Clear(Sq1);
                    Clear(Sq2);
                    Clear(Sq3);
                    Clear(Sq4);
                    Clear(Eq1);
                    Clear(Eq2);
                    Clear(Eq3);
                    Clear(Eq4);
                    if "FAE Line".Margin > 10 then
                        DC_NonDC := 'DC'
                    else
                        DC_NonDC := 'NON-DC';

                    cle.Reset();
                    cle.SetRange("Customer No.", "FAE Header"."Customer No.");
                    if cle.FindFirst() then
                        CUSTTYPE := 'Organice'
                    else
                        CUSTTYPE := 'New';

                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn("FAE Header"."Customer Name", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("FAE Line"."Assembly Name", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    cle.Reset();
                    cle.SetRange("Customer No.", "FAE Header"."Customer No.");
                    if cle.FindFirst() then
                        ExcelBuffer.AddColumn('Organic', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text)
                    else
                        ExcelBuffer.AddColumn('New', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                    ExcelBuffer.AddColumn("FAE Line".Quantity * "FAE Line"."Direct Unit Cost", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    RecItem.Reset();
                    RecItem.SetRange("No.", "FAE Line"."Assembly No.");
                    if RecItem.FindFirst() then;
                    ExcelBuffer.AddColumn("FAE Line".Quantity * RecItem."Buying Rate (INR)", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("FAE Line".Margin, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("FAE Header"."Opportunity Status", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("FAE Header"."Product Segment", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    if "FAE Line".Margin > 10 then BEGIN
                        ExcelBuffer.AddColumn('DC', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('DC', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    END ELSE begin
                        ExcelBuffer.AddColumn('NON-DC', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('NON-DC', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    end;

                    strtmonth := Date2DMY(startdate, 2);
                    endmonth := Date2DMY(Enddate, 2);
                    startyear := Date2DMY(startdate, 3);
                    Endyear := Date2DMY(Enddate, 3);
                    if (strtmonth = 1) OR (strtmonth = 2) OR (strtmonth = 3) then
                        Sq1 := 'Q4 FY' + Format(startyear);
                    if (strtmonth = 4) OR (strtmonth = 5) OR (strtmonth = 6) then
                        Sq1 := 'Q1 FY' + Format(startyear);
                    if (strtmonth = 7) OR (strtmonth = 8) OR (strtmonth = 9) then
                        Sq1 := 'Q2 FY' + Format(startyear);
                    if (strtmonth = 10) OR (strtmonth = 11) OR (strtmonth = 12) then
                        Sq1 := 'Q3 FY' + Format(startyear);

                    if (endmonth = 1) OR (endmonth = 2) OR (endmonth = 3) then
                        Eq1 := 'Q4 FY' + Format(Endyear);
                    if (endmonth = 4) OR (endmonth = 5) OR (endmonth = 6) then
                        Eq1 := 'Q1 FY' + Format(Endyear);
                    if (endmonth = 7) OR (endmonth = 8) OR (endmonth = 9) then
                        Eq1 := 'Q2 FY' + Format(Endyear);
                    if (endmonth = 10) OR (endmonth = 11) OR (endmonth = 12) then
                        Eq1 := 'Q3 FY' + Format(Endyear);

                    ExcelBuffer.AddColumn(Sq1, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Eq1, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Sq1, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("FAE Line".Region, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("FAE Header"."Support FAE", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("FAE Line".Remarks, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


                end;
            }
            trigger OnPreDataItem()
            begin
                "FAE Header".SetRange("Opportunity Date", startdate, Enddate);
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
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('FAE Report', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Sold to Party', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Material', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Biz Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Resale', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INV', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Margin', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Segment', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Design Registration project ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Supplier REG#', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('FAE Validation', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Syatem Validation', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Start QTR', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('End QTR', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('D-Win QTR', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('FAE Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Region', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Line', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Support FAE', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('DC Approved By', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    trigger OnPostReport()
    begin
        /*
        ExcelBuffer.CreateNewBook('FAE Report');
        ExcelBuffer.WriteSheet('FAE Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('FAE Report', CurrentDateTime, UserId));
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
        cle: Record "Cust. Ledger Entry";
        startyear: Integer;
        Endyear: Integer;
        Sq1: Text;
        Sq2: Text;
        Sq3: text;
        Sq4: Text;
        Eq1: Text;
        Eq2: Text;
        Eq3: text;
        Eq4: Text;
        startqtr: Date;
        Endqtr: Date;
        strtmonth: Integer;
        endmonth: Integer;
        DC_NonDC: Text;
        CUSTTYPE: TEXT;
}