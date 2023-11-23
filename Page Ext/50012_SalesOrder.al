pageextension 50012 SaleOrderExt extends "Sales Order"
{


    layout
    {

        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Registration No.")
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        /*
        modify("Sell-to Contact")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                custcont: record Customer_Contact;
                CustContPage: Page Customer_Contact_Page;
            begin
                custcont.Reset();
                custcont.SetRange("Customer No.", Rec."Sell-to Customer No.");
                CustContPage.SETTABLEVIEW(custcont);
                CustContPage.LOOKUPMODE(TRUE);
                if (CustContPage.RunModal() = Action::LookupOK) then begin
                    CustContPage.GetRecord(custcont);
                    Rec."Sell-to Contact" := custcont."Contact No.";
                end;
            end;
        }
        */
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including';
        }
        addafter("Document Date")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field("Sale Order type"; Rec."Sale Order type")
            {
                ApplicationArea = All;
            }
            /*
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    VendLedgPage: Page "Posted Outward GateEntry List";
                    VendorLedgerEntry: Record "Posted Gate Entry Header";
                begin
                    VendorLedgerEntry.Reset();
                    // VendorLedgerEntry.SetFilter("Entry Type", '%1', VendorLedgerEntry."Entry Type"::Outward);
                    //VendorLedgerEntry.SetRange("Source No.", Rec."No.");
                    VendLedgPage.SETTABLEVIEW(VendorLedgerEntry);
                    VendLedgPage.LOOKUPMODE(TRUE);
                    if (VendLedgPage.RunModal() = Action::LookupOK) then begin
                        VendLedgPage.GetRecord(VendorLedgerEntry);
                        Rec."Gate Entry No." := VendorLedgerEntry."No.";
                    end;
                end;
            }
            */
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = all;
            }
            field("So Type"; Rec."So Type")
            {
                ApplicationArea = all;
            }
            field("FAE Opportunity Document No."; Rec."FAE Opportunity Document No.")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field(MasterScanBarcode; MasterScanBarcode)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //   IF GETLASTERRORTEXT <> '' THEN
                    //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                    CurrPage.SalesLines.PAGE.SaleLineMasterScanBarcode(MasterScanBarcode);
                    CLEAR(MasterScanBarcode);
                    CurrPage.UPDATE;
                end;
            }
            field(CartonScanBarcode; CartonScanBarcode)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //   IF GETLASTERRORTEXT <> '' THEN
                    //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                    CurrPage.SalesLines.PAGE.SaleLineCartonScanBarcode(CartonScanBarcode);
                    CLEAR(MasterScanBarcode);
                    CurrPage.UPDATE;
                end;
            }
            field(ProductScanBarcode; ProductScanBarcode)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //   IF GETLASTERRORTEXT <> '' THEN
                    //      ERROR(STRSUBSTNO('%1', GETLASTERRORTEXT));
                    CurrPage.SalesLines.PAGE.SaleLineProductScanBarcode(CartonScanBarcode);
                    CLEAR(MasterScanBarcode);
                    CurrPage.UPDATE;
                end;
            }
        }
        /*
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            var
                usersetup: Record "User Setup";
            begin
                usersetup.Get(UserId);
                Rec.SetRange("Shortcut Dimension 2 Code", usersetup.Branch);
            end;
        }
        */

    }
    actions
    {
        addafter(Post)
        {
            action(PurchOrderReport)
            {
                Caption = 'Sales Order Report';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ph: Record "Sales Header";
                begin
                    ph.Reset();
                    ph.SetRange("No.", Rec."No.");
                    if ph.FindFirst() then
                        Report.Run(50005, true, false, ph);
                end;
            }
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                sh: Record "Sales Header";
                sl: Record "Sales Line";
                FAERec: Record "FAE Header";
                FAELine: Record "FAE Line";
                days: Integer;
                month: Integer;
                year: Integer;
                expiredate: Date;
            begin
                sh.Reset();
                sl.Reset();
                FAERec.Reset();
                FAELine.Reset();
                sl.SetRange("Document No.", Rec."No.");
                sl.SetRange("Document Type", Rec."Document Type");
                if sl.FindFirst() then begin
                    FAERec.SetRange("Customer No.", sl."Sell-to Customer No.");
                    if FAERec.FindFirst() then begin
                        FAELine.SetRange("Customer No.", sl."Sell-to Customer No.");
                        FAELine.SetRange("Assembly No.", sl."No.");
                        if FAELine.FindFirst() then begin
                            Rec."FAE Opportunity Document No." := FAELine."Opportunity Document No.";
                            Rec.Modify();
                        end;
                    end;
                end;
            end;
        }

        modify(Release)
        {
            trigger OnBeforeAction()
            var
                GateEntryAttachment: Record "Gate Entry Attachment";
                purchLine: Record "Sales Line";
            begin

                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::Order);
                if purchLine.FindSet() then begin
                    repeat
                        // purchLine.TestField("Unit Cost (LCY)");
                        purchLine.TestField("Unit Price");
                    until purchLine.Next() = 0;
                end;

            end;
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            var
                TLRec: Record "Sales Line";
                ItemRec: Record Item;
                BarCodeTrack: Record "SO Tracking";
                GateEntryAttachment: Record "Gate Entry Attachment";
                faeHead: Record "FAE Header";
                SIH: Record "Sales Invoice Header";
                SIL: Record "Sales Invoice Line";
                TotLineAmt: Decimal;
                SL: Record "Sales Line";
                TotSLLineAmt: Decimal;
                totallineamt: Decimal;
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");

                TLRec.Reset();
                TLRec.SetRange("Document No.", Rec."No.");
                if TLRec.FindFirst() then
                    repeat
                        if ItemRec.Get(TLRec."No.") then begin
                            if ItemRec."Barcode Tracking" = true then begin
                                BarCodeTrack.Reset();
                                BarCodeTrack.SetRange("Document No.", TLRec."Document No.");
                                BarCodeTrack.SetRange("Entry Type", BarCodeTrack."Entry Type"::Sales);
                                BarCodeTrack.SetRange("Item No.", TLRec."No.");
                                if Not BarCodeTrack.FindFirst() then
                                    Error('Please attach barcode tracking on this item %1', TLRec."No.");
                            end;
                        end;
                    until TLRec.Next() = 0;


                /////////////
                Clear(TotLineAmt);
                SIL.Reset();
                SIL.SetRange("FAE Opportunity Document No.", Rec."FAE Opportunity Document No.");
                if SIL.FindSet() then begin
                    repeat
                        TotLineAmt += SIL.Amount;
                    until SIL.Next() = 0;
                    // Message('%1...1', TotLineAmt);
                end;
                Clear(TotSLLineAmt);
                SL.Reset();
                SL.SetRange("Document No.", Rec."No.");
                SL.SetRange("Document Type", Rec."Document Type");
                SL.SetRange("FAE Opportunity Document No.", Rec."FAE Opportunity Document No.");
                if SL.FindSet() then begin
                    repeat
                        TotSLLineAmt += SL.Amount;
                    until SL.Next() = 0;
                    //  Message('%1....2', TotSLLineAmt);
                end;
                Clear(totallineamt);
                totallineamt := TotLineAmt + TotSLLineAmt;
                // Message('%1...3', totallineamt);
                if Rec."Currency Code" = 'USD' then begin
                    if (totallineamt > 1000) then begin
                        faeHead.Reset();
                        faeHead.SetRange("Opportunity Document No.", Rec."FAE Opportunity Document No.");
                        if faeHead.FindFirst() then
                            faeHead."Opportunity Status" := faeHead."Opportunity Status"::Win;
                        faeHead.Modify();
                    end;

                end else begin
                    if (totallineamt > 80000) then begin
                        faeHead.Reset();
                        faeHead.SetRange("Opportunity Document No.", Rec."FAE Opportunity Document No.");
                        if faeHead.FindFirst() then begin
                            faeHead."Opportunity Status" := faeHead."Opportunity Status"::Win;
                            faeHead.Modify();
                        end;
                        //       Error('%1', faeHead."Opportunity Status");
                    end;

                end;
                ///////////////



            end;
        }

        addafter(CopyDocument)
        {
            action(ShortClose)
            {
                Caption = 'Short Close';
                Image = Order;
                ApplicationArea = All;
                trigger OnAction()
                var

                begin
                    Rec.TestField("Reason Code");
                    Rec."Short Close" := true;
                    Rec.Modify();
                end;
            }
            action("Order Confirmation")
            {
                Caption = 'Send Order Confirmation Email';
                Image = Order;
                ApplicationArea = All;
                trigger OnAction()
                var
                begin
                    if Rec.Status = Rec.Status::Released then
                        SendEmail1()
                    else
                        Error('Status Should be Released');
                end;
            }
        }
    }
    procedure SendEmail1()
    var
        linewiseappsetup: Record Linewiseapprovalsetup;
        EmailBody: Text;
        SMTPMail: Codeunit "Email Message";
        RFQHead: Record "Sales RFQ Header";
        EmailId: Code[50];
        Email: Codeunit Email;
        cust: Record Customer;
        Salesperson: Record "Salesperson/Purchaser";
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
    begin

        cust.Reset();
        if cust.Get(Rec."Sell-to Contact No.") then;
        EmailId := cust."Email Id";
        // Message('%1', EmailId);
        Clear(SMTPMail);
        EmailBody := ('Dear Sir' + ',');
        EmailBody += ('<br><br>');
        EmailBody += ('Sales Order Confirmation Mail');
        EmailBody += ('<br><br>');
        EmailBody += ('For any further informationur');
        EmailBody += ('<br><br>');
        SMTPMail.Create(cust."Email id", 'Approval' + ' ' + '(' + Rec."No." + ')', EmailBody, true);

        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, EmailId);

        RecRef.GetTable(Rec);
        TempBlob.CreateOutStream(Outstr);
        Report.SaveAs(Report::"Sales Order Report", '', ReportFormat::Pdf, Outstr, RecRef);
        TempBlob.CreateInStream(Instr);
        // SMTPMail.AddAttachment(Rec."No." + '.pdf', 'PDF', Instr);
        // SMTPMail.AddAttachment(ReportPath, 'Order_' + DELCHR(Rec."No.", '=', '/') + '.pdf');

        SMTPMail.AppendToBody('With best regards!' + ',');
        SMTPMail.AppendToBody('<BR>');
        SMTPMail.AppendToBody('Test');
        SMTPMail.AppendToBody('<BR><BR>');
        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
        Clear(Email);
        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Message('Sale Order approval Mail Sent');



    end;


    trigger OnAfterGetRecord()
    var
    begin
        Rec.SetFilter("Short Close", '%1', false);
    end;

    trigger OnOpenPage()
    var
    begin
        Rec.SetFilter("Short Close", '%1', false);
    end;

    var
        MasterScanBarcode: Code[20];
        CartonScanBarcode: Code[20];
        ProductScanBarcode: Code[20];
}