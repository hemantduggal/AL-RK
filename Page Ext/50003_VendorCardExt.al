pageextension 50003 VendorCardExt1 extends "Vendor Card"
{
    layout
    {

        modify(Control16)
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                custcont: record Vendor_Contact;
                CustContPage: Page Vendor_Contact_Page;
            begin
                custcont.Reset();
                custcont.SetRange("Vendor No.", Rec."No.");
                CustContPage.SETTABLEVIEW(custcont);
                CustContPage.LOOKUPMODE(TRUE);
                if (CustContPage.RunModal() = Action::LookupOK) then begin
                    CustContPage.GetRecord(custcont);
                    Rec.Contact := custcont.Name;

                end;
            end;
        }

        addafter(Name)
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
            field(SalesPerson; Rec.SalesPerson)
            {
                Applicationarea = All;
            }
            field("Account Name"; Rec."Account Name")
            {
                Applicationarea = All;
            }

            field("Email-Id 1"; Rec."Email-Id 1")
            {
                Applicationarea = All;
            }
            field("Email-Id 2"; Rec."Email-Id 2")
            {
                Applicationarea = All;
            }

            field("Vendor Registration No."; Rec."Vendor Registration No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Registration Date"; Rec."Vendor Registration Date")
            {
                ApplicationArea = All;
            }
        }
    }
}