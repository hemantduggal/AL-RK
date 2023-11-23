page 50028 "RFQ Planning Lines"
{

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SalesRFQ Planning  Line";
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
            field(SalepersonCode; SalepersonCode)
            {
                Caption = 'Salesperson Code';
                ApplicationArea = all;
                TableRelation = "Salesperson/Purchaser".Code;
            }
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    Applicationarea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                }
                field(Description; Rec.Description)
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Applicationarea = All;
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
                field(Rate; Rec.Rate)
                {
                    Applicationarea = All;
                }
                field(Brand; Rec.Brand)
                {
                    Applicationarea = All;
                }
                field(Salesperson; Rec.Salesperson)
                {
                    Applicationarea = All;

                }
                field(Application; Rec.Application)
                {
                    Applicationarea = All;

                }

                field("Cost price"; Rec."Cost price")
                {
                    Applicationarea = All;
                }
                field("Design Part No."; Rec."Design Part No.")
                {
                    Applicationarea = All;
                }
                field("RFQ Doc No."; Rec."RFQ Doc No.")
                {
                    Applicationarea = All;
                }
                field(project; Rec.project)
                {
                    Applicationarea = All;
                }

                field("Replenishment Type"; Rec."Replenishment Type")
                {
                    Applicationarea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Insert RFQ Planning Lines")
            {
                ApplicationArea = all;
                Image = Insert;
                trigger OnAction()
                var
                    PurchaseIndentPost: Codeunit 50001;
                begin
                    PurchaseIndentPost.CalculateRFQPlanLine(LocCode, SalepersonCode);
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

                    PurchaseIndentPost.CreatesalesQuote();
                    PurchaseIndentPost.CreatesalesOrder();
                end;
            }
        }
    }
    var
        LocCode: Code[20];
        SalepersonCode: Code[30];
}