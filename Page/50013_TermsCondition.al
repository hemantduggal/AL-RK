page 50013 "TermsConditionCard"
{
    Caption = 'T&C Card';
    PageType = Document;
    // ApplicationArea = All;
    //  UsageCategory = Administration;
    SourceTable = "Terms Condition Header";


    layout
    {
        area(Content)
        {
            group(General)
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

            part(TermsConditionSubform; "Terms Condition Subform")
            {
                ApplicationArea = Basic, Suite;
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("No.");
                Visible = true;
                Editable = true;
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