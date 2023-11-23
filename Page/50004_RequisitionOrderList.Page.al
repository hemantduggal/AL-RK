page 50004 "Requisition Order List"
{
    CardPageID = "Requisition Order";
    PageType = List;
    SourceTable = "Requisition Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition No."; Rec."Requisition No.")
                {
                    Applicationarea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Applicationarea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Applicationarea = All;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    Applicationarea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Applicationarea = All;
                }

            }
        }
    }

    var
        DocTypeOrder: Text[50];
        DocNoOrder: Code[20];
        ReqLine: Record 50001;
        PL: Record 39;
        PL1: Record 39;
        LineNo: Integer;



}

