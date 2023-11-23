table 50026 "FAE Line"
{
    Caption = 'FAE Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Opportunity Document No."; Code[20])
        {
            Caption = 'Opportunity Document No.';
            DataClassification = ToBeClassified;

        }
        field(2; "Line no."; Integer)
        {
            Caption = 'Line no.';
            DataClassification = ToBeClassified;
        }

        field(3; UOM; Code[20])
        {
            Caption = 'UOM';
            DataClassification = ToBeClassified;

        }
        field(4; "Sample Item"; Boolean)
        {
            Caption = 'Sample Item';
            DataClassification = ToBeClassified;
        }
        field(5; "Sample Sent Date"; Date)
        {
            Caption = 'Sample Sent Date';
            DataClassification = ToBeClassified;
        }
        field(6; Currency; Code[10])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }
        field(7; "Lifetime Year"; Integer)
        {
            Caption = 'Lifetime Year';
            DataClassification = ToBeClassified;
        }
        field(8; Brand; Code[20])
        {
            Caption = 'Brand';
            DataClassification = ToBeClassified;
            TableRelation = "Brand Master".Code;
        }
        field(9; "Prototype Date"; Date)
        {
            Caption = 'Prototype Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Production Date"; Date)
        {
            Caption = 'Production Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Project Phase"; Option)
        {
            Caption = 'Project Phase';
            DataClassification = ToBeClassified;
            OptionMembers = ,"D-Lost","D-Qualification","D-In","D-Proto","D-Win";
        }
        field(12; "Phase Description"; Text[50])
        {
            Caption = 'Phase Description';
            DataClassification = ToBeClassified;
        }
        field(13; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            DecimalPlaces = 0 : 3;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Quantity <> 0) AND ("Forecasted Qty Year1" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year1" := "Quantity" * "Forecasted Qty Year1" * "Direct Unit Cost";
                if (Quantity <> 0) AND ("Forecasted Qty Year2" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year2" := "Quantity" * "Forecasted Qty Year2" * "Direct Unit Cost";
                if (Quantity <> 0) AND ("Forecasted Qty Year3" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year3" := "Quantity" * "Forecasted Qty Year3" * "Direct Unit Cost";
            end;
        }
        field(14; "Forecasted Qty Year1"; Integer)
        {
            Caption = 'Forecasted Qty Year1';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Quantity <> 0) AND ("Forecasted Qty Year1" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year1" := "Quantity" * "Forecasted Qty Year1" * "Direct Unit Cost";
            end;
        }
        field(15; "Forecasted Qty Year2"; Integer)
        {
            Caption = 'Forecasted Qty Year2';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Quantity <> 0) AND ("Forecasted Qty Year2" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year2" := "Quantity" * "Forecasted Qty Year2" * "Direct Unit Cost";
            end;
        }
        field(16; "Forecasted Qty Year3"; Integer)
        {
            Caption = 'Forecasted Qty Year3';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Quantity <> 0) AND ("Forecasted Qty Year3" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year3" := "Quantity" * "Forecasted Qty Year3" * "Direct Unit Cost";
            end;
        }
        field(17; "Forecasted Value Year1"; Decimal)
        {
            Caption = 'Forecasted Value Year1';
            DataClassification = ToBeClassified;

        }
        field(18; "Forecasted Value Year2"; Decimal)
        {
            Caption = 'Forecasted Value Year2';
            DataClassification = ToBeClassified;
        }
        field(19; "Forecasted Value Year3"; Decimal)
        {
            Caption = 'Forecasted Value Year3';
            DataClassification = ToBeClassified;
        }
        field(20; "Main/Alternative Part"; Option)
        {
            Caption = 'Main/Alternative Part';
            DataClassification = ToBeClassified;
            OptionMembers = ,A,M;
        }
        field(21; "Qty per ASM"; Decimal)
        {
            Caption = 'Qty per ASM';
            DataClassification = ToBeClassified;

        }
        field(22; "Confiednece %"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","25","50","75","100";
        }
        field(23; Margin; Decimal)
        {
            Caption = 'Margin';
            DataClassification = ToBeClassified;
        }
        field(24; "Price per Unit"; Decimal)
        {
            Caption = 'Price per Unit';
            DataClassification = ToBeClassified;
        }
        field(25; "Annual Value"; Decimal)
        {
            Caption = 'Annual Value';
            DataClassification = ToBeClassified;
        }
        field(26; "Design Registration Number"; Code[40])
        {
            Caption = 'Design Registration Number';
            DataClassification = ToBeClassified;
        }
        field(27; "Design Support Team"; Text[50])
        {
            Caption = 'Design Support Team';
            DataClassification = ToBeClassified;
        }
        field(28; "Customer No."; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                RecCust: Record Customer;
            begin
                RecCust.Reset();
                RecCust.Get("Customer No.");
                "Customer Name" := RecCust.Name;
            end;
        }
        field(29; "Customer name"; Text[100])
        {
            Caption = 'Customer name';
            DataClassification = ToBeClassified;
        }
        field(30; "Assembly Id"; Integer)
        {
            Caption = 'Assembly Id';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                fahead: Record "FAE Header";
            begin
                fahead.Reset();
                fahead.SetRange("Opportunity Document No.", "Opportunity Document No.");
                if fahead.FindFirst() then begin
                    "Customer No." := fahead."Customer No.";
                    "Customer name" := fahead."Customer Name";
                end;
            end;
        }
        field(31; "Quantity"; Decimal)
        {
            Caption = 'Quantity ';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Quantity <> 0) AND ("Forecasted Qty Year1" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year1" := "Quantity" * "Forecasted Qty Year1" * "Direct Unit Cost";
                if (Quantity <> 0) AND ("Forecasted Qty Year2" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year2" := "Quantity" * "Forecasted Qty Year2" * "Direct Unit Cost";
                if (Quantity <> 0) AND ("Forecasted Qty Year3" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Forecasted Value Year3" := "Quantity" * "Forecasted Qty Year3" * "Direct Unit Cost";

                if (Quantity <> 0) AND ("Forecasted Qty Year2" <> 0) AND ("Direct Unit Cost" <> 0) then
                    "Annual Value" := "Quantity" * "Forecasted Qty Year2" * "Direct Unit Cost";
            end;
        }
        field(32; "Assembly No."; Code[50])
        {
            Caption = 'Assembly No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                RecItem: Record Item;
                FAEHead: Record "FAE Header";
                FAELine: Record "FAE Line";
            begin
                RecItem.Reset();
                RecItem.SetRange("No.", "Assembly No.");
                if RecItem.FindFirst() then begin
                    "Assembly Name" := RecItem.Description;
                    UOM := RecItem."Base Unit of Measure";
                    Brand := RecItem.Brand;
                end;

                /*
                                FAEHead.Reset();
                                FAELine.Reset();
                                FAELine.SetRange("Assembly No.", "Assembly No.");
                                FAELine.SetRange("Customer No.", "Customer No.");
                                FAELine.SetFilter("Opportunity Document No.", '<>%1', "Opportunity Document No.");
                                if FAELine.FindFirst() then begin
                                    FAEHead.SetRange("Opportunity Document No.", FAELine."Opportunity Document No.");
                                    if FAEHead.FindFirst() then begin
                                        if FAEHead."Opportunity Status" IN ["Opportunity Status"::Approved, "Opportunity Status"::Win, "Opportunity Status"::pending] then
                                            Error('Opportunity already exist with the same line item');
                                    end;
                                end;
                                */
            end;
        }
        field(33; "Assembly Name"; Text[100])
        {
            Caption = 'Assembly Name';
            DataClassification = ToBeClassified;
        }
        field(34; "Opportunity Status"; Option)
        {
            OptionMembers = " ",pending,Approved,Reject,Closed,Win,Lost;
            DataClassification = ToBeClassified;
        }
        field(35; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            trigger OnValidate()
            var
                SH: Record "Sales Header";
                days: Integer;
                RemainDays: Integer;
                day1: Integer;
                FAEHead: Record "FAE Header";
                FAELine: Record "FAE Line";
            begin


                /*
                                SH.Reset();
                                SH.SetRange("No.", Rec."Sale Order No.");
                                if SH.FindFirst() then begin
                                    days := Date2DMY(SH."Document Date", 1);
                                    RemainDays := Today - SH."Document Date";
                                    // Message('%1....%2..', days, RemainDays);
                                    if RemainDays > 30 then begin
                                        Error('You cannot link so to the respective opportunity after 30 days of SO creation');
                                    end else begin
                                        FAEHead.Reset();
                                        FAELine.Reset();
                                        FAELine.SetRange("Assembly No.", "Assembly No.");
                                        FAELine.SetRange("Customer No.", "Customer No.");
                                        FAELine.SetFilter("Opportunity Document No.", '<>%1', "Opportunity Document No.");
                                        if FAELine.FindFirst() then begin
                                            "SO Link Approval Status" := "SO Link Approval Status"::"Pending For Approval";
                                            Message('SO Link Approval Request send');
                                            SendEmail();
                                        end;
                                    end;
                                end;
                                */
            end;

        }
        field(36; "FAE Line Approval Status"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending For Approval",Approved;

        }
        field(37; "SO Link Approval Status"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending For Approval",Approved;

        }
        field(38; "Line Version Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(39; Region; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",East,West,North,South;

        }
        field(40; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;

        }
    }


    keys
    {
        key(PK; "Opportunity Document No.", "Line no.")
        {
            Clustered = true;
        }
    }
    procedure SendEmail()
    var
        linewiseappsetup: Record Linewiseapprovalsetup;
        EmailBody: Text;
        FAEHead: Record "FAE Header";
        SMTPMail: Codeunit "Email Message";
        EmailId: Code[50];
        Email: Codeunit Email;
    begin
        /*
        FAEHead.Reset();
        FAEHead.SetRange("Opportunity Document No.", Rec."Opportunity Document No.");
        if FAEHead.FindFirst() then;

        EmailId := '';



        Clear(SMTPMail);
        EmailBody := ('Dear Sir' + ',');
        EmailBody += ('<br><br>');
        EmailBody += ('You have received Brand wise apprval of item');
        EmailBody += ('<br><br>');
        EmailBody += ('For any further informationur');
        EmailBody += ('<br><br>');
        SMTPMail.Create(EmailId, 'Approval' + ' ' + '(' + FAEHead."Opportunity Document No." + ')', EmailBody, true);
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, EmailId);

        SMTPMail.AppendToBody('With best regards!' + ',');
        SMTPMail.AppendToBody('<BR>');
        SMTPMail.AppendToBody('Test');
        SMTPMail.AppendToBody('<BR><BR>');
        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
        Clear(Email);
        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Message('SO Link approval Mail Sent');
        */
    end;

}
