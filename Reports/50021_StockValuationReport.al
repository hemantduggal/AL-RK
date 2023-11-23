/*
report 50021 "Stock Valuation Report"
{
    UsageCategory = Administration;
    Caption = 'Stock Valuation Report';
    ApplicationArea = all;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                //RequestFilterFields = "Item No.";
                DataItemLink = "Item No." = field("No.");

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", startdate, Enddate);
                    // CreatExcelHeader();
                end;

                trigger OnAfterGetRecord()
                var
                Begin
                    sno += 1;
                    Qty := 0;
                    itemno := "Item Ledger Entry"."Item No.";
                    Locaationcode := "Item Ledger Entry"."Location Code";


                    // if bool = false then begin
                    if (itemno1 <> itemno) AND (Locaationcode1 <> Locaationcode) then begin
                        ExcelBuffer.NewRow;
                        RecItem.reset;
                        RecItem.setrange("No.", "Item Ledger Entry"."Item No.");
                        if RecItem.FindFirst() then
                            ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(RecItem.Type, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Item Ledger Entry"."Location Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ile.Reset();
                        ile.SetRange("Posting Date", startdate, Enddate);
                        ile.SetRange("Item No.", itemno);
                        ile.SetRange("Location Code", Locaationcode);
                        if ile.FindSet() then begin
                            repeat
                                Qty += ile.Quantity;
                            until ile.Next() = 0;
                        end;
                        ExcelBuffer.AddColumn(Qty, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(RecItem."Buying Rate (USD)", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(RecItem."Buying Rate (USD)" * "Item Ledger Entry".Quantity, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(RecItem."Buying Rate (INR)", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(RecItem."Buying Rate (INR)" * "Item Ledger Entry".Quantity, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    End;
                    itemno1 := "Item Ledger Entry"."Item No.";
                    Locaationcode1 := "Item Ledger Entry"."Location Code";
                    bool := true;
                end;

            }

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
        bool := false;
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        ExcelBuffer.DELETEALL;

        sno := 0;
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
        ExcelBuffer.AddColumn('Stock Valuation Report As On', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Brand Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Particulars', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('USD Rate', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('USD Gross', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INR Price', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INR Gross', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('Stock Valuation Report');
        ExcelBuffer.WriteSheet('Stock Valuation Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Stock Valuation Report', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
    end;

    var
        RecItem: Record Item;
        saleperpur: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        Cust: Record "Customer";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGST_perc: Decimal;
        IGST_Amt: Decimal;
        CGST_perc: Decimal;
        CGST_Amt: Decimal;
        SGST_perc: Decimal;
        SGST_Amt: Decimal;
        TotalGST: Decimal;
        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;
        compinfo: Record "Company Information";
        sno: Integer;
        Qty: Decimal;
        ile: Record "Item Ledger Entry";
        bool: Boolean;
        itemno: Code[20];
        Locaationcode: Code[20];
        itemno1: Code[20];
        Locaationcode1: Code[20];
}
*/