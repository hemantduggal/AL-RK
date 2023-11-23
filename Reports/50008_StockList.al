report 50008 StockListReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            trigger OnPreDataItem()
            begin
                CreatExcelHeader();

            end;

            trigger OnAfterGetRecord()

            begin
                CreatExcelBody();
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

    procedure CreatExcelBook()
    var
        myInt: Integer;
    begin
        ExcelBuffer.CreateNewBook('Stock List');
        ExcelBuffer.WriteSheet('Stock List', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Stock List Export');
        ExcelBuffer.OpenExcel();
    end;

    local procedure CreatExcelHeader()
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
        ExcelBuffer.AddColumn('Stock List', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;

        ExcelBuffer.AddColumn('Reserve1', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total RK', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('USD COST', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('USD VALUE', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('RATE INR', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('INR VALUE', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('SPQ', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('MOQ', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('FORMULA USD', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('FORMULA INR', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('SHELF NO.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
    end;

    local procedure CreatExcelBody()
    var
        myInt: Integer;
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn("Item Ledger Entry"."Location Code", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        RecItem.Reset();
        RecItem.SetRange("No.", "Item Ledger Entry"."Item No.");
        if RecItem.FindFirst() then;
        ExcelBuffer.AddColumn(RecItem."Buying Rate (INR)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."Buying Rate (INR)" * "Item Ledger Entry".Quantity, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."Buying Rate (USD)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."Buying Rate (USD)" * "Item Ledger Entry".Quantity, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."SPQ(Std. product Qty)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."MOQ(Minimum order Qty)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."Formula USD", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."Formula INR", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(RecItem."Shelf No.", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
    end;

    trigger OnInitReport()
    begin
        ExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        CreatExcelBook();
    end;

    var
        startdate: Date;
        myInt: Integer;
        ExcelBuffer: Record "Excel Buffer" temporary;
        RecItem: Record Item;
        CompanyInfo: Record "Company Information";
        Enddate: Date;
}