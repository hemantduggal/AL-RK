codeunit 50038 "Approval Management Custom"
{
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendSaleRFQForApproval(Var Budgetmaster: Record "Sales RFQ Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelSaleRFQForApproval(Var BudgetMaster: Record "Sales RFQ Header")
    begin
    end;

    procedure CheckSaleRFQApprovalsWorkflowEnabled(var BudgetMaster: Record "Sales RFQ Header"): Boolean
    begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(BudgetMaster, Subscriber_CU.RunWorkflowOnSendSaleRFQDocForApprovalCode) then
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;

    var
        myInt: Integer;
        NoWorkflowEnabledErr: TextConst ENU = 'This record is not supported by related approval workflow.';
        WorkflowManagement: Codeunit "Workflow Management";
        Subscriber_CU: Codeunit 50035;

}