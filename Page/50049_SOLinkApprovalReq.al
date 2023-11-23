page 50049 "SO Link Approval Request"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "FAE Line";
    SourceTableView = where("SO Link Approval Status" = filter("Pending For Approval"));
    UsageCategory = Documents;
    AutoSplitKey = true;
    MultipleNewLines = true;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Assembly No."; Rec."Assembly No.")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Assembly No. field.';
                }
                field("Assembly Name"; Rec."Assembly Name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Assembly Name field.';
                }
                field(UOM; Rec.UOM)
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the UOM field.';
                }
                field(Brand; Rec.Brand)
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Brand field.';
                }
                field("Assembly Id"; Rec."Assembly Id")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Assembly Id field.';
                }
                field("Confiednece %"; Rec."Confiednece %")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Confiednece % field.';
                }
                field(Currency; Rec.Currency)
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }

                field("Customer name"; Rec."Customer name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Customer name field.';
                }
                field("Design Registration Number"; Rec."Design Registration Number")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Design Registration Number field.';
                }
                field("Design Support Team"; Rec."Design Support Team")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Design Support Team field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                }
                field("Forecasted Qty Year1"; Rec."Forecasted Qty Year1")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Forecasted Qty Year1 field.';
                }
                field("Forecasted Qty Year2"; Rec."Forecasted Qty Year2")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Forecasted Qty Year2 field.';
                }
                field("Forecasted Qty Year3"; Rec."Forecasted Qty Year3")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Forecasted Qty Year3 field.';
                }
                field("Forecasted Value Year1"; Rec."Forecasted Value Year1")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Forecasted Value Year1 field.';
                }
                field("Forecasted Value Year2"; Rec."Forecasted Value Year2")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Forecasted Value Year2 field.';
                }
                field("Forecasted Value Year3"; Rec."Forecasted Value Year3")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Forecasted Value Year3 field.';
                }
                field("Lifetime Year"; Rec."Lifetime Year")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Lifetime Year field.';
                }
                field("Line no."; Rec."Line no.")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Line no. field.';
                }
                field("Main/Alternative Part"; Rec."Main/Alternative Part")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Main/Alternative Part field.';
                }
                field(Margin; Rec.Margin)
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Margin field.';
                }
                field("Opportunity Document No."; Rec."Opportunity Document No.")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Opportunity Document No. field.';
                }
                field("Opportunity Status"; Rec."Opportunity Status")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Opportunity Status field.';
                }
                field("Phase Description"; Rec."Phase Description")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Phase Description field.';
                }
                field("Price per Unit"; Rec."Price per Unit")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Price per Unit field.';
                }
                field("Production Date"; Rec."Production Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Production Date field.';
                }
                field("Project Phase"; Rec."Project Phase")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Project Phase field.';
                }
                field("Prototype Date"; Rec."Prototype Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Prototype Date field.';
                }
                field("Qty per ASM"; Rec."Qty per ASM")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Qty per ASM field.';
                }
                field("Quantity"; Rec."Quantity")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Quantity  field.';
                }
                field("Sample Item"; Rec."Sample Item")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Sample Item field.';
                }
                field("Sample Sent Date"; Rec."Sample Sent Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Sample Sent Date field.';
                }
                field("Annual Value"; Rec."Annual Value")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Annual Value field.';
                }
                field("SO Link Approval Status"; Rec."SO Link Approval Status")
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
            action(Approve)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve';
                Image = Approve;

                trigger OnAction()
                var
                begin

                    if Rec."SO Link Approval Status" = Rec."SO Link Approval Status"::"Pending For Approval" then
                        Rec."SO Link Approval Status" := Rec."SO Link Approval Status"::Approved;
                    Rec.Modify();
                END;
            }

            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Enabled = true;
                Image = Reject;
                Visible = true;

                trigger OnAction()
                var
                begin

                    //  if Rec.Remarks = '' then
                    //   Error('Remarks is mendotory for rejection');
                    if Rec."SO Link Approval Status" = Rec."SO Link Approval Status"::"Pending For Approval" then
                        Rec."SO Link Approval Status" := Rec."SO Link Approval Status"::Open;
                    Rec.Modify();
                end;
            }

        }
    }

}
