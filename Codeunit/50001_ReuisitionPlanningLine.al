codeunit 50001 "Reuisition Plan Line"
{

    procedure CalculateReqPlanLine(LocCode: Code[20]; DepartmentCode: code[30])
    var
        IndentLine: Record "Requisition Lines";
        IndentTemLine: Record "Requisition Planning Lines";
        PurchaseIndentPlanning: Page "Requisition Planning Lines";
        IndentH: Record "Requisition Header";
        ItemRec: Record Item;
    begin
        IndentTemLine.DeleteAll();
        if DepartmentCode = '' then
            Error('User Code must have a value');
        IndentLine.Reset();
        if LocCode <> '' then
            IndentLine.SetRange("Location Code", LocCode);
        IndentLine.SetRange("User ID", DepartmentCode);
        if IndentLine.FindFirst() then
            repeat
                if IndentH.Get(IndentLine."Requisition No.") then begin
                    if IndentLine.Quantity <> 0 then begin
                        IndentTemLine.Init();
                        IndentTemLine.TransferFields(IndentLine);
                        if ItemRec.Get(IndentTemLine."Item No.") then
                            IndentTemLine.Description := ItemRec.Description;
                        IndentTemLine.Insert();
                    end;
                END;
            until IndentLine.Next() = 0;
        // PurchaseIndentPlanning.Run();
    end;

    procedure CreatePurchaseQuote()
    var
        PurchOrderHeader: Record 38;
        PurchOrderHeader1: Record 38;
        CategoryType: Code[20];
        VendorCode: Code[50];
        LocationRec: Code[10];
        VendorRec: Record Vendor;
        LoRec: Record 14;
        IndentL: Record "Requisition Planning Lines";
    begin
        IndentL.Reset();
        IndentL.SetCurrentKey("Requisition No.", "Location Code");
        IndentL.SetRange(IndentL."Replenishment Type", IndentL."Replenishment Type"::"Purchase Quote");
        // IndentL.SetRange(IndentL.Select, true);
        if IndentL.FindFirst() then begin
            repeat
                if VendorRec.Get(IndentL."Vendor No.") then;
                if (VendorCode <> IndentL."Vendor No.") then begin
                    // Or (LocationRec <> IndentL."Location Code") then begin
                    PurchOrderHeader.Init;
                    PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Quote;
                    PurchOrderHeader."No." := '';
                    PurchOrderHeader."Posting Date" := IndentL."Posting Date";
                    PurchOrderHeader.Insert(true);
                    PurchOrderHeader."Your Reference" := IndentL."Requisition No.";
                    PurchOrderHeader."Order Date" := Today;
                    PurchOrderHeader."Requisition No." := IndentL."Requisition No.";
                    PurchOrderHeader.Validate("Buy-from Vendor No.", "IndentL"."Vendor No.");
                    PurchOrderHeader.Validate("Location Code", IndentL."Location Code");
                    PurchOrderHeader.Validate("Shortcut Dimension 1 Code", IndentL."Shortcut Dimenssion 1");
                    PurchOrderHeader.Validate("Shortcut Dimension 2 Code", IndentL."Shortcut Dimenssion 2");
                    PurchOrderHeader.Modify();
                    VendorCode := IndentL."Vendor No.";
                    //   LocationRec := IndentL."Location Code";
                    InsertPurchLine(PurchOrderHeader, IndentL);
                END else
                    InsertPurchLine(PurchOrderHeader, IndentL);
            until IndentL.Next = 0;
            Message('Purchase Quote has been created successfully %1', PurchOrderHeader."No.");
        END;
    END;

    local procedure InsertPurchLine(PurchOrderHeader: Record 38; IndentRecL: Record "Requisition Planning Lines")
    var
        PurchOrderLine: Record 39;
        NextLineNo: Integer;
        PurchOrderLine1: Record 39;
        PurchCommentLine: Record "Purch. Comment Line";
        IndentLine: Record "Requisition Lines";
    begin
        PurchOrderLine1.Reset();
        PurchOrderLine1.SetRange("Document Type", PurchOrderHeader."Document Type");
        PurchOrderLine1.SetRange("Document No.", PurchOrderHeader."No.");
        if PurchOrderLine1.FindLast() then
            NextLineNo := PurchOrderLine1."Line No."
        else
            NextLineNo := 0;
        //    with IndentRecL do begin
        PurchOrderLine.Init;
        PurchOrderLine.BlockDynamicTracking(true);
        PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
        PurchOrderLine."Document No." := PurchOrderHeader."No.";
        NextLineNo := NextLineNo + 10000;
        PurchOrderLine."Line No." := NextLineNo;
        PurchOrderLine.Insert();
        PurchOrderLine.Validate("Buy-from Vendor No.", IndentRecL."Vendor No.");
        if IndentRecL.Type = IndentRecL.Type::FA then
            PurchOrderLine.Validate(Type, PurchOrderLine.Type::"Fixed Asset")
        else
            if IndentRecL.Type = IndentRecL.Type::Item then
                PurchOrderLine.Validate(Type, PurchOrderLine.Type::Item);
        PurchOrderLine.Validate("No.", IndentRecL."Item No.");
        PurchOrderLine.Description := IndentRecL.Description;
        PurchOrderLine."Description 2" := IndentRecL.Description;
        PurchOrderLine.Validate("Location Code", IndentRecL."Location Code");
        //  PurchOrderLine.Validate("Unit of Measure Code", IndentRecL.uo);
        PurchOrderLine.Validate(Quantity, IndentRecL.Quantity);
        PurchOrderLine.Validate("Shortcut Dimension 1 Code", IndentRecL."Shortcut Dimenssion 1");
        PurchOrderLine.Validate("Shortcut Dimension 2 Code", IndentRecL."Shortcut Dimenssion 2");

        PurchOrderLine."Requisition No." := IndentRecL."Requisition No.";
        PurchOrderLine."Requisition Line No." := IndentRecL."Line No.";
        PurchOrderLine.POP := IndentRecL.POP;
        PurchOrderLine.BQ := IndentRecL.BQ;
        PurchOrderLine.LT := IndentRecL.LT;
        PurchOrderLine.SPQ := IndentRecL.SPQ;
        PurchOrderLine."Direct Unit Cost" := IndentRecL."Direct unit Cost";
        PurchOrderLine.MOQ := IndentRecL.MOQ;
        PurchOrderLine.Modify();
        if PurchOrderHeader."Document Type" IN [PurchOrderHeader."Document Type"::Order, PurchOrderHeader."Document Type"::Quote,
        PurchOrderHeader."Document Type"::"Blanket Order"] then begin
            IndentLine.Reset();
            IndentLine.SetRange("Requisition No.", IndentRecL."Requisition No.");
            IndentLine.SetRange("Line No.", IndentRecL."Line No.");
            if IndentLine.FindFirst() then begin
                // IndentLine."Outstanding Qty (Base)" := IndentLine."Outstanding Qty (Base)" - IndentRecL.Quantity;
                if PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Order then
                    IndentLine.Status := IndentLine.Status::"PO Created";
                IndentLine.Modify();
            end;
        END;
    end;



    procedure CreatePurchaseOrder()
    var
        PurchOrderHeader: Record 38;
        PurchOrderHeader1: Record 38;
        CategoryType: Code[20];
        VendorCode: Code[50];
        LocationRec: Code[10];
        VendorRec: Record Vendor;
        LoRec: Record 14;
        IndentL: Record "Requisition Planning Lines";
        NoSeriesMange: Codeunit NoSeriesManagement;
    begin
        Clear(VendorCode);
        Clear(LocationRec);
        IndentL.Reset();
        IndentL.SetCurrentKey("Requisition No.", "Vendor No.", "Location Code");
        IndentL.SetRange(IndentL."Replenishment Type", IndentL."Replenishment Type"::"Purchase Order");
        // IndentL.SetRange(IndentL.Select, true);
        if IndentL.FindFirst() then begin
            repeat
                Clear(NoSeriesMange);
                if VendorRec.Get(IndentL."Vendor No.") then;
                if (VendorCode <> IndentL."Vendor No.") then begin
                    //    Or (LocationRec <> IndentL."Location Code") then begin
                    /*
                PurchOrderHeader.Init;
                PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Order;
                PurchOrderHeader."No." := NoSeriesMange.GetNextNo3(PurchOrderHeader."No. Series", Today, true, false);
                PurchOrderHeader."Posting Date" := IndentL."Posting Date";
                PurchOrderHeader.Insert(true);
                */
                    // PurchOrderHeader."Your Reference" := IndentL."Indent No";
                    PurchOrderHeader.Init;
                    PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Order;
                    PurchOrderHeader."No." := '';
                    PurchOrderHeader."Posting Date" := IndentL."Posting Date";
                    PurchOrderHeader.Insert(true);
                    PurchOrderHeader."Order Date" := IndentL."Posting Date";
                    PurchOrderHeader."Expected Receipt Date" := IndentL."Posting Date";
                    PurchOrderHeader.Validate("Buy-from Vendor No.", "IndentL"."Vendor No.");
                    PurchOrderHeader.Validate("Location Code", IndentL."Location Code");
                    // PurchOrderHeader.Validate("Purchaser Code", IndentL."Purchase Code");
                    PurchOrderHeader.Validate("Shortcut Dimension 1 Code", IndentL."Shortcut Dimenssion 1");
                    PurchOrderHeader.Validate("Shortcut Dimension 2 Code", IndentL."Shortcut Dimenssion 2");
                    PurchOrderHeader.Modify();
                    VendorCode := IndentL."Vendor No.";
                    //      LocationRec := IndentL."Location Code";
                    InsertPurchLine(PurchOrderHeader, IndentL);
                END else
                    InsertPurchLine(PurchOrderHeader, IndentL);
            //      IndentL.Delete();
            until IndentL.Next = 0;
            Message('Purchase Order has been created successfully %1', PurchOrderHeader."No.");
        end;
    END;


    procedure CreateBlanketOrder()
    var
        PurchOrderHeader: Record 38;
        PurchOrderHeader1: Record 38;
        CategoryType: Code[20];
        VendorCode: Code[50];
        LocationRec: Code[10];
        VendorRec: Record Vendor;
        LoRec: Record 14;
        IndentL: Record "Requisition Planning Lines";
    begin
        IndentL.Reset();
        IndentL.SetCurrentKey("Requisition No.", "Vendor No.", "Location Code");
        IndentL.SetRange(IndentL."Replenishment Type", IndentL."Replenishment Type"::"Blanket Order");
        // IndentL.SetRange(IndentL.Select, true);
        if IndentL.FindFirst() then begin
            repeat
                if VendorRec.Get(IndentL."Vendor No.") then;
                if (VendorCode <> IndentL."Vendor No.") then begin
                    // Or (LocationRec <> IndentL."Location Code") then begin
                    /*
                PurchOrderHeader.Init;
                PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::"Blanket Order";
                PurchOrderHeader."No." := '';
                PurchOrderHeader."Posting Date" := IndentL."Posting Date";
                PurchOrderHeader.Insert(true);
                */
                    PurchOrderHeader.Init;
                    PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::"Blanket Order";
                    PurchOrderHeader."No." := '';
                    PurchOrderHeader."Posting Date" := IndentL."Posting Date";
                    PurchOrderHeader.Insert(true);
                    PurchOrderHeader."Your Reference" := IndentL."Requisition No.";
                    PurchOrderHeader."Order Date" := IndentL."Posting Date";
                    // PurchOrderHeader.Validate("Purchaser Code", IndentL."Purchase Code");
                    //PurchOrderHeader."Expected Receipt Date" := IndentL."Expect Date";
                    PurchOrderHeader.Validate("Buy-from Vendor No.", "IndentL"."Vendor No.");
                    PurchOrderHeader.Validate("Location Code", IndentL."Location Code");
                    PurchOrderHeader.Validate("Shortcut Dimension 1 Code", IndentL."Shortcut Dimenssion 1");
                    PurchOrderHeader.Validate("Shortcut Dimension 2 Code", IndentL."Shortcut Dimenssion 2");
                    PurchOrderHeader.Modify();
                    VendorCode := IndentL."Vendor No.";
                    //   LocationRec := IndentL."Location Code";
                    InsertPurchLine1(PurchOrderHeader, IndentL);
                END else
                    InsertPurchLine1(PurchOrderHeader, IndentL);
            until IndentL.Next = 0;
            Message('Blanket Order has been created successfully %1', PurchOrderHeader."No.");
        END;
    END;

    local procedure InsertPurchLine1(PurchOrderHeader: Record 38; IndentRecL: Record "Requisition Planning Lines")
    var
        PurchOrderLine: Record 39;
        NextLineNo: Integer;
        PurchOrderLine1: Record 39;
        PurchCommentLine: Record "Purch. Comment Line";
        IndentLine: Record "Requisition Lines";
    begin
        PurchOrderLine1.Reset();
        PurchOrderLine1.SetRange("Document Type", PurchOrderHeader."Document Type");
        PurchOrderLine1.SetRange("Document No.", PurchOrderHeader."No.");
        if PurchOrderLine1.FindLast() then
            NextLineNo := PurchOrderLine1."Line No."
        else
            NextLineNo := 0;
        //    with IndentRecL do begin
        PurchOrderLine.Init;
        PurchOrderLine.BlockDynamicTracking(true);
        PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
        PurchOrderLine."Document No." := PurchOrderHeader."No.";
        NextLineNo := NextLineNo + 10000;
        PurchOrderLine."Line No." := NextLineNo;
        PurchOrderLine.Insert();
        PurchOrderLine.Validate("Buy-from Vendor No.", IndentRecL."Vendor No.");
        if IndentRecL.Type = IndentRecL.Type::FA then
            PurchOrderLine.Validate(Type, PurchOrderLine.Type::"Fixed Asset")
        else
            if IndentRecL.Type = IndentRecL.Type::Item then
                PurchOrderLine.Validate(Type, PurchOrderLine.Type::Item);
        PurchOrderLine.Validate("No.", IndentRecL."Item No.");
        PurchOrderLine.Description := IndentRecL.Description;
        // PurchOrderLine."Description 2" := IndentRecL."Description 2";
        PurchOrderLine.Validate("Location Code", IndentRecL."Location Code");
        //  PurchOrderLine.Validate("Unit of Measure Code", IndentRecL.uo);
        PurchOrderLine.Validate(Quantity, IndentRecL.Quantity);
        PurchOrderLine.Validate("Shortcut Dimension 1 Code", IndentRecL."Shortcut Dimenssion 1");
        PurchOrderLine.Validate("Shortcut Dimension 2 Code", IndentRecL."Shortcut Dimenssion 2");
        PurchOrderLine.POP := IndentRecL.POP;
        PurchOrderLine.SPQ := IndentRecL.SPQ;
        PurchOrderLine.MOQ := IndentRecL.MOQ;
        PurchOrderLine.BQ := IndentRecL.BQ;
        PurchOrderLine.LT := IndentRecL.LT;
        PurchOrderLine."Requisition No." := IndentRecL."Requisition No.";
        PurchOrderLine."Requisition Line No." := IndentRecL."Line No.";
        PurchOrderLine.Modify();
        /*
        if PurchOrderHeader."Document Type" IN [PurchOrderHeader."Document Type"::Order,
        PurchOrderHeader."Document Type"::"Blanket Order"] then begin
            IndentLine.Reset();
            IndentLine.SetRange("Requisition No." , IndentRecL."Requisition No.");
            IndentLine.SetRange("Line No.", IndentRecL."Line No.");
            if IndentLine.FindFirst() then begin
                IndentLine."Outstanding Qty (Base)" := IndentLine."Outstanding Qty (Base)" - IndentRecL.Quantity;
                if PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Order then
                    IndentLine.Status := IndentLine.Status::"PO Created";
                IndentLine.Modify();
            end;
        END;
        */
    end;


    procedure CalculateRFQPlanLine(LocCode: Code[20]; Saleperson: code[30])
    var
        IndentLine: Record "Sales RFQ Line";
        IndentTemLine: Record "SalesRFQ Planning  Line";
        PurchaseIndentPlanning: Page "RFQ Planning Lines";
        IndentH: Record "Sales RFQ Header";
        ItemRec: Record Item;
    begin
        IndentTemLine.DeleteAll();
        if Saleperson = '' then
            Error('salesperson must have a value');
        IndentLine.Reset();
        if LocCode <> '' then
            IndentLine.SetRange("Location Code", LocCode);
        // IndentLine.SetRange("Approval Status", IndentLine."Approval Status"::Approved);
        IndentLine.SetRange(Salesperson, Saleperson);
        IndentLine.SetFilter("Quote Created", '%1', false);
        IndentLine.SetFilter(Cancel, '%1', false);
        if IndentLine.FindFirst() then
            repeat
                if IndentH.Get(IndentLine."RFQ Doc No.") then begin
                    if IndentLine.Quantity <> 0 then begin
                        IndentTemLine.Init();
                        IndentTemLine.TransferFields(IndentLine);
                        if ItemRec.Get(IndentTemLine."Item No.") then
                            IndentTemLine.Description := ItemRec.Description;
                        IndentTemLine.Insert();
                    end;
                END;
            until IndentLine.Next() = 0;
        // PurchaseIndentPlanning.Run();
    end;


    ///////create quote from RFQ planning line
    procedure CreatesalesQuote()
    var
        PurchOrderHeader: Record 36;
        PurchOrderHeader1: Record 36;
        CategoryType: Code[20];
        VendorCode: Code[50];
        LocationRec: Code[10];
        VendorRec: Record Customer;
        LoRec: Record 14;
        IndentL: Record "SalesRFQ Planning  Line";

    begin
        IndentL.Reset();
        IndentL.SetCurrentKey("RFQ Doc No.");
        /*
        IndentL.SetFilter(IndentL."Replenishment Type", '%1', IndentL."Replenishment Type"::" ");
        // if IndentL."Replenishment Type" = IndentL."Replenishment Type"::" " then
        if IndentL.FindFirst() then begin
            Error('You have not selected Replenishment type in Line No %1', IndentL."Line No.");
        end;
        */
        // if IndentL."Replenishment Type" = IndentL."Replenishment Type"::"sales Quote" then begin
        IndentL.SetFilter(IndentL."Replenishment Type", '%1', IndentL."Replenishment Type"::"sales Quote");
        // IndentL.SetRange(IndentL.Select, true);
        if IndentL.FindFirst() then begin
            repeat

                if VendorRec.Get(IndentL."Customer No.") then;
                if (VendorCode <> IndentL."Customer No.") then begin
                    // Or (LocationRec <> IndentL."Location Code") then begin
                    PurchOrderHeader.Init;
                    PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Quote;
                    PurchOrderHeader."No." := '';
                    PurchOrderHeader."Posting Date" := IndentL."Document Date";
                    PurchOrderHeader."Document Date" := IndentL."Document Date";
                    PurchOrderHeader.Insert(true);
                    PurchOrderHeader."Your Reference" := IndentL."RFQ Doc No.";
                    PurchOrderHeader."Order Date" := IndentL."Document Date";
                    PurchOrderHeader."RFQ Doc No." := IndentL."RFQ Doc No.";
                    PurchOrderHeader.Validate("Sell-to Customer No.", "IndentL"."Customer No.");
                    PurchOrderHeader.Validate("Location Code", IndentL."Location Code");

                    PurchOrderHeader.Modify();
                    VendorCode := IndentL."Customer No.";
                    //   LocationRec := IndentL."Location Code";
                    InsertPurchLine2(PurchOrderHeader, IndentL);
                END else
                    InsertPurchLine2(PurchOrderHeader, IndentL);
            until IndentL.Next = 0;

            Message('Sales Quote has been created successfully Quote no. %1', PurchOrderHeader."No.");
            IndentL.Delete();
        END;
        // else
        //   if IndentL."Replenishment Type" = IndentL."Replenishment Type"::" " then
        //     Error('You have not selected Replenishment type in Line No %1', IndentL."Line No.");
        // 
        // end;
    END;

    procedure CreatesalesOrder()
    var
        PurchOrderHeader: Record 36;
        PurchOrderHeader1: Record 36;
        CategoryType: Code[20];
        VendorCode: Code[50];
        LocationRec: Code[10];
        VendorRec: Record Customer;
        LoRec: Record 14;
        IndentL: Record "SalesRFQ Planning  Line";

    begin
        IndentL.Reset();
        IndentL.SetCurrentKey("RFQ Doc No.");
        /*
        IndentL.SetFilter(IndentL."Replenishment Type", '%1', IndentL."Replenishment Type"::" ");
        // if IndentL."Replenishment Type" = IndentL."Replenishment Type"::" " then
        if IndentL.FindFirst() then begin
            Error('You have not selected Replenishment type in Line No %1', IndentL."Line No.");
        end;
        */
        // if IndentL."Replenishment Type" = IndentL."Replenishment Type"::"sales Quote" then begin
        IndentL.SetFilter(IndentL."Replenishment Type", '%1', IndentL."Replenishment Type"::"sales Order");
        // IndentL.SetRange(IndentL.Select, true);
        if IndentL.FindFirst() then begin
            repeat

                if VendorRec.Get(IndentL."Customer No.") then;
                if (VendorCode <> IndentL."Customer No.") then begin
                    // Or (LocationRec <> IndentL."Location Code") then begin
                    PurchOrderHeader.Init;
                    PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Order;
                    PurchOrderHeader."No." := '';
                    PurchOrderHeader."Posting Date" := IndentL."Document Date";
                    PurchOrderHeader."Document Date" := IndentL."Document Date";
                    PurchOrderHeader.Insert(true);
                    PurchOrderHeader."Your Reference" := IndentL."RFQ Doc No.";
                    PurchOrderHeader."Order Date" := IndentL."Document Date";
                    PurchOrderHeader."RFQ Doc No." := IndentL."RFQ Doc No.";
                    PurchOrderHeader.Validate("Sell-to Customer No.", "IndentL"."Customer No.");
                    PurchOrderHeader.Validate("Location Code", IndentL."Location Code");

                    PurchOrderHeader.Modify();
                    VendorCode := IndentL."Customer No.";
                    //   LocationRec := IndentL."Location Code";
                    InsertsaleorderLine2(PurchOrderHeader, IndentL);
                END else
                    InsertsaleorderLine2(PurchOrderHeader, IndentL);
            until IndentL.Next = 0;

            Message('Sales Order has been created successfully Order no. %1', PurchOrderHeader."No.");
            IndentL.Delete();
        END;
        // else
        //   if IndentL."Replenishment Type" = IndentL."Replenishment Type"::" " then
        //     Error('You have not selected Replenishment type in Line No %1', IndentL."Line No.");
        // 
        // end;

    END;



    local procedure InsertPurchLine2(PurchOrderHeader: Record 36; IndentRecL: Record "SalesRFQ Planning  Line")
    var
        Sadapr: Record "Sada price List";
        PurchOrderLine: Record 37;
        NextLineNo: Integer;
        PurchOrderLine1: Record 37;
        PurchCommentLine: Record "Purch. Comment Line";
        IndentLine: Record "Sales RFQ Line";
        RecItem: Record Item;
        rfqline: Record "Sales RFQ Line";
        rfqhead: Record "Sales RFQ Header";
        linewiseappsetup: Record Linewiseapprovalsetup;
    begin
        PurchOrderLine1.Reset();
        PurchOrderLine1.SetRange("Document Type", PurchOrderHeader."Document Type");
        PurchOrderLine1.SetRange("Document No.", PurchOrderHeader."No.");
        if PurchOrderLine1.FindLast() then
            NextLineNo := PurchOrderLine1."Line No."
        else
            NextLineNo := 0;
        //    with IndentRecL do begin
        PurchOrderLine.Init;
        PurchOrderLine.BlockDynamicTracking(true);
        PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
        PurchOrderLine."Document No." := PurchOrderHeader."No.";
        PurchOrderLine."Posting Date" := IndentRecL."Document Date";

        NextLineNo := NextLineNo + 10000;
        PurchOrderLine."Line No." := NextLineNo;
        PurchOrderLine.Insert();
        PurchOrderLine.Validate("Sell-to Customer No.", IndentRecL."Customer No.");
        if IndentRecL.Type = IndentRecL.Type::FA then
            PurchOrderLine.Validate(Type, PurchOrderLine.Type::"Fixed Asset")
        else
            if IndentRecL.Type = IndentRecL.Type::Item then
                PurchOrderLine.Validate(Type, PurchOrderLine.Type::Item);
        PurchOrderLine.Validate("No.", IndentRecL."Item No.");
        PurchOrderLine.Description := IndentRecL.Description;
        PurchOrderLine."Description 2" := IndentRecL.Description;
        PurchOrderLine."Request Date" := IndentRecL."Request Date";
        PurchOrderLine."Estimated Date" := IndentRecL."Estimated Date";
        PurchOrderLine."Confirm Date" := IndentRecL."Confirm Date";
        linewiseappsetup.Reset();
        linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::Allocation);
        if linewiseappsetup.FindFirst() then begin
            if linewiseappsetup.Enable = true then begin
                RecItem.Reset();
                RecItem.Get(PurchOrderLine."No.");
                if RecItem."Allocation Type" = RecItem."Allocation Type"::Allocate then begin
                    PurchOrderLine."Allocation Status" := PurchOrderLine."Allocation Status"::"Pending For Approval";
                end;
            end;
        end;


        if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
            Sadapr.Reset();
            Sadapr.SetRange("Item No. (MPN)", PurchOrderLine."No.");
            Sadapr.SetRange("Customer No.", PurchOrderLine."Sell-to Customer No.");
            Sadapr.SetFilter("Item Start Date", '<= %1', PurchOrderLine."Planned Delivery Date");
            Sadapr.SetFilter("Item Expiry Date", '>=%1', PurchOrderLine."Planned Delivery Date");
            if Sadapr.FindFirst() then
                PurchOrderLine."Unit Price" := Sadapr."DBC. (DCPL Price)"
            else
                PurchOrderLine."Unit Price" := IndentRecL."Direct Unit Cost";
            ///////

            Sadapr.Reset();
            Sadapr.SetRange("Item No. (MPN)", PurchOrderLine."No.");
            Sadapr.SetFilter("Item Expiry Date", '< %1', Today);
            Sadapr.SetFilter("Remaining Qty", '%1', 0);
            if Sadapr.FindFirst() then begin
                Message('Remaining Qty in Sada Price List is 0');
            end else begin
                linewiseappsetup.Reset();
                linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Remaining Qty");
                if linewiseappsetup.FindFirst() then begin
                    if linewiseappsetup.Enable = true then begin
                        PurchOrderLine."Remaining Approval Status" := PurchOrderLine."Remaining Approval Status"::"Pending For Approval";
                    end;
                end;
            end;
        end else begin
            linewiseappsetup.Reset();
            linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Less Margin");
            if linewiseappsetup.FindFirst() then begin
                if linewiseappsetup.Enable = true then begin
                    PurchOrderLine."Unit Price" := IndentRecL."Direct Unit Cost";
                    if RecItem."Price Category" = RecItem."Price Category"::"Non-SADA" then begin
                        if PurchOrderLine."Unit Price" < (RecItem."Purchase price" + RecItem."Margin %") then begin
                            PurchOrderLine."Margin is Less" := true;
                            PurchOrderLine."Price Status" := PurchOrderLine."Price Status"::"Pending For Approval";
                        end;
                        Message('Approval request sent to sales Head Due to margin is less then the mentioned in item');
                    end;
                end;
            end;
        end;
        PurchOrderLine."Unit Price" := IndentRecL."Direct Unit Cost";
        PurchOrderLine.Validate("Location Code", IndentRecL."Location Code");
        //  PurchOrderLine.Validate("Unit of Measure Code", IndentRecL.uo);
        PurchOrderLine.Validate(Quantity, IndentRecL.Quantity);

        PurchOrderLine."RFQ Doc No." := IndentRecL."RFQ Doc No.";
        PurchOrderLine."RFQ Line No." := IndentRecL."Line No.";
        PurchOrderLine.Brand := IndentRecL.Brand;
        PurchOrderLine.rate := IndentRecL.rate;
        PurchOrderLine."Salesperson Code" := IndentRecL.Salesperson;
        PurchOrderLine.Application := IndentRecL.Application;
        PurchOrderLine."Cost price" := IndentRecL."Cost price";
        PurchOrderLine.project := IndentRecL.project;
        PurchOrderLine."Unit of Measure" := IndentRecL.UOM;
        // PurchOrderLine."Unit Price" := IndentRecL."Cost price";
        PurchOrderLine.SPQ := IndentRecL.SPQ;
        PurchOrderLine.MOQ := IndentRecL.MOQ;
        PurchOrderLine.LT := IndentRecL.LT;
        PurchOrderLine."Estimated Date" := IndentRecL."Estimated Date";
        PurchOrderLine.Modify();


        if PurchOrderHeader."Document Type" IN [PurchOrderHeader."Document Type"::Order, PurchOrderHeader."Document Type"::Quote,
        PurchOrderHeader."Document Type"::"Blanket Order"] then begin
            IndentLine.Reset();
            IndentLine.SetRange("RFQ Doc No.", IndentRecL."RFQ Doc No.");
            IndentLine.SetRange("Line No.", IndentRecL."Line No.");
            if IndentLine.FindFirst() then begin
                // IndentLine."Outstanding Qty (Base)" := IndentLine."Outstanding Qty (Base)" - IndentRecL.Quantity;
                if PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Order then
                    IndentLine.Status := IndentLine.Status::"SO Created";
                IndentLine."Quote Created" := true;
                IndentLine.Modify();

            end;
        END;
        rfqhead.Reset();
        rfqhead.SetRange("RFQ Doc No.", IndentRecL."RFQ Doc No.");
        if rfqhead.FindFirst() then
            rfqhead."Quote Created" := true;
        rfqhead.Modify();

    end;

    local procedure InsertsaleorderLine2(PurchOrderHeader: Record 36; IndentRecL: Record "SalesRFQ Planning  Line")
    var
        Sadapr: Record "Sada price List";
        PurchOrderLine: Record 37;
        NextLineNo: Integer;
        PurchOrderLine1: Record 37;
        PurchCommentLine: Record "Purch. Comment Line";
        IndentLine: Record "Sales RFQ Line";
        RecItem: Record Item;
        rfqline: Record "Sales RFQ Line";
        rfqhead: Record "Sales RFQ Header";
        linewiseappsetup: Record Linewiseapprovalsetup;
    begin
        PurchOrderLine1.Reset();
        PurchOrderLine1.SetRange("Document Type", PurchOrderHeader."Document Type");
        PurchOrderLine1.SetRange("Document No.", PurchOrderHeader."No.");
        if PurchOrderLine1.FindLast() then
            NextLineNo := PurchOrderLine1."Line No."
        else
            NextLineNo := 0;
        //    with IndentRecL do begin
        PurchOrderLine.Init;
        PurchOrderLine.BlockDynamicTracking(true);
        PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
        PurchOrderLine."Document No." := PurchOrderHeader."No.";
        PurchOrderLine."Posting Date" := IndentRecL."Document Date";

        NextLineNo := NextLineNo + 10000;
        PurchOrderLine."Line No." := NextLineNo;
        PurchOrderLine.Insert();
        PurchOrderLine.Validate("Sell-to Customer No.", IndentRecL."Customer No.");
        if IndentRecL.Type = IndentRecL.Type::FA then
            PurchOrderLine.Validate(Type, PurchOrderLine.Type::"Fixed Asset")
        else
            if IndentRecL.Type = IndentRecL.Type::Item then
                PurchOrderLine.Validate(Type, PurchOrderLine.Type::Item);
        PurchOrderLine.Validate("No.", IndentRecL."Item No.");
        PurchOrderLine.Description := IndentRecL.Description;
        PurchOrderLine."Description 2" := IndentRecL.Description;
        PurchOrderLine."Request Date" := IndentRecL."Request Date";
        PurchOrderLine."Estimated Date" := IndentRecL."Estimated Date";
        PurchOrderLine."Confirm Date" := IndentRecL."Confirm Date";
        linewiseappsetup.Reset();
        linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::Allocation);
        if linewiseappsetup.FindFirst() then begin
            if linewiseappsetup.Enable = true then begin
                RecItem.Reset();
                RecItem.Get(PurchOrderLine."No.");
                if RecItem."Allocation Type" = RecItem."Allocation Type"::Allocate then begin
                    PurchOrderLine."Allocation Status" := PurchOrderLine."Allocation Status"::"Pending For Approval";
                end;
            end;
        end;


        if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
            Sadapr.Reset();
            Sadapr.SetRange("Item No. (MPN)", PurchOrderLine."No.");
            Sadapr.SetRange("Customer No.", PurchOrderLine."Sell-to Customer No.");
            Sadapr.SetFilter("Item Start Date", '<= %1', PurchOrderLine."Planned Delivery Date");
            Sadapr.SetFilter("Item Expiry Date", '>=%1', PurchOrderLine."Planned Delivery Date");
            if Sadapr.FindFirst() then
                PurchOrderLine."Unit Price" := Sadapr."DBC. (DCPL Price)"
            else
                PurchOrderLine."Unit Price" := IndentRecL."Direct Unit Cost";
            ///////

            Sadapr.Reset();
            Sadapr.SetRange("Item No. (MPN)", PurchOrderLine."No.");
            Sadapr.SetFilter("Item Expiry Date", '< %1', Today);
            Sadapr.SetFilter("Remaining Qty", '%1', 0);
            if Sadapr.FindFirst() then begin
                Message('Remaining Qty in Sada Price List is 0');
            end else begin
                linewiseappsetup.Reset();
                linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Remaining Qty");
                if linewiseappsetup.FindFirst() then begin
                    if linewiseappsetup.Enable = true then begin
                        PurchOrderLine."Remaining Approval Status" := PurchOrderLine."Remaining Approval Status"::"Pending For Approval";
                    end;
                end;
            end;
        end else begin
            linewiseappsetup.Reset();
            linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Less Margin");
            if linewiseappsetup.FindFirst() then begin
                if linewiseappsetup.Enable = true then begin
                    PurchOrderLine."Unit Price" := IndentRecL."Direct Unit Cost";
                    if RecItem."Price Category" = RecItem."Price Category"::"Non-SADA" then begin
                        if PurchOrderLine."Unit Price" < (RecItem."Purchase price" + RecItem."Margin %") then begin
                            PurchOrderLine."Margin is Less" := true;
                            PurchOrderLine."Price Status" := PurchOrderLine."Price Status"::"Pending For Approval";
                        end;
                        Message('Approval request sent to sales Head Due to margin is less then the mentioned in item');
                    end;
                end;
            end;
        end;
        PurchOrderLine."Unit Price" := IndentRecL."Direct Unit Cost";
        PurchOrderLine.Validate("Location Code", IndentRecL."Location Code");
        //  PurchOrderLine.Validate("Unit of Measure Code", IndentRecL.uo);
        PurchOrderLine.Validate(Quantity, IndentRecL.Quantity);

        PurchOrderLine."RFQ Doc No." := IndentRecL."RFQ Doc No.";
        PurchOrderLine."RFQ Line No." := IndentRecL."Line No.";
        PurchOrderLine.Brand := IndentRecL.Brand;
        PurchOrderLine.rate := IndentRecL.rate;
        PurchOrderLine."Salesperson Code" := IndentRecL.Salesperson;
        PurchOrderLine.Application := IndentRecL.Application;
        PurchOrderLine."Cost price" := IndentRecL."Cost price";
        PurchOrderLine.project := IndentRecL.project;
        PurchOrderLine."Unit of Measure" := IndentRecL.UOM;
        // PurchOrderLine."Unit Price" := IndentRecL."Cost price";
        PurchOrderLine.SPQ := IndentRecL.SPQ;
        PurchOrderLine.MOQ := IndentRecL.MOQ;
        PurchOrderLine.LT := IndentRecL.LT;
        PurchOrderLine."Estimated Date" := IndentRecL."Estimated Date";
        PurchOrderLine.Modify();


        if PurchOrderHeader."Document Type" IN [PurchOrderHeader."Document Type"::Order, PurchOrderHeader."Document Type"::Quote,
        PurchOrderHeader."Document Type"::"Blanket Order"] then begin
            IndentLine.Reset();
            IndentLine.SetRange("RFQ Doc No.", IndentRecL."RFQ Doc No.");
            IndentLine.SetRange("Line No.", IndentRecL."Line No.");
            if IndentLine.FindFirst() then begin
                // IndentLine."Outstanding Qty (Base)" := IndentLine."Outstanding Qty (Base)" - IndentRecL.Quantity;
                if PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Order then
                    IndentLine.Status := IndentLine.Status::"SO Created";
                IndentLine."Quote Created" := true;
                IndentLine.Modify();

            end;
        END;
        rfqhead.Reset();
        rfqhead.SetRange("RFQ Doc No.", IndentRecL."RFQ Doc No.");
        if rfqhead.FindFirst() then
            rfqhead."Quote Created" := true;
        rfqhead.Modify();

    end;

}