report 50025 StockMovement
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Stock Movement Report';
    // ProcessingOnly = true;
    RDLCLayout = 'ReportLayout\stockMovement.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(Item_No_; "No.")
            {

            }
            column(RecItemdesc; Description) { }
            column(Search_Description; "Search Description")
            {

            }
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(startdate; format(startdate)) { }
            column(Enddate; Format(Enddate)) { }
            column(Brand; Brand) { }

            column(OpenQty; OpenQty) { }
            column(OpenAmt; OpenAmt) { }
            column(totpurchReturnQty; totpurchReturnQty) { }
            column(RecvAmt; RecvAmt) { }
            column(totSalereturnQty; totSalereturnQty) { }
            column(IssueAmt; IssueAmt) { }
            column(totbalqty; totbalqty) { }
            column(totbalamt; totbalamt) { }

            column(CompanyName; CompanyInfo.Name)
            {

            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                // RequestFilterFields = "Item No.";
                DataItemLink = "Item No." = field("No.");

                /*
                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", startdate, Enddate);
                    Makeheader();
                end;

                trigger OnAfterGetRecord()
                var

                Begin


                    MakeBody();
                end;
                */
            }
            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SetRange("Posting Date", startdate, Enddate);
                Makeheader();
            end;

            trigger OnAfterGetRecord()
            var

            Begin

                // MakeBody();
                begin
                    Clear(totbalqty);
                    Clear(totbalamt);
                    Clear(purchReturnQty);
                    Clear(SalereturnQty);
                    Clear(totpurchReturnQty);
                    Clear(totSalereturnQty);
                    Clear(PRQty);
                    Clear(SRQty);
                    ////Opening
                    Clear(OpenQty);
                    clear(OpenAmt);
                    Clear(count1);
                    ILE.Reset();
                    ILE.SetRange(ILE."Item No.", Item."No.");
                    ILE.SetFilter(ILE."Posting Date", '%1..%2', 0D, startdate - 1);
                    if ILE.FindSet() then begin
                        repeat
                            ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                            // ILE.CalcSums(ILE.Quantity);

                            OpenQty += ILE.Quantity;
                            OpenAmt += ILE."Cost Amount (Expected)" + ILE."Cost Amount (Actual)";
                        until ile.Next() = 0;
                    end;
                    ////Within Period
                    clear(QtyPeriod);
                    clear(AmtPeriod);
                    Clear(BalAmt);
                    Clear(BalQty);
                    clear(RecvQty);
                    Clear(RecvAmt);
                    clear(IssueQty);
                    Clear(IssueAmt);

                    ILE.Reset();
                    ILE.SetRange(ILE."Item No.", Item."No.");
                    ILE.SetRange(ILE."Posting Date", startdate, Enddate);
                    ile.SetFilter("Entry Type", '%1', ile."Entry Type"::Purchase);
                    if ILE.FindSet() then begin
                        repeat
                            count1 := ile.Count;
                            ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                            // ILE.CalcSums(ILE.Quantity);
                            QtyPeriod += ILE.Quantity;
                            AmtPeriod += ILE."Cost Amount (Actual)";
                        until ile.Next() = 0;
                    end;
                    ///balance
                    BalQty := OpenQty + QtyPeriod;
                    // BalAmt := OpenAmt + AmtPeriod;
                    BalAmt := AmtPeriod / count1;
                    ////Received 
                    if BalQty = 0 then
                        CurrReport.Skip();

                    ILE.Reset();
                    ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase);
                    //ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
                    ILE.SetRange("Document Type", ile."Document Type"::"Purchase Receipt");
                    ile.SetRange("Item No.", Item."No.");
                    ILE.SetRange(ILE."Posting Date", startdate, Enddate);
                    if ILE.FindSet() then begin
                        repeat
                            ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                            // ILE.CalcSums(ILE.Quantity);

                            RecvQty += ILE.Quantity;
                            RecvAmt += ile."Cost Amount (Actual)";  //ILE."Cost Amount (Expected)" + ILE."Cost Amount (Actual)";
                        until ile.Next() = 0;
                    end;
                    ILE.Reset();
                    ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase);
                    //ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
                    ILE.SetRange("Document Type", ile."Document Type"::"Purchase Return Shipment");
                    ile.SetRange("Item No.", Item."No.");
                    ILE.SetRange(ILE."Posting Date", startdate, Enddate);
                    if ILE.FindSet() then begin
                        repeat
                            ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                            // ILE.CalcSums(ILE.Quantity);

                            PRQty += ILE.Quantity;
                        until ile.Next() = 0;
                    end;
                    totpurchReturnQty := RecvQty + PRQty;
                    ////Issue 

                    ILE.Reset();
                    ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Sale);
                    // ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
                    ILE.SetRange("Document Type", ile."Document Type"::"Sales Shipment");
                    ile.SetRange("Item No.", Item."No.");
                    ILE.SetRange(ILE."Posting Date", startdate, Enddate);
                    if ILE.FindSet() then begin
                        repeat
                            ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)");
                            //  ILE.CalcSums(ILE.Quantity);

                            IssueQty += ILE.Quantity;
                            IssueAmt += ile."Sales Amount (Actual)";  //ILE."Cost Amount (Expected)" + ILE."Cost Amount (Actual)";
                        until ile.Next() = 0;
                    end;
                    ILE.Reset();
                    ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Sale);
                    //ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
                    ILE.SetRange("Document Type", ile."Document Type"::"Sales Return Receipt");
                    ile.SetRange("Item No.", Item."No.");
                    ILE.SetRange(ILE."Posting Date", startdate, Enddate);
                    if ILE.FindSet() then begin
                        repeat
                            ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                            // ILE.CalcSums(ILE.Quantity);

                            SRQty += ILE.Quantity;
                        until ile.Next() = 0;
                    end;
                    totSalereturnQty := abs(IssueQty) - abs(SRQty);
                    totbalqty := BalQty - totSalereturnQty;
                    totbalamt := totbalqty * BalAmt;

                    ExcelBuffer.NewRow;
                    RecItem.Reset();
                    RecItem.SetRange("No.", Item."No.");
                    if RecItem.FindFirst() then;
                    ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
                    ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(OpenQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(OpenAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    // ExcelBuffer.AddColumn(RecvQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(totpurchReturnQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                    ExcelBuffer.AddColumn(RecvAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(IssueQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
                    ExcelBuffer.AddColumn(totSalereturnQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(IssueAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
                    ExcelBuffer.AddColumn(totbalqty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(totbalamt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

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
        /*
        ExcelBuffer.CreateNewBook('Stock Movement');
        ExcelBuffer.WriteSheet('Stock Movement Sheet', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Stock Movement', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        */
    end;

    var
        CompanyInfo: Record "Company Information";
        ExcelBuffer: Record "Excel Buffer";
        startdate: date;
        Enddate: date;

        IssueQty: Decimal;
        IssueAmt: Decimal;
        RecvQty: Decimal;
        RecvAmt: Decimal;
        QtyPeriod: Decimal;
        AmtPeriod: Decimal;
        BalQty: Decimal;
        BalAmt: Decimal;
        ile: Record "Item Ledger Entry";
        OpenQty: Decimal;
        OpenAmt: Decimal;
        RecItem: Record Item;
        count1: Integer;
        PRQty: Decimal;
        SRQty: Decimal;
        purchReturnQty: Decimal;
        SalereturnQty: Decimal;
        totpurchReturnQty: Decimal;
        totSalereturnQty: Decimal;
        totbalamt: Decimal;
        totbalqty: Decimal;

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
        ExcelBuffer.AddColumn('Stock Movement', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(startdate, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(Enddate, false, '', true, false, true, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.NewRow;

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Brand Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Op Balance Qty', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Op Balance Value', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Recvd Qty', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Recvd Qty Value', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Issued Qty', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Issued Qty Value', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance Qty', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance Stock Value.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;
    /*
        local procedure MakeBody()
        var
            myInt: Integer;
        begin
            Clear(totbalqty);
            Clear(totbalamt);
            Clear(purchReturnQty);
            Clear(SalereturnQty);
            Clear(totpurchReturnQty);
            Clear(totSalereturnQty);
            Clear(PRQty);
            Clear(SRQty);
            ////Opening
            Clear(OpenQty);
            clear(OpenAmt);
            Clear(count1);
            ILE.Reset();
            ILE.SetRange(ILE."Item No.", Item."No.");
            ILE.SetFilter(ILE."Posting Date", '%1..%2', 0D, startdate - 1);
            if ILE.FindSet() then begin
                repeat
                    ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                    // ILE.CalcSums(ILE.Quantity);

                    OpenQty += ILE.Quantity;
                    OpenAmt += ILE."Cost Amount (Expected)" + ILE."Cost Amount (Actual)";
                until ile.Next() = 0;
            end;
            ////Within Period
            clear(QtyPeriod);
            clear(AmtPeriod);
            Clear(BalAmt);
            Clear(BalQty);
            clear(RecvQty);
            Clear(RecvAmt);
            clear(IssueQty);
            Clear(IssueAmt);

            ILE.Reset();
            ILE.SetRange(ILE."Item No.", Item."No.");
            ILE.SetRange(ILE."Posting Date", startdate, Enddate);
            ile.SetFilter("Entry Type", '%1', ile."Entry Type"::Purchase);
            if ILE.FindSet() then begin
                repeat
                    count1 := ile.Count;
                    ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                    // ILE.CalcSums(ILE.Quantity);
                    QtyPeriod += ILE.Quantity;
                    AmtPeriod += ILE."Cost Amount (Actual)";
                until ile.Next() = 0;
            end;
            ///balance
            BalQty := OpenQty + QtyPeriod;
            // BalAmt := OpenAmt + AmtPeriod;
            BalAmt := AmtPeriod / count1;
            ////Received 
            if BalQty = 0 then
                CurrReport.Skip();

            ILE.Reset();
            ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase);
            //ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
            ILE.SetRange("Document Type", ile."Document Type"::"Purchase Receipt");
            ile.SetRange("Item No.", Item."No.");
            ILE.SetRange(ILE."Posting Date", startdate, Enddate);
            if ILE.FindSet() then begin
                repeat
                    ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                    // ILE.CalcSums(ILE.Quantity);

                    RecvQty += ILE.Quantity;
                    RecvAmt += ile."Cost Amount (Actual)";  //ILE."Cost Amount (Expected)" + ILE."Cost Amount (Actual)";
                until ile.Next() = 0;
            end;
            ILE.Reset();
            ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase);
            //ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
            ILE.SetRange("Document Type", ile."Document Type"::"Purchase Return Shipment");
            ile.SetRange("Item No.", Item."No.");
            ILE.SetRange(ILE."Posting Date", startdate, Enddate);
            if ILE.FindSet() then begin
                repeat
                    ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                    // ILE.CalcSums(ILE.Quantity);

                    PRQty += ILE.Quantity;
                until ile.Next() = 0;
            end;
            totpurchReturnQty := RecvQty + PRQty;
            ////Issue 

            ILE.Reset();
            ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Sale);
            // ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
            ILE.SetRange("Document Type", ile."Document Type"::"Sales Shipment");
            ile.SetRange("Item No.", Item."No.");
            ILE.SetRange(ILE."Posting Date", startdate, Enddate);
            if ILE.FindSet() then begin
                repeat
                    ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)");
                    //  ILE.CalcSums(ILE.Quantity);

                    IssueQty += ILE.Quantity;
                    IssueAmt += ile."Sales Amount (Actual)";  //ILE."Cost Amount (Expected)" + ILE."Cost Amount (Actual)";
                until ile.Next() = 0;
            end;
            ILE.Reset();
            ile.SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Sale);
            //ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
            ILE.SetRange("Document Type", ile."Document Type"::"Sales Return Receipt");
            ile.SetRange("Item No.", Item."No.");
            ILE.SetRange(ILE."Posting Date", startdate, Enddate);
            if ILE.FindSet() then begin
                repeat
                    ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                    // ILE.CalcSums(ILE.Quantity);

                    SRQty += ILE.Quantity;
                until ile.Next() = 0;
            end;
            totSalereturnQty := abs(IssueQty) - abs(SRQty);
            totbalqty := BalQty - totSalereturnQty;
            totbalamt := totbalqty * BalAmt;

            ExcelBuffer.NewRow;
            RecItem.Reset();
            RecItem.SetRange("No.", Item."No.");
            if RecItem.FindFirst() then;
            ExcelBuffer.AddColumn(RecItem.Brand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
            ExcelBuffer.AddColumn(RecItem.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(OpenQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(OpenAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            // ExcelBuffer.AddColumn(RecvQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(totpurchReturnQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

            ExcelBuffer.AddColumn(RecvAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            // ExcelBuffer.AddColumn(IssueQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
            ExcelBuffer.AddColumn(totSalereturnQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(IssueAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
            ExcelBuffer.AddColumn(totbalqty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(totbalamt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

        end;
        */
}