codeunit 50042 "Workflow Response HandlingExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; Var Handled: Boolean)
    var
        BudgetMaster: Record "Sales RFQ Header";

    begin
        case RecRef.Number of
            DATABASE::"Sales RFQ Header":
                begin
                    RecRef.SetTable(BudgetMaster);
                    BudgetMaster."Approval Status" := BudgetMaster."Approval Status"::Open;
                    BudgetMaster.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BudgetMaster: Record "Sales RFQ Header";
    begin
        case RecRef.Number of
            DATABASE::"Sales RFQ Header":
                begin
                    RecRef.SetTable(BudgetMaster);
                    BudgetMaster."Approval Status" := BudgetMaster."Approval Status"::Approved;
                    BudgetMaster.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling"; //1521;
        WorkflowEventHandlingCust: Codeunit 50035; // 50112;
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendSaleRFQDocForApprovalCode);
                end;


            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendSaleRFQDocForApprovalCode);

                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandlingCust.RunWorkflowOnCancelSaleRFQApprovalRequestCode);
                end;
            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandlingCust.RunWorkflowOnCancelSaleRFQApprovalRequestCode);

                END;

        end;
    end;

    var
        myInt: Integer;
}