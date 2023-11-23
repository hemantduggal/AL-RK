page 50037 "Sales RFQ priceupdatedrequest"
{
    Caption = 'Requset To Approve Sales RFQ price updated';
    PageType = List;
    SourceTable = "Sales RFQ Line";
    SourceTableView = where("Price Update Status" = filter("Pending For Approval"));
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
                field("Item No."; Rec."Item No.")
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

                field(UOM; Rec.UOM)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Direct unit Cost"; Rec."Direct unit Cost")
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
                field(Salesperson; Rec.Salesperson)
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
                field("Design Part No."; Rec."Design Part No.")
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
                field("Price Update Status"; Rec."Price Update Status")
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
                    Rec."Price Update Status" := Rec."Price Update Status"::Approved;
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


                    Rec."Price Update Status" := Rec."Price Update Status"::Open;
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
        /*
                BrandMaster.Reset();
                BrandMaster.SetRange("User Id", UserId);
                BrandMaster.SetRange("Approver 1", true);
                if BrandMaster.FindFirst() then;
                rec.SetRange(rec.Brand, BrandMaster.Code);
                Rec.SetRange(Salesperson, BrandMaster."Sales Person");
        */
    end;

    trigger OnAfterGetRecord()
    var
        BrandMaster: Record "Brand Master";
    begin
        flag := false;

        /*
    BrandMaster.Reset();
    BrandMaster.SetRange("User Id", UserId);
    BrandMaster.SetRange("Approver 1", true);
    if BrandMaster.FindFirst() then;
    rec.SetRange(rec.Brand, BrandMaster.Code);
    Rec.SetRange(Salesperson, BrandMaster."Sales Person");
    */
    END;

    var
        flag: Boolean;
}
