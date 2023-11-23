page 50065 Customer_Contact_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer_Contact;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;

                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;

                }
                field("E mail"; Rec."E mail")
                {
                    ApplicationArea = All;

                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;

                }
                /*
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                */
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}