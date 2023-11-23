page 50031 "FAE card"
{
    ApplicationArea = All;
    Caption = 'FAE card';
    PageType = Card;
    SourceTable = "FAE Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Opportunity Document No."; Rec."Opportunity Document No.")
                {
                    Applicationarea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Applicationarea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Applicationarea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Applicationarea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Applicationarea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Applicationarea = All;
                }
                field("Account Manager"; Rec."Account Manager")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Account Manager field.';
                }
                field("Customer Buyer"; Rec."Customer Buyer")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Customer Buyer field.';
                }
                field("Customer Buyer E-mail"; Rec."Customer Buyer E-mail")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Customer Buyer E-mail field.';
                }
                field("Design RegistrationProjectName"; Rec."Design RegistrationProjectName")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Design Registration Project Name field.';
                }
                field("Opportunity Date"; Rec."Opportunity Date")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Opportunity Date field.';
                }

                field("Opportunity Status"; Rec."Opportunity Status")
                {
                    Applicationarea = All;
                    Editable = false;
                }
                field("Product Segment"; Rec."Product Segment")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Product Segment field.';
                }
                field("Production Project Name"; Rec."Production Project Name")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Production Project Name field.';
                }
                field("Program/Lead"; Rec."Program/Lead")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Program/Lead field.';
                }
                field("Project Created By(User Name)"; Rec."Project Created By(User Name)")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Project Created By(User Name) field.';
                }
                field("Project Created On"; Rec."Project Created On")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Project Created On(Document Creation Date) field.';
                }
                field("Project Description"; Rec."Project Description")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Project Description field.';
                }
                field("Sales Organization"; Rec."Sales Organization")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Sales Organization field.';
                }
                field("Support FAE"; Rec."Support FAE")
                {
                    Applicationarea = All;
                    ToolTip = 'Specifies the value of the Support FAE field.';
                }
                field("Sale Order No."; Rec."Sale Order No.")
                {
                    Applicationarea = All;
                }

            }
            part(Lines; 50032)
            {
                Applicationarea = All;
                SubPageLink = "Opportunity Document No." = FIELD("Opportunity Document No.");
            }
        }
    }

    trigger OnOpenPage()
    var
        SH: Record "Sales Header";
        days: Integer;
        RemainDays: Integer;
        day1: Integer;
    begin
        if Rec."Opportunity Date" <> 0D then begin
            days := Date2DMY(Rec."Opportunity Date", 1);
            RemainDays := Today - Rec."Opportunity Date";
            // Message('%1....%2..', days, RemainDays);
            if RemainDays > 90 then begin
                Rec."Opportunity Status" := Rec."Opportunity Status"::Closed;
                Rec.Modify();
            end;
        end;
    end;
}
