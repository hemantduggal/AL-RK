report 50022 AgingAnalysisReport
{
    UsageCategory = Administration;
    Caption = 'Aging Analysis';
    ApplicationArea = all;
    ProcessingOnly = true;
    //DefaultLayout = RDLC;
    // RDLCLayout = 'ReportLayout\30DReceivableAging.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No.");
                trigger OnPreDataItem()
                var
                begin

                    "Item Ledger Entry".SetRange("Posting Date", startdate, ToDate);
                end;


                trigger OnAfterGetRecord()
                var

                begin
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
                    /*
                                        if (NoOfdays >= 0) And (NoOfdays <= 30) then
                                            tot30 := "Item Ledger Entry"."Remaining Quantity";
                                        if (NoOfdays > 30) And (NoOfdays <= 45) then
                                            tot45 := "Item Ledger Entry"."Remaining Quantity";
                                        if (NoOfdays > 45) And (NoOfdays <= 60) then
                                            tot60 := "Item Ledger Entry"."Remaining Quantity";
                                        if (NoOfdays > 60) And (NoOfdays <= 90) then
                                            col1Days := "Item Ledger Entry"."Remaining Quantity";
                                        if (NoOfdays > 90) And (NoOfdays < 180) then
                                            col2Days := "Item Ledger Entry"."Remaining Quantity";
                                        if (NoOfdays > 180) And (NoOfdays < 365) then
                                            col3Days := "Item Ledger Entry"."Remaining Quantity";
                                        if (NoOfdays > 365) And (NoOfdays < 999) then
                                            col4Days := "Item Ledger Entry"."Remaining Quantity";
                                        if (NoOfdays > 999) then
                                            col5Days := "Item Ledger Entry"."Remaining Quantity";
                    */
                    //Message('%1', NoOfdays);
                    if (qty >= 0) And (qty <= 30) then
                        tot30 := qty;
                    if (qty > 30) And (qty <= 45) then
                        tot45 := qty;
                    if (qty > 45) And (qty <= 60) then
                        tot60 := qty;
                    if (qty > 60) And (qty <= 90) then
                        col1Days := qty;
                    if (qty > 90) And (qty < 180) then
                        col2Days := qty;
                    if (qty > 180) And (qty < 365) then
                        col3Days := qty;
                    if (qty > 365) And (qty < 999) then
                        col4Days := qty;
                    if (qty > 999) then
                        col5Days := qty;

                    if (tot30 + tot45 + tot60 + col1Days + col2Days + col3Days + col4Days + col5Days) = 0 then
                        CurrReport.Skip();
                    ExcelBuffer.NewRow();

                    if RecItem.FindFirst() then;
                    ExcelBuffer.AddColumn(Item.Brand, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Item.Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Item.Type, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
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

        ExcelBuffer.CreateNewBook('customer Aging Report');
        ExcelBuffer.WriteSheet('Customer Aging Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Customer Aging Report', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();

    end;

    var
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
}