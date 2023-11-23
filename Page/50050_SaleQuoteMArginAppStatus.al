page 50050 "MarginApprovalReq"
{
    Caption = 'Sales Lines Approval Request';
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = where("Margin Status" = filter("Pending For Approval"));
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
                field("Item No."; Rec."No.")
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

                field(Quantity; Rec.Quantity)
                {
                    Applicationarea = All;
                    Editable = false;
                }

                field("Customer Name"; Rec."Customer Name")
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
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field(Application; Rec.Application)
                {
                    Applicationarea = All;
                    Editable = false;
                }

                field("Cost price"; Rec."Cost price")
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
                field("Margin Status"; Rec."Margin Status")
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
                    Rec."Margin Status" := Rec."Margin Status"::Approved;
                    Rec.Modify();
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


                    Rec."Margin Status" := Rec."Margin Status"::Open;
                    Rec.Modify();
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

