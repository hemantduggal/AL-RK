pageextension 50006 PurchorderExt extends "Purchase Order"
{
    layout
    {
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }

        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        /*
            modify("Buy-from Contact")
            {
                trigger OnLookup(var Text: Text): Boolean
                var
                    custcont: record Vendor_Contact;
                    CustContPage: Page Vendor_Contact_Page;
                begin
                    custcont.Reset();
                    custcont.SetRange("Vendor No.", Rec."Buy-from Vendor No.");
                    CustContPage.SETTABLEVIEW(custcont);
                    CustContPage.LOOKUPMODE(TRUE);
                    if (CustContPage.RunModal() = Action::LookupOK) then begin
                        CustContPage.GetRecord(custcont);
                        Rec."Buy-from Contact" := custcont."Contact No.";
                    end;
                end;
            }
            */
        addafter("Order Date")
        {

            field("End Customer"; Rec."End Customer")
            {
                ApplicationArea = All;
            }
            field("Opp. Refrence No."; Rec."Opp. Refrence No.")
            {
                ApplicationArea = All;
            }
            field("Refrence No."; Rec."Refrence No.")
            {
                ApplicationArea = All;
            }
            field("Import Type"; Rec."Import Type")
            {
                ApplicationArea = All;
            }
            field("Account ID"; Rec."Account ID")
            {
                ApplicationArea = All;
            }
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
            }
            field("Customer Refrence No."; Rec."Customer Refrence No.")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("LC Applicable"; Rec."LC Applicable")
            {
                ApplicationArea = All;
            }
            field("LC No."; Rec."LC No.")
            {
                ApplicationArea = All;
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("No. of packing"; Rec."No. of packing")
            {
                ApplicationArea = All;
            }
            field("CHA Vendor No."; Rec."CHA Vendor No.")
            {
                ApplicationArea = All;
            }
            field("Shipping Line Vendor"; Rec."Shipping Line Vendor")
            {
                ApplicationArea = All;
            }

            field("Short Close"; Rec."Short Close")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PO Type"; Rec."PO Type")
            {
                ApplicationArea = All;
                //Editable = false;
            }
            field("SO No."; Rec."SO No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SO Date"; Rec."SO Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SO Cust No."; Rec."SO Cust No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;

            }
            field("Return Shipment No. Series"; Rec."Return Shipment No. Series")
            {
                ApplicationArea = All;

            }
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
                ApplicationArea = All;

            }
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = All;

            }
            field("Return Shipment No."; Rec."Return Shipment No.")
            {
                ApplicationArea = All;

            }


        }
    }
    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                GateEntryAttachment: Record "Gate Entry Attachment";
                purchLine: Record "Purchase Line";
            begin
                purchLine.Reset();
                purchLine.SetRange("Document No.", Rec."No.");
                purchLine.SetRange("Document Type", purchLine."Document Type"::Order);
                if purchLine.FindSet() then begin
                    repeat
                        purchLine.TestField("Direct Unit Cost");
                    // purchLine.TestField("Unit Price (LCY)");
                    until purchLine.Next() = 0;
                end;

            end;
        }




        modify(Post)
        {
            trigger OnBeforeAction()
            var
                TLRec: Record "Purchase Line";
                ItemRec: Record Item;
                BarCodeTrack: Record "Master Barcode Tracking";
                GateEntryAttachment: Record "Gate Entry Attachment";
            begin

                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                /*
                              GateEntryAttachment.Reset();
                              GateEntryAttachment.SetRange("Source No.", Rec."No.");
                              if not GateEntryAttachment.FindFirst() then
                                  Error('You must attached gate entry with the order');
              */
                if Rec."PO Type" = rec."PO Type"::Sample then begin
                    if Rec.Status = rec.Status::Released then begin
                        TLRec.Reset();
                        TLRec.SetRange("Document No.", Rec."No.");
                        if TLRec.FindFirst() then
                            repeat
                                if ItemRec.Get(TLRec."No.") then begin
                                    if ItemRec."Barcode Tracking" = true then begin
                                        BarCodeTrack.Reset();
                                        BarCodeTrack.SetRange("Document No.", TLRec."Document No.");
                                        BarCodeTrack.SetRange("Entry Type", BarCodeTrack."Entry Type"::Purchase);
                                        BarCodeTrack.SetRange("Item No.", TLRec."No.");
                                        if Not BarCodeTrack.FindFirst() then
                                            Error('Please attach barcode tracking on this item %1', TLRec."No.");
                                    end;
                                end;
                            until TLRec.Next() = 0;
                    end;
                end;
            end;
        }
        addafter(Post)
        {
            action(PurchOrderReport)
            {
                Caption = 'Purchase Order Report';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ph: Record "Purchase Header";
                begin
                    ph.Reset();
                    ph.SetRange("No.", Rec."No.");
                    if ph.FindFirst() then
                        Report.Run(50000, true, false, ph);
                end;


            }
        }
        addafter(CopyDocument)
        {
            action(Linksaleorder)
            {
                Caption = 'Link Sale Order';
                Image = Document;
                ApplicationArea = All;
                // RunObject = page "Purchase Order List";
                // RunPageView = where(Status = filter(Released));
                trigger OnAction()
                var
                    purchorderpage: Page "Sales Order List";
                    purchorder: Record "Sales Header";
                begin
                    purchorder.Reset();
                    purchorder.SetFilter("Sell-to Customer No.", Rec."Customer No.");
                    purchorder.SetFilter(Status, '%1', purchorder.Status::Released);
                    purchorderpage.SETTABLEVIEW(purchorder);
                    purchorderpage.LOOKUPMODE(TRUE);
                    if (purchorderpage.RunModal() = Action::LookupOK) then begin
                        purchorderpage.GetRecord(purchorder);
                        Rec."SO No." := purchorder."No.";
                        Rec."SO Date" := purchorder."Document Date";
                        Rec."SO Cust No." := purchorder."Sell-to Customer No.";
                    end;
                end;
            }
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
            action(TermsCondition)
            {
                Caption = 'Terms & Condition';
                Image = Document;
                ApplicationArea = All;
                RunObject = page TermsConditionList;
                trigger OnAction()
                var

                begin

                end;
            }
            action(UpdateLCNO)
            {
                Caption = 'Update LC No.';
                Image = Document;
                ApplicationArea = All;
                RunObject = xmlport ImportLCNo;
                trigger OnAction()
                var

                begin

                end;
            }
        }
    }
}