page 50025 BrandMaster
{
    ApplicationArea = All;
    Caption = 'BrandMaster';
    PageType = List;
    SourceTable = "Brand Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = all;
                }
                field("Sales Person"; Rec."Sales Person")
                {
                    ApplicationArea = all;
                }
                field("Brand Owner"; Rec."Brand Owner")
                {
                    ToolTip = 'Specifies the value of the Brand Owner field.';
                }

                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(Email2; Rec.Email2)
                {
                    ToolTip = 'Specifies the value of the Email2 field.';
                }
                field(Email3; Rec.Email3)
                {
                    ToolTip = 'Specifies the value of the Email3 field.';
                }
                field(Email4; Rec.Email4)
                {
                    ToolTip = 'Specifies the value of the Email4 field.';
                }
                field(Email5; Rec.Email5)
                {
                    ToolTip = 'Specifies the value of the Email5 field.';
                }
                field("Type of Notification"; Rec."Type of Notification")
                {
                    ToolTip = 'Specifies the value of the Type of Notification field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = all;
                }
                field("Approver 1"; Rec."Approver 1")
                {
                    ApplicationArea = all;
                }
                field("Approver 2"; Rec."Approver 2")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
