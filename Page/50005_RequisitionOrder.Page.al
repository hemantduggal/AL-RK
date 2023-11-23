page 50005 "Requisition Order"
{
    PageType = Document;
    SourceTable = "Requisition Header";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Requisition No."; Rec."Requisition No.")
                {
                    Applicationarea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Applicationarea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Applicationarea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Applicationarea = All;
                }
                /*
                field("Department Code"; Rec."Department Code")
                {
                    Applicationarea = All;
                }
*/
                field("Posting Date"; Rec."Posting Date")
                {
                    Applicationarea = All;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    Applicationarea = All;
                }
                field("To Location"; Rec."To Location")

                {
                    Applicationarea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Applicationarea = All;
                }
                field("Shortcut Dimenssion 1"; Rec."Shortcut Dimenssion 1")
                {
                    ApplicationArea = all;
                    //Editable = flag;
                }
                field("Shortcut Dimenssion 2"; Rec."Shortcut Dimenssion 2")
                {
                    ApplicationArea = all;
                    //Editable = flag;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; 50006)
            {
                ApplicationArea = all;
                SubPageLink = "Requisition No." = FIELD("Requisition No.");
            }
        }

    }


    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."User ID" := UserId;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User ID" := UserId;
    end;

    var

}

