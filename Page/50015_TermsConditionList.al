page 50015 "TermsConditionList"
{
    Caption = 'T&C Master List';
    PageType = List;
    ApplicationArea = All;
    CardPageId = TermsConditionCard;
    UsageCategory = Administration;
    SourceTable = "Terms Condition Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
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
        }
    }

    trigger OnOpenPage()
    begin



    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        DynamicEditable: Boolean;
        SO: Page "Sales Order";
        LocCode: Code[20];
        ReqWor: Page "Req. Worksheet";

}