/*

report 50013 "Stock Ledger Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {

        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.";
            // DataItemLink = "Item No." = field("No.");

            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SetRange("Posting Date", strtdate, enddate);
                CreatExcelHeader();


            end;

            trigger OnAfterGetRecord()
            var
                ILE: Record "Item Ledger Entry";
                PurRcptHdr: Record "Purch. Rcpt. Header";
                SalShpHdr: Record "Sales Shipment Header";
                TranRecptHrd: Record "Transfer Receipt Header";

                days: Integer;
                ToDate: Date;
            begin

                Clear(OpeningStock);
                ILE.Reset();
                ILE.SetFilter("Posting Date", '%1..%2', 0D, enddate - 1);
                ILE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                if ILE.FindSet() then begin
                    repeat
                        OpeningStock += ILE."Remaining Quantity";
                    Until ILE.Next() = 0;
                end;

                CreatExcelBody();
                

             end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(strtdate; strtdate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = all;
                    }

                    field(enddate; enddate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    procedure CreatExcelBook()
    var
        myInt: Integer;
    begin
        ExcelBuffer.CreateNewBook('Item Ledger Entry');
        ExcelBuffer.WriteSheet('Item Ledger Entry', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('stock ledger Entry');
        ExcelBuffer.OpenExcel();

    end;

    local procedure CreatExcelHeader()
    var
        myInt: Integer;
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(compinfo.Name, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Stock-Ledger Report', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(strtdate, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(enddate, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Date', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Brand Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Rate IN USD', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('IN Qty', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Out Qty', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Qty Bal.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('AGE', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('REMARKS', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);


    end;

    local procedure CreatExcelBody()
    var
        myInt: Integer;
    begin
        



        // Clear(Itmno);
        //   if bool = false then begin

        ExcelBuffer.NewRow();
        if Itmno <> "Item Ledger Entry"."Item No." then
            ExcelBuffer.AddColumn("Item Ledger Entry"."Item No.", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)
        else
            ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        Itmno := "Item Ledger Entry"."Item No.";
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('OpeningStock', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("openingstock", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        //  bool := true;
        // end;

        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn("Item Ledger Entry"."Posting Date", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Item Ledger Entry"."Document No.", false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Receipt" then begin
            PPR.Reset();
            PPR.SetRange("No.", "Item Ledger Entry"."Document No.");
            if PPR.FindFirst() then begin
                vend.Reset();
                if vend.get(PPR."Buy-from Vendor No.") then;
                ExcelBuffer.AddColumn(vend.Name, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)

            end;
        end else
            if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Shipment" then begin
                SSH.Reset();
                SSH.SetRange("No.", "Item Ledger Entry"."Document No.");
                if SSH.FindFirst() then begin
                    cust.Reset();
                    if cust.get(SSH."Sell-to Customer No.") then;
                    ExcelBuffer.AddColumn(cust.Name, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)

                end;
            end else
                ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);


        ///////////////////////////
        ExcelBuffer.AddColumn("Item Ledger Entry"."Location Code", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        item.Reset();
        if item.Get("Item Ledger Entry"."Item No.") then;
        ExcelBuffer.AddColumn(item.Brand, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ////////////////unit price calculation
        //ExcelBuffer.AddColumn(Item."Unit Price", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Receipt" then begin
            PPR.Reset();
            PPR.SetRange("No.", "Item Ledger Entry"."Document No.");
            if PPR.FindFirst() then begin
                PPRL.Reset();
                PPRL.SetRange("Document No.", PPR."No.");
                PPRL.SetRange("No.", "Item Ledger Entry"."Item No.");
                if PPRL.FindFirst() then
                    ExcelBuffer.AddColumn(PPRL."Unit Cost", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)

            end;
        end else
            if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Shipment" then begin
                SSH.Reset();
                SSH.SetRange("No.", "Item Ledger Entry"."Document No.");
                if SSH.FindFirst() then begin
                    SSL.Reset();
                    SSL.SetRange("Document No.", SSH."No.");
                    SSL.SetRange("No.", "Item Ledger Entry"."Item No.");
                    if SSL.FindFirst() then
                        ExcelBuffer.AddColumn(SSL."Unit Cost", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)
                end;
            end else
                ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);




        if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Receipt" then
            ExcelBuffer.AddColumn("Item Ledger Entry".Quantity, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)
        else
            ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Shipment" then
            ExcelBuffer.AddColumn("Item Ledger Entry".Quantity, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)
        else
            ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn("Item Ledger Entry"."Remaining Quantity", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();


    end;
    //  end;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        bool := false;
        if compinfo.Get() then
            compinfo.CalcFields(Picture);
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
        myInt: Integer;
        ExcelBuffer: Record "Excel Buffer" temporary;
        Age: Integer;
        item: Record Item;
        strtdate: Date;
        enddate: Date;
        bool: Boolean;
        OpeningStock: Decimal;
        PPR: Record "Purch. Rcpt. Header";
        PPRL: Record "Purch. Rcpt. Line";
        vend: Record Vendor;
        compinfo: Record "Company Information";
        SSH: Record "Sales Shipment Header";
        cust: Record Customer;
        SSL: Record "Sales Shipment Line";
        payterm: Integer;
        Itmno: Code[20];
        tempitem: Record ItemTemp;
}
*/