page 50007 "Sale RFQ Order List"
{
    Caption = 'Sales RFQ List';
    CardPageID = "Sale RFQ Order";
    PageType = List;
    SourceTable = "Sales RFQ Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("RFQ Doc No."; Rec."RFQ Doc No.")
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
                field("Original Customer Name"; Rec."Original Customer Name")
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
            }
        }
    }
    actions
    {
        area(Creation)
        {
            group("Upload Data")
            {
                Caption = 'Upload Data';
                action("Import RFQ Order")
                {
                    ApplicationArea = Order;
                    Caption = 'Import RFQ Lines';
                    Image = Import;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = xmlport 50007;

                }
            }

        }
    }
    trigger OnAfterGetRecord()
    var
        UserSetRec: Record "User Setup";
    begin
        UserSetRec.Get(UserId);
        if UserSetRec."HO User" = false then begin
            rec.SetRange("Shortcut Dimension 2 Code", UserSetRec.Branch);
            Rec.SetRange(Zone, UserSetRec.Zone);
            Rec.SetRange(Salesperson, UserSetRec.Salesperson);
        end;
    end;

    trigger OnOpenPage()
    var
        UserSetRec: Record "User Setup";
    begin
        UserSetRec.Get(UserId);
        if UserSetRec."HO User" = false then begin
            rec.SetRange("Shortcut Dimension 2 Code", UserSetRec.Branch);
            Rec.SetRange(Zone, UserSetRec.Zone);
            Rec.SetRange(Salesperson, UserSetRec.Salesperson);
        end;
    end;

    var
        DocTypeOrder: Text[50];
        DocNoOrder: Code[20];
        ReqLine: Record 50001;
        PL: Record 39;
        PL1: Record 39;
        LineNo: Integer;



}

