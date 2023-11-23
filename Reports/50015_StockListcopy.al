report 50015 StockListReportnew
{
    Caption = 'Stock List Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\StockList.rdl';
    dataset
    {
        dataitem("Item Ledger Entry"; Item)
        {
            RequestFilterFields = "No.";
            column(CompanyInfo; CompanyInfo.Name)
            { }
            column(startdate; startdate) { }
            column(Enddate; Enddate) { }
            column(Brand; Brand) { }
            column(No_; "No.") { }
            column(Description; Description) { }
            column(RK; RK1)
            { }
            column(Pune; Pune1)
            { }
            column(WZ; WZ1)
            { }
            column(nsp; nsp1)
            { }
            column(reserv; reserv1_1)
            { }
            column(reserv1; reserv1_2)
            { }
            column(Buying_Rate__INR_; "Buying Rate (INR)")
            { }
            column(Buying_Rate__USD_; "Buying Rate (USD)")
            { }
            column(MOQ_Minimum_order_Qty_; "MOQ(Minimum order Qty)")
            { }
            column(SPQ_Std__product_Qty_; "SPQ(Std. product Qty)")
            { }
            column(Formula_INR; "Formula INR")
            { }
            column(Formula_USD; "Formula USD")
            { }
            column(Shelf_No_; "Shelf No.")
            { }
            trigger OnPreDataItem()
            begin

                Bool := false;

                if ExportToExcel = true then
                    CreatExcelHeader();
                if Locationcode <> '' then
                    ILE.SetRange("Location Code", Locationcode);
            end;

            trigger OnAfterGetRecord()

            begin
                Clear(RK1);
                Clear(WZ1);
                Clear(nsp1);
                Clear(Pune1);
                Clear(reserv1_1);
                Clear(reserv1_2);
                if ExportToExcel = true then
                    CreatExcelBody();


                ILE.Reset();
                ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
                ILE.SetRange("Posting Date", startdate, Enddate);
                // ILE.SetRange("Location Code", Locationcode);
                ILE.SetFilter("Location Code", 'IN-TRANSIT');
                if ILE.FindSet() then begin
                    repeat
                        if Locationcode <> '' then begin
                            if Locationcode = 'IN-TRANSIT' then
                                rk1 += ILE."Remaining Quantity";
                        end else
                            rk1 += ILE."Remaining Quantity";
                    until ILE.Next() = 0;
                end;

                ILE.Reset();
                ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
                ILE.SetRange("Posting Date", startdate, Enddate);
                // ILE.SetRange("Location Code", Locationcode);
                ILE.SetFilter("Location Code", 'PUNE');
                if ILE.FindSet() then begin
                    repeat
                        if Locationcode <> '' then begin
                            if Locationcode = 'Pune' then
                                Pune1 += ILE."Remaining Quantity";
                        end else
                            Pune1 += ILE."Remaining Quantity";
                    until ILE.Next() = 0;
                end;

                ILE.Reset();
                ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
                ILE.SetRange("Posting Date", startdate, Enddate);
                // ILE.SetRange("Location Code", Locationcode);
                ILE.SetFilter("Location Code", 'WZ');
                if ILE.FindSet() then begin
                    repeat
                        if Locationcode <> '' then begin
                            if Locationcode = 'WZ' then
                                WZ1 += ILE."Remaining Quantity";
                        end else
                            WZ1 += ILE."Remaining Quantity";
                    until ILE.Next() = 0;
                end;

                ILE.Reset();
                ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
                ILE.SetRange("Posting Date", startdate, Enddate);
                // ILE.SetRange("Location Code", Locationcode);
                ILE.SetFilter("Location Code", 'NSP');
                if ILE.FindSet() then begin
                    repeat
                        if Locationcode <> '' then begin
                            if Locationcode = 'NSP' then
                                nsp1 += ILE."Remaining Quantity";
                        end else
                            nsp1 += ILE."Remaining Quantity";
                    until ILE.Next() = 0;
                end;

                ILE.Reset();
                ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
                ILE.SetRange("Posting Date", startdate, Enddate);
                // ILE.SetRange("Location Code", Locationcode);
                ILE.SetFilter("Location Code", 'RESERVE');
                if ILE.FindSet() then begin
                    repeat
                        if Locationcode <> '' then begin
                            if Locationcode = 'RESERVE' then
                                reserv1_1 += ILE."Remaining Quantity";
                        end else
                            reserv1_1 += ILE."Remaining Quantity";
                    until ILE.Next() = 0;

                end;
                /*
                                ILE.Reset();
                                ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
                                ILE.SetRange("Posting Date", startdate, Enddate);
                                // ILE.SetRange("Location Code", Locationcode);
                                ILE.SetFilter("Location Code", 'RESERVE1');
                                if ILE.FindSet() then begin
                                    repeat
                                        if Locationcode <> '' then begin
                                            if Locationcode = 'RESERVE1' then
                                                reserv1_2 += ILE."Remaining Quantity";
                                        end else
                                            reserv1_2 += ILE."Remaining Quantity";
                                    until ILE.Next() = 0;
                                end;
                                */
            end;

            trigger OnPostDataItem()
            begin
                if ExportToExcel = true then begin
                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('Total', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(TOtalAMtRK, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(TOtalAMtPune, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(TOtalAMtWZ, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(TOtalAMtNSP, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(TOtalAMtreserve, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(TOtalAMtreserve1, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totqty, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totusdval, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totinrval, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
                end;
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
                field(Locationcode; Locationcode)
                {
                    Caption = 'Location Code';
                    ApplicationArea = all;
                    TableRelation = Location.Code;
                }
                field(ExportToExcel; ExportToExcel)
                {

                    ApplicationArea = all;
                }
            }
        }
    }

    procedure CreatExcelBook()
    var
        myInt: Integer;
    begin
        /*
        ExcelBuffer.CreateNewBook('Stock List');
        ExcelBuffer.WriteSheet('Stock List', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Stock List Export');
        ExcelBuffer.OpenExcel();
        */
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
        ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Enddate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.NewRow;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Brand', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Part No', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('IN-TRANSIT', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PUNE', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('WZ-B79', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('NSP', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Reserve', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
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
        Clear(RK);
        Clear(WZ);
        Clear(nsp);
        Clear(Pune);
        Clear(reserv);
        Clear(reserv1);


        ExcelBuffer.NewRow();

        // if Locationcode <> '' then begin
        //  ILE.SetRange("Location Code", Locationcode);

        //  if ILE.FindSet() then begin
        ExcelBuffer.AddColumn("Item Ledger Entry".Brand, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Item Ledger Entry"."No.", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Item Ledger Entry".Description, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ILE.Reset();
        ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
        ILE.SetRange("Posting Date", startdate, Enddate);
        // ILE.SetRange("Location Code", Locationcode);
        ILE.SetFilter("Location Code", 'IN-TRANSIT');
        if ILE.FindSet() then begin
            repeat
                if Locationcode <> '' then begin
                    if Locationcode = 'IN-TRANSIT' then
                        rk += ILE."Remaining Quantity";
                end else
                    rk += ILE."Remaining Quantity";
            until ILE.Next() = 0;
        end;
        ExcelBuffer.AddColumn(RK, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

        ILE.Reset();
        ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
        ILE.SetRange("Posting Date", startdate, Enddate);
        // ILE.SetRange("Location Code", Locationcode);
        ILE.SetFilter("Location Code", 'PUNE');
        if ILE.FindSet() then begin
            repeat
                if Locationcode <> '' then begin
                    if Locationcode = 'Pune' then
                        Pune += ILE."Remaining Quantity";
                end else
                    Pune += ILE."Remaining Quantity";
            until ILE.Next() = 0;
        end;
        ExcelBuffer.AddColumn(Pune, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

        ILE.Reset();
        ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
        ILE.SetRange("Posting Date", startdate, Enddate);
        // ILE.SetRange("Location Code", Locationcode);
        ILE.SetFilter("Location Code", 'WZ');
        if ILE.FindSet() then begin
            repeat
                if Locationcode <> '' then begin
                    if Locationcode = 'WZ' then
                        WZ += ILE."Remaining Quantity";
                end else
                    WZ += ILE."Remaining Quantity";
            until ILE.Next() = 0;
        end;
        ExcelBuffer.AddColumn(WZ, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

        ILE.Reset();
        ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
        ILE.SetRange("Posting Date", startdate, Enddate);
        // ILE.SetRange("Location Code", Locationcode);
        ILE.SetFilter("Location Code", 'NSP');
        if ILE.FindSet() then begin
            repeat
                if Locationcode <> '' then begin
                    if Locationcode = 'NSP' then
                        nsp += ILE."Remaining Quantity";
                end else
                    nsp += ILE."Remaining Quantity";
            until ILE.Next() = 0;
        end;
        ExcelBuffer.AddColumn(nsp, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ILE.Reset();
        ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
        ILE.SetRange("Posting Date", startdate, Enddate);
        // ILE.SetRange("Location Code", Locationcode);
        ILE.SetFilter("Location Code", 'RESERVE');
        if ILE.FindSet() then begin
            repeat
                if Locationcode <> '' then begin
                    if Locationcode = 'RESERVE' then
                        reserv += ILE."Remaining Quantity";
                end else
                    reserv += ILE."Remaining Quantity";
            until ILE.Next() = 0;

        end;
        ExcelBuffer.AddColumn(reserv, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

        ILE.Reset();
        ILE.SetRange("Item No.", "Item Ledger Entry"."No.");
        ILE.SetRange("Posting Date", startdate, Enddate);
        // ILE.SetRange("Location Code", Locationcode);
        ILE.SetFilter("Location Code", 'RESERVE1');
        if ILE.FindSet() then begin
            repeat
                if Locationcode <> '' then begin
                    if Locationcode = 'RESERVE1' then
                        reserv1 += ILE."Remaining Quantity";
                end else
                    reserv1 += ILE."Remaining Quantity";
            until ILE.Next() = 0;
        end;
        ExcelBuffer.AddColumn(reserv1, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(Abs(RK) + Abs(nsp) + Abs(WZ) + Abs(Pune) + Abs(reserv) + Abs(reserv1), false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn(RK + nsp + WZ + Pune + reserv + reserv1, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn("Item Ledger Entry"."Buying Rate (USD)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."Buying Rate (USD)" * (RK + nsp + WZ + Pune + reserv + reserv1), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."Buying Rate (INR)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."Buying Rate (INR)" * (RK + nsp + WZ + Pune + reserv + reserv1), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."SPQ(Std. product Qty)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."MOQ(Minimum order Qty)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."Formula USD", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."Formula INR", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Item Ledger Entry"."Shelf No.", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        //  itemno := "Item Ledger Entry"."Item No.";
        TOtalAMtRK += rk;
        TOtalAMtWZ += WZ;
        TOtalAMtPune += Pune;
        TOtalAMtreserve += reserv;
        TOtalAMtreserve1 += reserv1;
        TOtalAMtNSP += nsp;
        totqty := TOtalAMtNSP + TOtalAMtPune + TOtalAMtreserve + TOtalAMtreserve1 + TOtalAMtRK + TOtalAMtWZ;
        totusdval += "Item Ledger Entry"."Buying Rate (USD)" * (RK + nsp + WZ + Pune + reserv + reserv1);
        totinrval += "Item Ledger Entry"."Buying Rate (INR)" * (RK + nsp + WZ + Pune + reserv + reserv1)
    end;

    //end;

    trigger OnInitReport()
    begin
        ExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        if ExportToExcel = true then
            CreatExcelBook();
    end;

    trigger OnPreReport()
    var
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        ExcelBuffer.DELETEALL
    end;

    var
        ExportToExcel: Boolean;
        startdate: Date;
        myInt: Integer;
        ExcelBuffer: Record "Excel Buffer" temporary;
        RecItem: Record Item;
        CompanyInfo: Record "Company Information";
        Enddate: Date;
        ILE: Record "Item Ledger Entry";
        RK: Decimal;
        WZ: Decimal;
        Pune: Decimal;
        nsp: Decimal;
        reserv: Decimal;
        reserv1: Decimal;
        RK1: Decimal;
        WZ1: Decimal;
        Pune1: Decimal;
        nsp1: Decimal;
        reserv1_1: Decimal;
        reserv1_2: Decimal;
        Bool: Boolean;
        itemno: Code[20];
        TOtalAMtRK: Decimal;
        TOtalAMtWZ: Decimal;
        TOtalAMtPune: Decimal;
        TOtalAMtreserve: Decimal;
        TOtalAMtreserve1: Decimal;
        TOtalAMtIntransit: Decimal;
        TOtalAMtNSP: Decimal;
        totusdval: Decimal;
        totinrval: Decimal;
        totqty: Decimal;
        Locationcode: Code[10];
}
