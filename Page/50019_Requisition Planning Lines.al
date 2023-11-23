page 50019 "Requisition Planning Lines"
{

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Requisition Planning Lines";
    Editable = true;

    layout
    {
        area(content)
        {
            field(LocCode; LocCode)
            {
                Caption = 'Location Code';
                ApplicationArea = all;
                TableRelation = Location.Code;
            }
            field(DeptCode; DeptCode)
            {
                Caption = 'User Code';
                ApplicationArea = all;
                // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                // CaptionClass = '1,2,1';
                TableRelation = "User Setup"."User ID";
            }
            repeater(Control1)
            {
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                }
                field(Description; Rec.Description)
                {
                    Applicationarea = All;
                    Editable = false;
                }

                field(Quantity; Rec.Quantity)
                {
                    Applicationarea = All;
                }

                field(UOM; Rec.UOM)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Direct unit Cost"; Rec."Direct unit Cost")
                {
                    Applicationarea = All;
                }

                field("Employee Code"; Rec."Employee Code")
                {
                    Applicationarea = All;
                }
                field(Rate; Rec.Rate)
                {
                    Applicationarea = All;

                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    Applicationarea = All;

                }
                field("Line No."; Rec."Line No.")
                {
                    Applicationarea = All;
                }
                field(Brand; Rec.Brand)
                {
                    Applicationarea = All;

                }
                field(POP; Rec.POP)
                {
                    Applicationarea = All;
                }
                field(BQ; Rec.BQ)
                {
                    Applicationarea = All;
                }
                field(Application; Rec.Application)
                {
                    Applicationarea = All;
                }
                field(project; Rec.project)
                {
                    Applicationarea = All;
                }
                field(Customer; Rec.Customer)
                {
                    Applicationarea = All;
                }
                field(LT; Rec.LT)
                {
                    Applicationarea = All;
                }
                field(SPQ; Rec.SPQ)
                {
                    Applicationarea = All;
                }
                field(MOQ; Rec.MOQ)
                {
                    Applicationarea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimenssion 1"; Rec."Shortcut Dimenssion 1")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimenssion 2"; Rec."Shortcut Dimenssion 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Replenishment Type"; Rec."Replenishment Type")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Insert Requisition Planning Lines")
            {
                ApplicationArea = all;
                Image = Insert;
                trigger OnAction()
                var
                    PurchaseIndentPost: Codeunit 50001;
                begin
                    PurchaseIndentPost.CalculateReqPlanLine(LocCode, DeptCode);
                end;
            }
            action("Make Order")
            {
                ApplicationArea = all;
                Image = Calculate;
                trigger OnAction()
                var
                    PurchaseIndentPost: Codeunit 50001;
                begin
                    PurchaseIndentPost.CreateBlanketOrder();
                    PurchaseIndentPost.CreatePurchaseQuote();
                    PurchaseIndentPost.CreatePurchaseOrder();
                    // PurchaseIndentPost.CreateTransferOrder();
                    //PurchaseIndentPost.CreateFAJournal();
                    rec.DeleteAll();
                end;
            }
        }
    }







    var
        LocCode: Code[20];
        DeptCode: Code[30];

}

