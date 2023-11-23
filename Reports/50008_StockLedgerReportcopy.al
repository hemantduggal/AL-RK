report 50008 "Stock Ledger Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    //  DefaultLayout = RDLC;
    //  RDLCLayout = 'ReportLayout\stockLedger.rdl';
    dataset
    {
        dataitem(Item1; Item)
        {
            RequestFilterFields = "No.", Brand;
            column(No_; "No.")
            {

            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                RequestFilterFields = "Location Code";
                // DataItemLink = "Item No." = field("No.");
                DataItemTableView = sorting("Item No.", "Posting Date");

                trigger OnPreDataItem()
                begin

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

                end;
            }
            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SetRange("Posting Date", strtdate, enddate);
                CreatExcelHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(OpeningStock);
                ILE.Reset();

                ILE.SetFilter("Posting Date", '%1..%2', 0D, strtdate - 1);
                ILE.SetRange("Item No.", Item1."No.");
                if ILE.FindSet() then begin
                    repeat
                        OpeningStock += ILE.Quantity;
                    Until ILE.Next() = 0;
                end;

                CreatExcelBody();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
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
        ExcelBuffer.AddColumn('Document Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Account Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Location', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Brand', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Rate', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('IN Qty', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Out Qty', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Balance Qty', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Age', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('Remarks', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);


    end;

    local procedure CreatExcelBody()
    var
        myInt: Integer;
    begin
        Clear(Name);
        Clear(qty);
        Clear(qty1);
        Clear(remqty);
        Itmno := Item1."No.";
        Clear(unitcost);
        Clear(agedays);

        ExcelBuffer.NewRow();

        // if Itmno <> "Item Ledger Entry"."Item No." then
        bool := false;
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(Item1."No.", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // else
        // ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // Itmno := Item1."No.";
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Opening Stock', false, '', true, false, false, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("openingstock", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // bool := true;
        // end;
        // "Item Ledger Entry".SetRange("Item No.", Item1."No.");
        // if "Item Ledger Entry".FindSet() then begin
        "Item Ledger Entry".SetRange("Item No.", Item1."No.");
        "Item Ledger Entry".SetRange("Posting Date", strtdate, enddate);
        if "Item Ledger Entry".FindSet() then begin
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn("Item Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Item Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::text);

                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::" " then begin
                    if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Negative Adjmt." then
                        ExcelBuffer.AddColumn("Item Ledger Entry"."Entry Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::text);
                    if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Positive Adjmt." then
                        ExcelBuffer.AddColumn("Item Ledger Entry"."Entry Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::text);
                    if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase then
                        ExcelBuffer.AddColumn("Item Ledger Entry"."Entry Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::text);

                end else
                    ExcelBuffer.AddColumn("Item Ledger Entry"."Document Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::text);


                //////new code for name
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Receipt" then begin
                    PPR.Reset();
                    PPR.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if PPR.FindFirst() then begin
                        vend.Reset();
                        if vend.get(PPR."Buy-from Vendor No.") then
                            Name := vend.Name
                        else
                            Name := '';

                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Shipment" then begin
                    SSH.Reset();
                    SSH.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if SSH.FindFirst() then begin
                        cust.Reset();
                        if cust.get(SSH."Sell-to Customer No.") then
                            Name := cust.Name
                        else
                            Name := '';
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Positive Adjmt." then begin
                    if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::" " then begin
                        Name := '';
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Negative Adjmt." then begin
                    if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::" " then begin
                        Name := '';
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Credit Memo" then begin
                    pcmemo.Reset();
                    pcmemo.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if pcmemo.FindFirst() then begin
                        vend.Reset();
                        if vend.get(pcmemo."Buy-from Vendor No.") then
                            Name := vend.Name
                        else
                            Name := '';
                    end;
                end;

                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Invoice" then begin
                    pih.Reset();
                    pih.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if pih.FindFirst() then begin
                        vend.Reset();
                        if vend.get(pih."Buy-from Vendor No.") then
                            Name := vend.Name
                        else
                            Name := '';
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Invoice" then begin
                    sih.Reset();
                    sih.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if sih.FindFirst() then begin
                        cust.Reset();
                        if cust.get(sih."Sell-to Customer No.") then
                            Name := cust.Name
                        else
                            Name := '';
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Return Shipment" then begin
                    prsh.Reset();
                    prsh.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if prsh.FindFirst() then begin
                        vend.Reset();
                        if vend.get(prsh."Buy-from Vendor No.") then
                            Name := vend.Name
                        else
                            Name := '';
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Credit Memo" then begin
                    scmo.Reset();
                    scmo.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if scmo.FindFirst() then begin
                        vend.Reset();
                        if cust.get(scmo."Sell-to Customer No.") then
                            Name := cust.Name
                        else
                            Name := '';
                    end;
                end;
                /// 


                ExcelBuffer.AddColumn(Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ///////////////////////////
                ExcelBuffer.AddColumn("Item Ledger Entry"."Location Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                item.Reset();
                if item.Get("Item Ledger Entry"."Item No.") then;
                ExcelBuffer.AddColumn(item.Brand, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Receipt" then begin
                    PPR.Reset();
                    PPR.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if PPR.FindFirst() then begin
                        PPRL.Reset();
                        PPRL.SetRange("Document No.", PPR."No.");
                        PPRL.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if PPRL.FindFirst() then
                            unitcost := PPRL."Unit Cost";
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Shipment" then begin
                    SSH.Reset();
                    SSH.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if SSH.FindFirst() then begin
                        SSL.Reset();
                        SSL.SetRange("Document No.", SSH."No.");
                        SSL.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if SSL.FindFirst() then
                            unitcost := SSL."Unit Cost"
                        else
                            unitcost := 0;
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Credit Memo" then begin
                    pcmemo.Reset();
                    pcmemo.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if pcmemo.FindFirst() then begin
                        pcmemol.Reset();
                        pcmemol.SetRange("Document No.", pcmemo."No.");
                        pcmemol.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if pcmemol.FindFirst() then
                            unitcost := pcmemol."Unit Cost"
                        else
                            unitcost := 0;
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Invoice" then begin
                    pih.Reset();
                    pih.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if pih.FindFirst() then begin
                        pil.Reset();
                        pil.SetRange("Document No.", pih."No.");
                        pil.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if pil.FindFirst() then
                            unitcost := pil."Unit Cost"
                        else
                            unitcost := 0;
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Invoice" then begin
                    sih.Reset();
                    sih.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if sih.FindFirst() then begin
                        sil.Reset();
                        sil.SetRange("Document No.", sih."No.");
                        sil.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if sil.FindFirst() then
                            unitcost := sil."Unit Cost"
                        else
                            unitcost := 0;
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Transfer Shipment" then begin
                    tsh.Reset();
                    tsh.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if tsh.FindFirst() then begin
                        tsl.Reset();
                        tsl.SetRange("Document No.", tsh."No.");
                        tsl.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                        if tsl.FindFirst() then
                            unitcost := tsl."Unit Price"
                        else
                            unitcost := 0;
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Transfer Receipt" then begin
                    trh.Reset();
                    trh.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if trh.FindFirst() then begin
                        trl.Reset();
                        trl.SetRange("Document No.", trh."No.");
                        trl.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                        if trl.FindFirst() then
                            unitcost := trl."Unit Price"
                        else
                            unitcost := 0;
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Return Shipment" then begin
                    prsh.Reset();
                    prsh.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if prsh.FindFirst() then begin
                        prsl.Reset();
                        prsl.SetRange("Document No.", prsh."No.");
                        prsl.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if prsl.FindFirst() then
                            unitcost := prsl."Unit Cost"
                        else
                            unitcost := 0;
                    end;
                end;
                if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Credit Memo" then begin
                    scmo.Reset();
                    scmo.SetRange("No.", "Item Ledger Entry"."Document No.");
                    if scmo.FindFirst() then begin
                        scml.Reset();
                        scml.SetRange("Document No.", scmo."No.");
                        scml.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if scml.FindFirst() then
                            unitcost := scml."Unit Cost"
                        else
                            unitcost := 0;
                    end;
                end;

                ExcelBuffer.AddColumn(unitcost, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);

                ///qty calculation
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::Purchase] then begin
                    if "Item Ledger Entry"."Document Type" IN ["Item Ledger Entry"."Document Type"::"Purchase Credit Memo", "Item Ledger Entry"."Document Type"::"Purchase Invoice", "Item Ledger Entry"."Document Type"::"Purchase Receipt"] then begin
                        if "Item Ledger Entry".Quantity > 0 then begin
                            qty := "Item Ledger Entry".Quantity;
                            qty1 := 0;
                        end else begin
                            qty := 0;
                            qty1 := "Item Ledger Entry".Quantity;
                        END;
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::Sale] then begin
                    if "Item Ledger Entry"."Document Type" IN ["Item Ledger Entry"."Document Type"::"Sales Credit Memo", "Item Ledger Entry"."Document Type"::"Sales Invoice", "Item Ledger Entry"."Document Type"::"Sales Shipment"] then begin
                        qty1 := "Item Ledger Entry".Quantity;
                        qty := 0;
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::Transfer] then begin
                    if "Item Ledger Entry"."Document Type" IN ["Item Ledger Entry"."Document Type"::"Transfer Shipment"] then begin

                        if "Item Ledger Entry".Quantity > 0 then begin
                            qty := "Item Ledger Entry".Quantity;
                            qty1 := 0;
                        end;
                        if "Item Ledger Entry".Quantity < 0 then begin
                            qty1 := "Item Ledger Entry".Quantity;
                            qty := 0;
                        end;
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::Transfer] then begin
                    if "Item Ledger Entry"."Document Type" IN ["Item Ledger Entry"."Document Type"::"Transfer Receipt"] then begin

                        if "Item Ledger Entry".Quantity > 0 then begin
                            qty := "Item Ledger Entry".Quantity;
                            qty1 := 0;
                        end;
                        if "Item Ledger Entry".Quantity < 0 then begin
                            qty1 := "Item Ledger Entry".Quantity;
                            qty := 0;
                        end;
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::Sale] then begin
                    if "Item Ledger Entry"."Document Type" IN ["Item Ledger Entry"."Document Type"::"Sales Return Receipt"] then begin
                        //  if "Item Ledger Entry".Quantity > 0 then
                        qty := "Item Ledger Entry".Quantity;
                        // else
                        qty1 := 0;
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::Purchase] then begin
                    if "Item Ledger Entry"."Document Type" IN ["Item Ledger Entry"."Document Type"::"Purchase Return Shipment"] then begin

                        qty := 0;

                        qty1 := "Item Ledger Entry".Quantity;
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::Purchase] then begin
                    if "Item Ledger Entry"."Document Type" IN ["Item Ledger Entry"."Document Type"::" "] then begin

                        qty1 := 0;

                        qty := "Item Ledger Entry".Quantity;
                    end;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::"Positive Adjmt."] then begin
                    qty1 := 0;

                    qty := "Item Ledger Entry".Quantity;
                end;
                if "Item Ledger Entry"."Entry Type" IN ["Item Ledger Entry"."Entry Type"::"Negative Adjmt."] then begin
                    qty := 0;

                    qty1 := "Item Ledger Entry".Quantity;
                end;
                if bool = false then
                    remqty := remqty + qty + qty1 + OpeningStock
                else
                    remqty := remqty + qty + qty1;
                bool := true;
                ExcelBuffer.AddColumn(qty, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(ABS(qty1), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);

                if remqty = 0 then
                    CurrReport.Skip();
                ExcelBuffer.AddColumn(remqty, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                agedays := (enddate - "Item Ledger Entry"."Posting Date");
                ExcelBuffer.AddColumn(agedays, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.NewRow();

            until "Item Ledger Entry".Next() = 0;
        end else
            CurrReport.Skip();
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
        qty1: Decimal;
        remqty1: Decimal;
        qty: Decimal;
        remqty: Decimal;
        ILE1: Record "Item Ledger Entry";
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
        ILE: Record "Item Ledger Entry";
        Name: Text[100];
        pcmemo: Record "Purch. Cr. Memo Hdr.";
        pih: Record "Purch. Inv. Header";
        sih: Record "Sales Invoice Header";
        tsh: Record "Transfer Shipment Header";
        trh: Record "Transfer Receipt Header";
        prsh: Record "Return Shipment Header";
        prrh: Record "Return Receipt Header";
        scmo: Record "Sales Cr.Memo Header";
        unitcost: Decimal;
        pcmemol: Record "Purch. Cr. Memo Line";
        pil: Record "Purch. Inv. Line";
        sil: Record "Sales Invoice Line";
        tsl: Record "Transfer Shipment Line";
        trl: Record "Transfer Receipt Line";
        prsl: Record "Return Shipment Line";
        prrl: Record "Return Receipt Line";
        scml: Record "Sales Cr.Memo Line";
        agedays: Integer;
}