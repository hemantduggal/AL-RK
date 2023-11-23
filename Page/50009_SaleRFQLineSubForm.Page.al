page 50009 "Sale RFQ Line SubForm"
{

    AutoSplitKey = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales RFQ Line";
    // ApplicationArea = All;
    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }
                field("Item No."; Rec."Item No.")
                {

                    Applicationarea = All;
                    Editable = Edit;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Manufacturer Part No.';
                    Applicationarea = All;
                    // Editable = false;
                }
                field(Brand; Rec.Brand)
                {
                    Editable = Edit;
                    Applicationarea = All;
                }
                field(Description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                    Applicationarea = All;
                    // Editable = false;
                }
                field("Customer Part No."; Rec."Customer Part No.")
                {
                    ApplicationArea = ALl;
                    trigger OnValidate()
                    var
                        Pagevar: Page "Customer Design Part No.";
                        varRec: Record "Customer Design Part";
                    begin

                        varRec.Reset();
                        varRec.Init();
                        varRec."Design Part No." := Rec."Design Part No.";
                        varRec."Item No." := Rec."Item No.";
                        varRec.Insert();
                        varRec."Customer No." := Rec."Customer No.";

                        varRec.Modify();
                        /*
                        Pagevar.SETTABLEVIEW(varRec);
                        Pagevar.LOOKUPMODE(TRUE);
                        if (Pagevar.RunModal() = Action::LookupOK) then begin
                            Pagevar.GetRecord(varRec);
                            Rec."Design Part No." := varRec."Design Part No.";

                        end;
                        */
                    end;
                }
                field(SPQ; Rec.SPQ)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }
                field(MOQ; Rec.MOQ)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                }

                field(Quantity; Rec.Quantity)
                {
                    Applicationarea = All;
                    Editable = Edit;
                    trigger OnValidate()
                    var
                        RecItem: Record Item;
                        saleRfq: Record "Sales RFQ Header";
                        Sadapr: Record "Sada price List";
                        linewiseappsetup: Record Linewiseapprovalsetup;
                    begin
                        RecItem.Reset();
                        RecItem.get(Rec."Item No.");
                        if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
                            Sadapr.Reset();
                            Sadapr.SetRange("Item No. (MPN)", rec."Item No.");
                            Sadapr.SetRange("Customer No.", rec."Customer No.");
                            Sadapr.SetFilter("Item Start Date", '<= %1', rec."Document Date");
                            Sadapr.SetFilter("Item Expiry Date", '>=%1', rec."Document Date");
                            if Sadapr.FindFirst() then begin
                                if Sadapr."DBC. (DCPL Price)" <> 0 then begin
                                    rec."Direct Unit Cost" := Sadapr."DBC. (DCPL Price)";
                                    Rec.Rate := Rec.Quantity * Rec."Direct Unit Cost";
                                    //send req to purchase head
                                    linewiseappsetup.Reset();
                                    linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Price Update");
                                    if linewiseappsetup.FindFirst() then begin
                                        if linewiseappsetup.Enable = true then begin
                                            rec."Price Update Status" := rec."Price Update Status"::"Pending For Approval";
                                            Message('Approval request sent');
                                            Rec.Modify();
                                            SendEmail();
                                        end;
                                    end;
                                end;
                            end else begin
                                rec."Direct Unit Cost" := RecItem."DCPL Price" + RecItem."Margin %";
                                Rec.Rate := Rec.Quantity * Rec."Direct Unit Cost";
                                //send req to sales head
                                linewiseappsetup.Reset();
                                linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Price Update");
                                if linewiseappsetup.FindFirst() then begin
                                    if linewiseappsetup.Enable = true then begin
                                        rec."Price Update Status" := rec."Price Update Status"::"Pending For Approval";
                                        Message('Approval request sent');
                                        SendEmail1();
                                    end;
                                end;
                            end;
                        end;
                    end;

                }

                field(UOM; Rec.UOM)
                {
                    Applicationarea = All;
                    Editable = false;
                }

                field("Direct unit Cost"; Rec."Direct unit Cost")
                {
                    Caption = 'Target Price';
                    Applicationarea = All;
                    Editable = Edit;

                    trigger OnValidate()
                    var
                        RecItem: Record Item;
                    begin



                        /*
                        Linewiseapproval.Reset();
                        if Linewiseapproval."On the Basis" = Linewiseapproval."On the Basis"::"Less Margin" then
                            emailid := Linewiseapproval."Email Id";
                        Clear(SMTPMail);
                        EmailBody := ('Dear Sir' + ',');
                        EmailBody += ('<br><br>');
                        EmailBody += ('Due to margin is less Sales RFQ received for approval');
                        EmailBody += ('<br><br>');
                        EmailBody += ('<br><br>');
                        SMTPMail.Create(emailid, 'sales RFQ Document' + ' ' + '(' + Rec."RFQ Doc No." + ')', EmailBody, true);

                        SMTPMail.AppendToBody('With best regards!' + ',');
                        SMTPMail.AppendToBody('<BR>');
                        SMTPMail.AppendToBody('RK Team');
                        SMTPMail.AppendToBody('<BR><BR>');
                        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
                        Clear(Email);
                        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
*/
                    end;


                }
                field(Rate; Rec.Rate)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }
                field(Salesperson; Rec.Salesperson)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }
                field(project; Rec.project)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }
                field(Application; Rec.Application)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }
                field(LT; Rec.LT)
                {
                    Applicationarea = All;
                    Editable = Edit;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Applicationarea = All;
                }
                field("Confirm Date"; Rec."Confirm Date")
                {
                    Applicationarea = All;
                }
                field("Estimated Date"; Rec."Estimated Date")
                {
                    Applicationarea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;

                }
                field("Cost price"; Rec."Cost price")
                {
                    Applicationarea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Brand Approval Status"; Rec."Brand Approval Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Margin Less Status"; Rec."Margin Less Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Price Update Status"; Rec."Price Update Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Cancel; Rec.Cancel)
                {
                    Applicationarea = All;
                    trigger OnValidate()
                    begin

                        if xRec.Cancel = true then
                            Error('You can not untick the cancel');
                    end;

                }
                field("Cancelation reason"; Rec."Cancelation reason")
                {
                    Applicationarea = All;
                }
                field("Quote Created"; Rec."Quote Created")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
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
                        RecItem: Record Item;
                        rfqline: Record "Sales RFQ Line";
                        approvalentry: Record "Approval Entry";
                        approvalentry1: Record "Approval Entry";
                        linewiseappsetup: Record Linewiseapprovalsetup;
                    begin
                        linewiseappsetup.Reset();
                        linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Brand Approval");
                        if linewiseappsetup.FindFirst() then begin
                            if linewiseappsetup.Enable = true then begin
                                rfqline.Reset();
                                rfqline.SetRange("RFQ Doc No.", Rec."RFQ Doc No.");
                                if rfqline.FindFirst() then begin
                                    repeat
                                        if rfqline."Approval Status" <> rfqline."Approval Status"::Open then
                                            Error('Without status open, you can not send the approval');
                                        rfqline."Brand Approval Status" := rfqline."Brand Approval Status"::"Pending For Approval";
                                        rfqline.Modify();
                                    until rfqline.Next() = 0;
                                    Message('Brand Apprval Request Sent Successfully');
                                end;
                            end;
                        end;

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
                        rfqline: Record "Sales RFQ Line";
                    begin
                        if Rec."Approval Status" = rec."Approval Status"::Approved then
                            Error('status should be pending for approval');
                        rfqline.Reset();
                        rfqline.SetRange("RFQ Doc No.", Rec."RFQ Doc No.");
                        if rfqline.FindFirst() then begin
                            repeat
                                if Rec."Brand Approval Status" = Rec."Brand Approval Status"::"Pending For Approval" then begin
                                    Rec."Brand Approval Status" := Rec."Brand Approval Status"::Open;
                                    Rec.Modify();
                                end;
                            until rfqline.Next() = 0;
                            Message('Brand Apprval Request Cancel Successfully');
                        end;

                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        rfqhead: Record "Sales RFQ Header";
    begin
        Rec.Type := Rec.Type::Item;
        rfqhead.Reset();
        rfqhead.SetRange("RFQ Doc No.", Rec."RFQ Doc No.");
        if rfqhead.FindFirst() then begin
            if rfqhead."Approval Status" = rfqhead."Approval Status"::Approved then
                Error('Status should be open');
        end;
        rfqhead.Reset();
        rfqhead.SetRange("RFQ Doc No.", Rec."RFQ Doc No.");
        if rfqhead.FindFirst() then begin
            if rfqhead."Approval Status" = rfqhead."Approval Status"::"Pending For Approval" then
                Error('Status should be open');
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        if Rec."Approval Status" = Rec."Approval Status"::Open then
            Edit := true
        else
            Edit := false;


    end;



    trigger OnOpenPage()
    begin
        if Rec."Approval Status" = Rec."Approval Status"::Open then
            //    CurrPage.Editable(false);
            Edit := true
        else
            Edit := false;
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Approval Status" = Rec."Approval Status"::Open then
            //    CurrPage.Editable(false);
            Edit := true
        else
            Edit := false;

    end;

    procedure SendEmail()
    var
        linewiseappsetup: Record Linewiseapprovalsetup;
        EmailBody: Text;
        SMTPMail: Codeunit "Email Message";
        RFQHead: Record "Sales RFQ Header";
        EmailId: Code[50];
    begin
        RFQHead.Reset();
        RFQHead.SetRange("RFQ Doc No.", Rec."RFQ Doc No.");
        if RFQHead.FindFirst() then;
        linewiseappsetup.Reset();
        linewiseappsetup.SetRange("Sale RFQ Approval", true);
        linewiseappsetup.SetRange(Designation, linewiseappsetup.Designation::"Purchase Head");
        if linewiseappsetup.FindFirst() then
            EmailId := linewiseappsetup."Email Id";
        Message('%1', EmailId);
        Clear(SMTPMail);
        EmailBody := ('Dear Sir' + ',');
        EmailBody += ('<br><br>');
        EmailBody += ('You have received Brand wise apprval of item');
        EmailBody += ('<br><br>');
        EmailBody += ('For any further informationur');
        EmailBody += ('<br><br>');
        SMTPMail.Create(EmailId, 'Approval' + ' ' + '(' + RFQHead."RFQ Doc No." + ')', EmailBody, true);
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, EmailId);

        SMTPMail.AppendToBody('With best regards!' + ',');
        SMTPMail.AppendToBody('<BR>');
        SMTPMail.AppendToBody('Test');
        SMTPMail.AppendToBody('<BR><BR>');
        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
        Clear(Email);
        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Message('Brand wise approval Mail Sent');
        RFQHead."Email Sent" := TRUE;
        RFQHead.modify;


    end;

    procedure SendEmail1()
    var
        linewiseappsetup: Record Linewiseapprovalsetup;
        EmailBody: Text;
        SMTPMail: Codeunit "Email Message";
        RFQHead: Record "Sales RFQ Header";
        EmailId: Code[50];
    begin
        RFQHead.Reset();
        RFQHead.SetRange("RFQ Doc No.", Rec."RFQ Doc No.");
        if RFQHead.FindFirst() then;
        linewiseappsetup.Reset();
        linewiseappsetup.SetRange("Sale RFQ Approval", true);
        linewiseappsetup.SetRange(Designation, linewiseappsetup.Designation::"Sales Head");
        if linewiseappsetup.FindFirst() then
            EmailId := linewiseappsetup."Email Id";
        // Message('%1', EmailId);
        Clear(SMTPMail);
        EmailBody := ('Dear Sir' + ',');
        EmailBody += ('<br><br>');
        EmailBody += ('You have received Brand wise apprval of item');
        EmailBody += ('<br><br>');
        EmailBody += ('For any further informationur');
        EmailBody += ('<br><br>');
        SMTPMail.Create(EmailId, 'Approval' + ' ' + '(' + RFQHead."RFQ Doc No." + ')', EmailBody, true);
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, EmailId);

        SMTPMail.AppendToBody('With best regards!' + ',');
        SMTPMail.AppendToBody('<BR>');
        SMTPMail.AppendToBody('Test');
        SMTPMail.AppendToBody('<BR><BR>');
        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
        Clear(Email);
        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Message('Brand wise approval Mail Sent');
        RFQHead."Email Sent" := TRUE;
        RFQHead.modify;


    end;

    var
        Edit: Boolean;
        Linewiseapproval: Record Linewiseapprovalsetup;
        emailid: Code[50];
        SMTPMail: Codeunit "Email Message";
        EmailBody: Text;
        Email: Codeunit Email;
        P: Page 9006;


}

