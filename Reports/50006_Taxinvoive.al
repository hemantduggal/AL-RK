report 50006 TaxinvoiceReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Taxinvoive.rdl';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(currdate; format(currdate))
            {

            }
            column(currtime; format(currtime))
            {

            }
            column(CmpName; CompanyInfo.Name)
            {

            }
            column(CmpAdd; CompanyInfo.Address)
            {

            }
            column(CmpAdd2; CompanyInfo."Address 2")
            {

            }
            column(CmpCity; CompanyInfo.City)
            {

            }
            column(CmpPin; CompanyInfo."Post Code")
            {

            }
            column(CmpEmail; CompanyInfo."E-Mail")
            {

            }
            column(CompanyInfostae; CompanyInfo."State Code")
            {

            }

            column(CmpPhone; CompanyInfo."Phone No.")
            {

            }
            column(CmpPic; CompanyInfo.Picture)
            {

            }
            column(CmpGST; CompanyInfo."GST Registration No.")
            {

            }
            column(billtocustadd; billtocust.Address)
            { }
            column(billtocustgst; billtocust."GST Registration No.")
            { }
            column(billtocustcontact; billtocust.Contact)
            { }
            column(billtocustfax; billtocust."Fax No.")
            { }
            column(billtocustcity; billtocust.City)
            { }
            column(compinfocity; compinfo.City)
            {

            }
            column(compinfostate; compinfo."State Code")
            {

            }
            column(compinfoname; compinfo.Name)
            {

            }
            column(billtocuststate; billtocust."State Code")
            { }
            column(billtocustpan; billtocust."P.A.N. No.")
            { }
            column(billtocust; billtocust."Email id")
            { }
            column(Bill_to_Contact; "Bill-to Contact")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            {

            }
            column(Bill_to_County; "Bill-to County")
            {

            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {

            }
            column(GST_Bill_to_State_Code; "GST Bill-to State Code")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(custstateName; statrec.Description)
            {

            }
            column(custfax; cust."Fax No.")
            {

            }
            column(custpan; cust."P.A.N. No.")
            {

            }
            column(Sell_to_E_Mail; "Sell-to E-Mail")
            { }
            column(custcontact; cust.Contact)
            {

            }

            column(cust; cust."GST Registration No.")
            {

            }
            column(Sell_to_Address; "Sell-to Address")
            {

            }
            column(Sell_to_City; "Sell-to City")
            {

            }
            column(Sell_to_Contact_No_; "Sell-to Contact No.")
            {

            }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            {

            }
            column(Custadd; Cust.Address)
            {

            }
            column(Custadd2; Cust."Address 2")
            {

            }
            column(Custstate; Cust."State Code")
            {

            }
            column(Ship_to_GST_Reg__No_; "Ship-to GST Reg. No.")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(TAmountInWords; TAmountInWords[1])
            {

            }
            column(TotalAmt; TotalAmt)
            {

            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {

            }
            column(CompanyInfobankac; CompanyInfo."Bank Account No.")
            {

            }
            column(CompanyInfobankname; CompanyInfo."Bank Name")
            {

            }
            column(CompanyInfobankbranch; CompanyInfo."Bank Branch No.")
            {

            }

            /*
          column(CompanyCIN; CompanyInfo."CIN No.")
              {

              }
              */
            column(CompanyPAN; CompanyInfo."P.A.N. No.")
            {

            }
            column(CompanyGST; CompanyInfo."GST Registration No.")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            { }
            column(Bill_to_Name_2; "Bill-to Name 2")
            { }
            column(Ship_to_Name; "Ship-to Name")
            { }
            column(Source_Code; "Source Code")
            { }
            column(VAT_Country_Region_Code; "VAT Country/Region Code")
            { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            { }

            /*
            column(Account_No; "Account No")
            { }
            */
            column(VAT_Registration_No_; "VAT Registration No.")
            { }
            column(Bill_to_Address; "Bill-to Address")
            { }
            column(Ship_to_Address; "Ship-to Address")
            { }
            column(Ship_to_Address_2; "Ship-to Address 2")
            { }
            column(Bill_to_Contact_No_; "Bill-to Contact No.")
            { }
            column(Ship_to_Contact; "Ship-to Contact")
            { }
            column(Payment_Method_Code; "Payment Method Code")
            { }

            column(Due_Date; format("Due Date"))
            { }
            column(Order_Date; format("Order Date"))
            { }
            column(No_; "No.")
            { }
            column(Your_Reference; "Your Reference")
            { }

            column(company; CompanyInfo.Picture)
            { }

            column(Bal__Account_No_; "Bal. Account No.") { }
            column(Bank_Name; "Bank Name") { }
            column(A_C_No_; "A/C No.") { }
            column(Branch_and_IFSC; "Branch and IFSC") { }
            column(CurrentD_T; "CurrentD&T") { }
            column(AmountInWords; AmountInWords[1])
            {

            }

            column(AmtWithWordsTaxAmt; AmtWithWordsTaxAmt)
            { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = where(Type = const(Item));
                DataItemLink = "Document No." = field("No.");

                column(HSN_SAC1; hsn)
                {

                }
                column(Document_No_; "Document No.")

                { }
                column(Description; Description)
                { }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Tax_Area_Code; "Tax Area Code")
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Line_Discount__; "Line Discount %")
                { }
                column(Amount; Amount)
                { }
                column(Sr_No_; "Sr.No.")
                { }
                column(WithTaxAmt; WithTaxAmt)
                { }
                column(TaxAmt; TaxAmt)
                { }
                column(Rate; Rate)
                { }
                column(HSN_SAC; "HSN/SAC")
                { }
                column(IGST_perc; IGST_perc)
                {

                }
                column(IGST_Amt; IGST_Amt)
                {

                }
                column(CGST_perc; CGST_perc)
                {

                }
                column(CGST_Amt; CGST_Amt)
                {

                }
                column(SGST_perc; SGST_perc)
                {

                }
                column(SGST_Amt; SGST_Amt)
                {

                }

                column(taxableAmt; taxableAmt)
                {

                }
                trigger OnPreDataItem()
                begin
                    "Sr.No." := 0;
                    TotalAmount := 0;
                    TotalAmt := 0;
                    TotalTax := 0;
                    GrandTotal := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    SIL: Record "Sales Invoice Line";
                begin
                    SIL1.Reset();
                    sil1.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    if sil1.FindFirst() then
                        hsn := sil1."HSN/SAC Code";


                    "Sr.No." := "Sr.No." + 1;
                    taxableAmt := 0;
                    IGST_perc := 0;
                    IGST_Amt := 0;
                    CGST_perc := 0;
                    CGST_Amt := 0;
                    SGST_perc := 0;
                    SGST_Amt := 0;
                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "Sales Invoice Line"."No.");
                    IF DetailedGSTLedgerEntry.FINDSET THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IGST_perc := DetailedGSTLedgerEntry."GST %";
                                IGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SGST_perc := DetailedGSTLedgerEntry."GST %";
                                SGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");

                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CGST_perc := DetailedGSTLedgerEntry."GST %";
                                CGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                    taxableAmt := IGST_Amt + CGST_Amt + SGST_Amt;
                    TaxAmt += IGST_Amt + CGST_Amt + SGST_Amt;
                    TotalAmt += Amount;
                    GrandTotal += TotalAmt + TotalTax + "Line Discount %";
                    WithTaxAmt := TotalAmt + TaxAmt;
                    CLEAR(AmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText1(AmountInWords, Round(TotalAmt), "Sales Invoice Header"."Currency Code");

                    CLEAR(TAmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText1(TAmountInWords, Round(TaxAmt), "Sales Invoice Header"."Currency Code");

                end;

            }

            trigger OnAfterGetRecord()
            var
            begin
                currdate := Today;
                currtime := Time;
                cust.Reset();
                cust.SetRange("No.", "Sales Invoice Header"."Sell-to Customer No.");
                if cust.FindFirst() then;


                billtocust.Reset();
                billtocust.SetRange("No.", "Sales Invoice Header"."Bill-to Customer No.");
                if billtocust.FindFirst() then;


                statrec.Reset();
                statrec.SetRange(Code, cust."State Code");
                if statrec.FindFirst() then;
            end;
        }
    }


    trigger OnPreReport()
    var
        myInt: Integer;

    begin
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        if compinfo.Get() then
            compinfo.CalcFields(compinfo.Picture);
    end;

    var
        taxableAmt: Decimal;
        NoTextTax: array[2] of Text;
        AmtWithWordsTaxAmt: Text;
        CompanyInfo: Record "Company Information";
        "Sr.No.": Integer;
        Check: Report 50001;
        NoText: array[2] of Text;
        currdate: Date;
        currtime: Time;
        SIL: Record "Sales Invoice Line";
        TotalAmount: Decimal;
        "Bank Name": Text[50];
        "A/C No.": Code[30];
        "Branch and IFSC": Code[50];
        "CurrentD&T": DateTime;
        TaxAmt: Decimal;
        WithTaxAmt: Decimal;
        Rate: Decimal;
        TotalTaxAmt: Decimal;
        "HSN/SAC": Integer;
        compinfo: Record "Company Information";
        TAmount: Decimal;
        AmountInWords: array[2] of Text;
        TAmountInWords: array[2] of Text;
        TotalAmt: Decimal;
        GrandTotal: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGST_perc: Decimal;
        IGST_Amt: Decimal;
        CGST_perc: Decimal;
        CGST_Amt: Decimal;
        SGST_perc: Decimal;
        SGST_Amt: Decimal;
        RecVendor: Record Vendor;
        TotalTax: Decimal;
        cust: Record Customer;
        statrec: Record State;
        billtocust: Record Customer;
        sil1: Record "Sales Invoice Line";
        hsn: code[10];
}
