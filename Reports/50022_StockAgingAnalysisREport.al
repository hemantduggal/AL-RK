report 50022 AgingAnalysisReport
{
    UsageCategory = Administration;
    Caption = 'Stock Ageing Analysis';
    ApplicationArea = all;
    //ProcessingOnly = true;
    //DefaultLayout = RDLC;
    // RDLCLayout = 'ReportLayout\30DReceivableAging.rdl';
    RDLCLayout = 'ReportLayout\StockAging.rdl';
    dataset
    {
        dataitem(Item; Item)
        {


            column(CompanyInfoname; CompanyInfo.Name) { }
            column(CompanyInfoadd; CompanyInfo.Address) { }
            column(CompanyInfoadd2; CompanyInfo."Address 2") { }
            column(startdate; Format(startdate)) { }
            column(ToDate; format(ToDate)) { }

            column(Brand; Brand) { }
            column(Description; Description) { }
            column(Item_Category_Code; "Item Category Code") { }
            column(Unit_Cost; "Unit Cost") { }
            column(Buying_Rate__INR_; "Buying Rate (INR)") { }
            column(Buying_Rate__USD_; "Buying Rate (USD)") { }
            column(TotalQty30; TotalQty30)
            {

            }
            column(TotalQty60; TotalQty60)
            {

            }
            column(TotalQty45; TotalQty45)
            {

            }
            column(TotalQty90; TotalQty90)
            {

            }
            column(TotalQty180; TotalQty180)
            {

            }
            column(TotalQty365; TotalQty365)
            {

            }
            column(TotalQty999; TotalQty999)
            {

            }
            column(TotalQtygreater999; TotalQtygreater999)
            {

            }
            column(Thirty; "0-30")
            {

            }
            column(fourtyfive; "31-45")
            {

            }
            column(sixty; "46-60")
            {

            }
            column(Ninety; "61-90")
            {

            }
            column(oneeighty; "91-180")
            {

            }
            column(threesixtyfive; "181-365")
            {

            }
            column(ninenintynine; "366-999")
            {

            }
            column(greaterninenintynine; ">999")
            {

            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No.");


                ///////////
                column(tQty; tQty)
                { }
                column(TotalQty30_1; TotalQty30_1)
                {

                }
                column(TotalQty60_1; TotalQty60_1)
                {

                }
                column(TotalQty45_1; TotalQty45_1)
                {

                }
                column(TotalQty90_1; TotalQty90_1)
                {

                }
                column(TotalQty180_1; TotalQty180_1)
                {

                }
                column(TotalQty365_1; TotalQty365_1)
                {

                }
                column(TotalQty999_1; TotalQty999_1)
                {

                }
                column(TotalQtygreater999_1; TotalQtygreater999_1)
                {

                }



                column(tot30; tot30) { }
                column(tot45; tot45) { }
                column(tot60; tot60) { }
                column(col1Days; col1Days) { }
                column(col2Days; col2Days) { }
                column(col4Days; col4Days) { }
                column(col3Days; col3Days) { }
                column(col5Days; col5Days) { }
                trigger OnPreDataItem()
                var
                begin

                    "Item Ledger Entry".SetRange("Posting Date", startdate, ToDate);
                end;


                trigger OnAfterGetRecord()
                var

                begin
                    Clear(TotalQty180);
                    Clear(TotalQty30);
                    Clear(TotalQty365);
                    Clear(TotalQty45);
                    Clear(TotalQty90);
                    Clear(TotalQty999);
                    Clear(TotalQtygreater999);
                    Clear(TotalQty60);
                    Clear(TotalQty180_1);
                    Clear(TotalQty30_1);
                    Clear(TotalQty365_1);
                    Clear(TotalQty45_1);
                    Clear(TotalQty90_1);
                    Clear(TotalQty999_1);
                    Clear(TotalQtygreater999_1);
                    Clear(TotalQty60_1);

                    Clear(calculateage);
                    Clear(paymentterm);
                    Clear(tot30);
                    Clear(tot45);
                    Clear(tot60);
                    Clear(col1Days);
                    Clear(col2Days);
                    Clear(col3Days);
                    Clear(col4Days);
                    Clear(col5Days);
                    Clear(col6Days);
                    Clear(startdatedays);
                    Clear(enddatedays);
                    Clear(qty);
                    Clear(tQty);
                    ///////////
                    "Item Ledger Entry".SetRange("Item No.", Item."No.");
                    "Item Ledger Entry".SetRange("Posting Date", startdate, ToDate);
                    if "Item Ledger Entry".FindSet() then begin
                        repeat
                            qty += "Item Ledger Entry"."Remaining Quantity";
                        until "Item Ledger Entry".Next() = 0;
                    end;
                    startdatedays := (startdate - "Item Ledger Entry"."Posting Date");
                    enddatedays := (ToDate - "Item Ledger Entry"."Posting Date");
                    NoOfdays := (ToDate - "Item Ledger Entry"."Posting Date");
                    //Message('%1', NoOfdays);
                    if "0-30" = true then begin
                        if (NoOfdays >= 0) And (NoOfdays <= 30) then
                            tot30 := "Item Ledger Entry"."Remaining Quantity";
                    end;
                    if "31-45" = true then begin
                        if (NoOfdays > 30) And (NoOfdays <= 45) then
                            tot45 := "Item Ledger Entry"."Remaining Quantity";
                    end;
                    if "46-60" = true then begin
                        if (NoOfdays > 45) And (NoOfdays <= 60) then
                            tot60 := "Item Ledger Entry"."Remaining Quantity";
                    end;
                    if "61-90" = true then begin
                        if (NoOfdays > 60) And (NoOfdays <= 90) then
                            col1Days := "Item Ledger Entry"."Remaining Quantity";
                    end;
                    if "91-180" = true then begin
                        if (NoOfdays > 90) And (NoOfdays < 180) then
                            col2Days := "Item Ledger Entry"."Remaining Quantity";
                    end;
                    if "181-365" = true then begin
                        if (NoOfdays > 180) And (NoOfdays < 365) then
                            col3Days := "Item Ledger Entry"."Remaining Quantity";
                    end;
                    if "366-999" = true then begin
                        if (NoOfdays > 365) And (NoOfdays < 999) then
                            col4Days := "Item Ledger Entry"."Remaining Quantity";
                    end;
                    if ">999" = true then begin
                        if (NoOfdays > 999) then
                            col5Days := "Item Ledger Entry"."Remaining Quantity";
                    end;

                    if "0-30" = true then
                        TotalQty30 := abs(tot30);

                    if "31-45" = true then
                        TotalQty45 := abs(tot45);
                    if "46-60" = true then
                        TotalQty60 := abs(tot60);
                    if "61-90" = true then
                        TotalQty90 := abs(col1Days);
                    if "91-180" = true then
                        TotalQty180 := abs(col2Days);
                    if "181-365" = true then
                        TotalQty365 := abs(col3Days);
                    if "366-999" = true then
                        TotalQty999 := abs(col4Days);
                    if ">999" = true then
                        TotalQtygreater999 := abs(col5Days);


                    if "0-30" = true then
                        TotalQty30_1 += abs(tot30);

                    if "31-45" = true then
                        TotalQty45_1 += abs(tot45);
                    if "46-60" = true then
                        TotalQty60_1 += abs(tot60);
                    if "61-90" = true then
                        TotalQty90_1 += abs(col1Days);
                    if "91-180" = true then
                        TotalQty180_1 += abs(col2Days);
                    if "181-365" = true then
                        TotalQty365_1 += abs(col3Days);
                    if "366-999" = true then
                        TotalQty999_1 += abs(col4Days);
                    if ">999" = true then
                        TotalQtygreater999_1 += abs(col5Days);

                    //  if (tot30 + tot45 + tot60 + col1Days + col2Days + col3Days + col4Days + col5Days) = 0 then
                    //      CurrReport.Skip();
                    ExcelBuffer.NewRow();

                    if RecItem.FindFirst() then;
                    ExcelBuffer.AddColumn(Item.Brand, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Item.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Item."Item Category Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(tot30, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(tot45, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(tot60, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(col1Days, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(col2Days, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(col3Days, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(col4Days, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(col5Days, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(tot30 + tot45 + tot60 + col1Days + col2Days + col3Days + col4Days + col5Days, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Item."Unit Cost", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn((tot30 + tot45 + tot60 + col1Days + col2Days + col3Days + col4Days + col5Days) * Item."Unit Cost", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Item."Buying Rate (USD)", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Item."Buying Rate (INR)", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                end;


                trigger OnPostDataItem()
                begin
                    // tQty += TotalQty365 + TotalQty30_1 + TotalQty45_1 + TotalQty60_1 + TotalQty90_1 + TotalQty180_1 + TotalQty999_1 + TotalQtygreater999_1;

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
                group("Date Filter")
                {
                    Caption = 'Date Filters';
                    field(startdate; startdate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field("0-30"; "0-30")
                    {
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field("31-45"; "31-45")
                    {
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field("46-60"; "46-60")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field("61-90"; "61-90")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field("91-180"; "91-180")
                    {
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field("181-365"; "181-365")
                    {
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field("366-999"; "366-999")
                    {
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field(">999"; ">999")
                    {
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        begin

                        end;
                    }
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
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo.Name, FALSE, '', true, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo.Address, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo."Address 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Aging Analysis Report', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ToDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Brand Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Particulars', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty<30', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty<45', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty<60', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty<90', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty<180', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty<365', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty<999', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty>999', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Qty', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Rate', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gross', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INR Price', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INR Gross', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


    end;

    trigger OnPostReport()
    begin
        /*
                ExcelBuffer.CreateNewBook('Stock Aging Report');
                ExcelBuffer.WriteSheet('Stock Aging Report', CompanyName, UserId);
                ExcelBuffer.CloseBook();
                ExcelBuffer.SetFriendlyFilename(StrSubstNo('Stock Aging Report', CurrentDateTime, UserId));
                ExcelBuffer.OpenExcel();
        */
    end;

    var
        tQty: Decimal;
        TotalQty30_1: Decimal;
        TotalQty45_1: Decimal;
        TotalQty60_1: Decimal;
        TotalQty90_1: Decimal;
        TotalQty180_1: Decimal;
        TotalQty365_1: Decimal;
        TotalQty999_1: Decimal;
        TotalQtygreater999_1: Decimal;
        TotalQty30: Decimal;
        TotalQty45: Decimal;
        TotalQty60: Decimal;
        TotalQty90: Decimal;
        TotalQty180: Decimal;
        TotalQty365: Decimal;
        TotalQty999: Decimal;
        TotalQtygreater999: Decimal;
        RecCust: Record "Cust. Ledger Entry";
        ExcelBuffer: Record "Excel Buffer";
        ToDate: Date;
        col1Days: Decimal;
        col2Days: Decimal;
        col3Days: Decimal;
        col4Days: Decimal;
        col5Days: Decimal;
        col6Days: Decimal;
        tot30: Decimal;
        tot45: Decimal;
        tot60: Decimal;
        NoOfdays: Integer;
        CompanyInfo: Record "Company Information";
        TOtalAMt: Decimal;
        TOtalRemainAMt: Decimal;
        TOtalAMt1: Decimal;
        TOtalAMt2: Decimal;
        TOtalAMt3: Decimal;
        TOtalAMt4: Decimal;
        TOtalAMt5: Decimal;
        TOtalAMt6: Decimal;
        TOtalAMtcolwise: Decimal;
        cust: Record Customer;
        Balance: Decimal;
        sih: Record "Sales Invoice Header";
        sCMH: Record "Sales Cr.Memo Header";
        paymentterm: Code[20];
        RSH: Record "Return Shipment Header";
        startdate: Date;
        calculateage: Integer;
        startdatedays: Integer;
        enddatedays: Integer;
        RecItem: Record Item;
        qty: Decimal;
        "0-30": boolean;
        "31-45": boolean;
        "46-60": boolean;
        "61-90": Boolean;
        "91-180": boolean;
        "181-365": boolean;
        "366-999": boolean;
        ">999": boolean;
}