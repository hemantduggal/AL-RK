pageextension 50011 CustomerCardExt1 extends "Customer Card"
{
    layout
    {

        modify(ContactName)
        {

            trigger OnLookup(var Text: Text): Boolean
            var
                custcont: record Customer_Contact;
                CustContPage: Page Customer_Contact_Page;
            begin
                custcont.Reset();
                custcont.SetRange("Customer No.", Rec."No.");
                CustContPage.SETTABLEVIEW(custcont);
                CustContPage.LOOKUPMODE(TRUE);
                if (CustContPage.RunModal() = Action::LookupOK) then begin
                    CustContPage.GetRecord(custcont);
                    Rec.Contact := custcont.Name;
                end;
            end;

        }

        addafter("Salesperson Code")
        {

            field(Remarks; Rec.Remarks)
            {
                Applicationarea = All;
            }
            field("Owner Name"; Rec."Owner Name")
            {
                Applicationarea = All;
            }
            field("Contact No.1"; Rec."Contact No.1")
            {
                Applicationarea = All;
            }
            field("Contact No.2"; Rec."Contact No.2")
            {
                Applicationarea = All;
            }

            field("Contact No.3"; Rec."Contact No.3")
            {
                Applicationarea = All;
            }
            field("Old Salesperson"; Rec."Old Salesperson")
            {
                Applicationarea = All;
                Caption = 'Old Salesperson';
            }
            field("Account Person Name"; Rec."Account Person Name")
            {
                Applicationarea = All;
            }

            field("Emal-Id 1"; Rec."Emal-Id 1")
            {
                Applicationarea = All;
            }
            field("Emal-Id 2"; Rec."Emal-Id 2")
            {
                Applicationarea = All;
            }
            field("Purchase person"; Rec."Purchase person")
            {
                Applicationarea = All;
                Caption = 'Purchase Person';
            }

            field("Tender No."; Rec."Tender No.")
            {
                Applicationarea = All;
            }
            field("Tender Date"; Rec."Tender Date")
            {
                Applicationarea = All;
            }
            field("Email id"; Rec."Email id")
            {
                Applicationarea = All;
            }
            field("PAN No."; Rec."PAN No.")
            {
                Applicationarea = All;
            }
            field(Zone; Rec.Zone)
            {
                Applicationarea = All;
            }
            field("TAN No."; Rec."TAN No.")
            {
                Applicationarea = All;
            }
            field("MSME No."; Rec."MSME No.")
            {
                Applicationarea = All;
            }
            field("TDS Declaration"; Rec."TDS Declaration")
            {
                Applicationarea = All;
            }
            field("Credit Limit Remaining"; Rec."Credit Limit Remaining")
            {
                Applicationarea = All;
            }
            field("TemporaryCrPeriod(From Date)"; Rec."TemporaryCrPeriod(From Date)")
            {
                Applicationarea = All;
            }
            field("TemporaryCrPeriod(To Date)"; Rec."TemporaryCrPeriod(To Date)")
            {
                Applicationarea = All;
            }
            field("Remaining Credit Limit"; Rec."Remaining Credit Limit")
            {
                Applicationarea = All;
            }
            field("Temporary Credit Limit"; Rec."Temporary Credit Limit")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin
                    Rec.TestField("TemporaryCrPeriod(From Date)");
                    Rec.TestField("TemporaryCrPeriod(To Date)");
                end;
            }
            field("Freight Term"; Rec."Freight Term")
            {
                Applicationarea = All;
            }
            field(Freight; Rec.Freight)
            {
                Applicationarea = All;
            }
        }
        addafter("TDS Declaration")
        {
            field(MSME; Rec.MSME)
            {
                Applicationarea = All;
            }
        }
    }
}