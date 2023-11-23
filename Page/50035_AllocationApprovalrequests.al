page 50035 "Allocation Approval Requests"
{
    Caption = 'Sales Quote Allocation Approval Requests';
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = where("Allocation Status" = filter("Pending For Approval"), "Document Type" = filter(Quote));
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Applicationarea = All;
                    Editable = false;
                }

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(Rate; Rec.Rate)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(Brand; Rec.Brand)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Margin is Less"; Rec."Margin is Less")
                {
                    Applicationarea = All;
                    Editable = false;
                }

                field("RFQ Doc No."; Rec."RFQ Doc No.")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(project; Rec.project)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(SPQ; Rec.SPQ)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(MOQ; Rec.MOQ)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(LT; Rec.LT)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Allocation Status"; Rec."Allocation Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    // Editable = flag;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve';
                Image = Approve;
                ToolTip = 'Approve';

                trigger OnAction()
                var
                begin
                    Rec."Allocation Status" := Rec."Allocation Status"::Approved;
                    Rec.Modify();
                    Message('Request approved');
                END;
            }

            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Enabled = true;
                Image = Reject;
                ToolTip = 'Reject';
                Visible = true;

                trigger OnAction()
                var
                begin
                    flag := true;

                    if Rec.Remarks = '' then
                        Error('Remarks is mendotory for rejection');
                    Rec.TestField(Remarks);
                    Rec."Allocation Status" := Rec."Allocation Status"::Open;
                    Rec.Modify();


                    Message('Request Rejected');
                end;
            }

        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Error('You can not create new record from here');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Error('You can not create new record from here');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Error('You can not create new record from here');

    end;

    trigger OnOpenPage()
    var
        BrandMaster: Record "Brand Master";
    begin
        flag := false;

    end;

    trigger OnAfterGetRecord()
    var
        BrandMaster: Record "Brand Master";
    begin
        flag := false;


    END;

    var
        flag: Boolean;
}

