page 50008 "Sale RFQ Order"
{
    Caption = 'Sales RFQ';
    PageType = Document;
    SourceTable = "Sales RFQ Header";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("RFQ Doc No."; Rec."RFQ Doc No.")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Original Customer Name"; Rec."Original Customer Name")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field(Location; Rec.Location)
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field("Your Ref."; Rec."Your Ref.")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = ALl;
                    Editable = editablefield;
                }
                field(Salesperson; Rec.Salesperson)
                {
                    ApplicationArea = All;
                    Editable = editablefield;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                    Applicationarea = All;
                }
                field("Contact person"; Rec."Contact person")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field(Remarks; Rec.Remarks)
                {
                    Applicationarea = All;
                    Editable = editablefield;
                }
                field(Zone; Rec.Zone)
                {
                    Applicationarea = All;
                    Editable = editablefield;

                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = editablefield;
                }
            }
            part(Lines; 50009)
            {
                ApplicationArea = all;
                SubPageLink = "RFQ Doc No." = FIELD("RFQ Doc No.");
                UpdatePropagation = Both;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(PurchOrderReport)
            {
                Caption = 'Report';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ph: Record "Sales RFQ Header";
                begin
                    ph.Reset();
                    ph.SetRange("RFQ Doc No.", Rec."RFQ Doc No.");
                    if ph.FindFirst() then
                        Report.Run(50007, true, false, ph);
                end;


            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Send an approval request';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 50038;
                    begin
                        IF ApprovalsMgmt.CheckSaleRFQApprovalsWorkflowEnabled(Rec) THEN //pru sh
                            ApprovalsMgmt.OnSendSaleRFQForApproval(Rec); //pru sh

                    END;
                }

                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = true;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 50038;
                    begin
                        ApprovalsMgmt.OnCancelSaleRFQForApproval(Rec)

                    end;
                }
            }
            /*
            group("Upload Data")
            {
                Caption = 'Upload Data';
                action("Import RFQ Lines")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Import RFQ Lines';
                    Image = Import;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Report50003: XmlPort 50002;
                        JobRec: Record "Sales RFQ Header";
                    begin

                        CLEAR(Report50003);
                        Report50003.GetDocNo(Rec."RFQ Doc No.");
                        Report50003.RUN;
                    end;
                }
            }
            */


        }

    }


    trigger OnAfterGetRecord()
    begin

        if Rec."Approval Status" = Rec."Approval Status"::Approved then
            editablefield := false
        else
            editablefield := true;
        /* CurrPage.Editable(false);
          */
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

    end;

    trigger OnOpenPage()
    begin
        pageEdit := true;
        if Rec."Approval Status" = Rec."Approval Status"::Approved then
            editablefield := false
        else
            editablefield := true;
    end;

    trigger OnDeleteRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        editablefield := true;
    end;

    var
        pageEdit: Boolean;
        editablefield: Boolean;

}

