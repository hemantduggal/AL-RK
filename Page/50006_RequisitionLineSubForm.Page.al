page 50006 "Requisition Line SubForm"
{
    AutoSplitKey = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Requisition Lines";
    //ApplicationArea = All;
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
                }
                field("Item No."; Rec."Item No.")
                {
                    Applicationarea = All;
                }
                field(Description; Rec.Description)
                {
                    Applicationarea = All;
                    Editable = false;
                    Caption = 'Manufacturer Part No.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    Applicationarea = All;
                    //  Editable = false;
                    Caption = 'Description';
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
                    DecimalPlaces = 0 : 3;
                }

                field("Employee Code"; Rec."Employee Code")
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
                    ApplicationArea = all;
                }
                field("Shortcut Dimenssion 1"; Rec."Shortcut Dimenssion 1")
                {
                    // Editable = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimenssion 2"; Rec."Shortcut Dimenssion 2")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                /*
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
                */
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin

    end;

    var

}

