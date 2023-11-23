codeunit 50035 WorkflowEventExt
{
    trigger OnRun()
    begin

    end;
    ///code for SalesRFQ
    procedure RunWorkflowOnSendSaleRFQDocForApprovalCode(): code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendSaleRFQDocForApproval'));
    end;

    procedure RunWorkflowOnCancelSaleRFQApprovalRequestCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelSaleRFQApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleaseSaleRFQDocCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseSaleRFQDoc'));
    end;

    ///code for SalesRFQ

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; Var Variant: Variant; Var IsHandled: Boolean)
    var
        Budgetmaster: Record "Sales RFQ Header";

    begin
        case RecRef.Number of
            DATABASE::"Sales RFQ Header":
                begin
                    RecRef.SetTable(Budgetmaster);
                    //   Message('%1', Budgetmaster."Budget No.");
                    Budgetmaster."Approval Status" := Budgetmaster."Approval Status"::"Pending For Approval";
                    // Budgetmaster."User ID" := UserId;
                    Budgetmaster.Modify;
                    Variant := Budgetmaster;
                    IsHandled := true;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        Budgetmaster: Record "Sales RFQ Header";
        VarFilter: Text;
        EmployeeCodeVar: Code[30];
        EntryNoVarText: Text;
        EntryNoVar: Integer;
        approvalm: Codeunit "Approvals Mgmt.";
    begin
        case ApprovalEntry."Table ID" of
            DATABASE::"Sales RFQ Header":
                begin
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");

                    // EmployeeCodeVar := SelectStr(2, VarFilter);
                    // EntryNoVarText := SelectStr(2, DelChr(CONVERTSTR(SelectStr(1, VarFilter), ':', ','), '=', ' '));
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EmployeeCodeVar := CopyStr(VarFilter, 15, StrLen(VarFilter));
                    budgetMaster.reset();
                    budgetMaster.SetRange("RFQ Doc No.", EntryNoVarText);
                    budgetMaster.SetRange("Approval Status", budgetMaster."Approval Status"::"Pending For Approval");
                    if budgetMaster.FindFirst() then begin
                        budgetMaster."Approval Status" := budgetMaster."Approval Status"::Open;
                        budgetMaster.Modify();
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        Budgetmaster: Record "Sales RFQ Header";
        VarFilter: Text;
        EmployeeCodeVar: Code[30];
        EntryNoVarText: Text;
        EntryNoVar: Integer;
        approvalm: Codeunit "Approvals Mgmt.";
        AppEnRec: Record "Approval Entry";
    begin
        case ApprovalEntry."Table ID" of
            DATABASE::"Sales RFQ Header":
                begin
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EntryNoVarText := CopyStr(VarFilter, 37, StrLen(VarFilter));
                    budgetMaster.reset();
                    budgetMaster.SetRange(budgetMaster."RFQ Doc No.", EntryNoVarText);
                    budgetMaster.SetRange("Approval Status", budgetMaster."Approval Status"::"Pending For Approval");
                    if budgetMaster.FindFirst() then begin
                        budgetMaster."Approval Status" := budgetMaster."Approval Status"::Approved;
                        budgetMaster.Modify();
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    Procedure AddEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendSaleRFQDocForApprovalCode, DATABASE::"Sales RFQ Header", 'Approval of a SaleRFQ Header is requested.', 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSaleRFQApprovalRequestCode, DATABASE::"Sales RFQ Header", 'An Approval request for a SaleRFQ Header is cancelled.', 0, FALSE);

    end;

    //////////////// SaleRFQ
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnSendSaleRFQForApproval', '', false, false)]

    Procedure RunWorkflowOnSendSaleRFQrequestForApproval(var Budgetmaster: Record "Sales RFQ Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSaleRFQDocForApprovalCode, Budgetmaster);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelSaleRFQForApproval', '', false, false)]
    Procedure RunWorkflowOnCancelSaleRFQrequestApprovalRequest(var Budgetmaster: Record "Sales RFQ Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSaleRFQApprovalRequestCode, Budgetmaster);
    end;

    /// ///////// SaleRFQ  WIN-5HVHINP46QL\ADMINISTRATOR





    //////Start code open page from approval entry
    // Start Pru Sh20042022
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]

    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    var

    begin
        if PageID = 0 then;
        PageID := GetConditionalCardPageID(RecordRef);
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        case RecordRef.Number of
            Database::"Sales RFQ Header":
                exit(Page::"Sale RFQ Order");

        end;
    end;
    // End Pru Sh20042022
    /*

        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
        local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry")
        var
            BudRec: Record "Budget Header";

        begin
            case RecRef.Number of
                Database::"Budget Header":
                    begin
                        RecRef.SetTable(BudRec);
                        ApprovalEntryArgument.Amount := BudRec."Total Budget";
                    end;
            end;
        end;


        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', true, true)]
        local procedure "Approvals Mgmt._OnBeforeApprovalEntryInsert"
        (
            var ApprovalEntry: Record "Approval Entry";
            ApprovalEntryArgument: Record "Approval Entry"
        )
        begin
            ApprovalEntry.Amount := ApprovalEntryArgument.Amount;

        end;

    */



    var
        myInt: Integer;

        worlfloeeven: Codeunit 1520;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        pageMgt: Codeunit "Page Management";





}