report 50002 DebitNoteReport
{
    UsageCategory = Administration;
    Caption = 'Debit Note Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PurchaseDebitNoteReport.rdl';

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "No.";
            CalcFields = Amount;
            column(DocumentNo; "Purch. Cr. Memo Hdr."."No.")
            {

            }
            column(refNo; VendInvNo)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            ///>>>>>BIll To
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Buy_from_Address_2; "Buy-from Address 2")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_County; "Buy-from County")
            {

            }
            column(Buy_from_Post_Code; "Buy-from Post Code")
            {

            }
            column(Buy_from_Contact; "Buy-from Contact")
            {

            }
            column(Buy_from_Contact_No_; "Buy-from Contact No.")
            {

            }
            column(CompanyInfopan; CompanyInfo."P.A.N. No.")
            {

            }
            column(CompanyInfogst; CompanyInfo."GST Registration No.")
            {

            }
            column(CompanyInfoEMAIL; CompanyInfo."E-Mail")
            {

            }
            column(CompanyInfoCONTACT; CompanyInfo."Contact Person")
            {

            }
            column(RecVendorGST; RecVendor."GST Registration No.")
            {

            }
            column(RecVendorPAN; RecVendor."P.A.N. No.")
            {

            }
            //>>>>>>
            //>>>>>Ship to
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_Contact; "Ship-to Contact")
            {

            }

            //>>>>>
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(ComapanyAddress; CompanyInfo.Address)
            {

            }
            column(CompanyAddress2; Companyinfo."Address 2")
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }
            column(CompanyPic; CompanyInfo.Picture)
            {

            }

            column(CompanyCountry; CompanyInfo.County)
            {

            }
            column(CompanyPostCode; CompanyInfo."Post Code")
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
            /*
            column(QRCodeImg; RecIRN."QR Code Image")
            {

            }
            */
            column(ACKNo; ACKNo)
            {

            }
            column(AckDate; AckDate)
            {

            }
            column(IRNNo; IRNNo)
            {

            }
            column(EwayNo; EwayNo)
            {

            }
            column(Location; RecLocation.Address)
            {

            }

            column(locationAdd2; RecLocation."Address 2")
            {

            }
            column(Country; RecLocation.County)
            {

            }
            column(locationCountry; RecLocation."Country/Region Code")
            {

            }
            column(locationpostcode; RecLocation."Post Code")
            {

            }
            column(locationcity; Reclocation.City)
            {

            }


            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(TAmountInWords; TAmountInWords[1])
                {

                }
                column(Description; Description)
                {

                }
                column(No_; "No.")
                {

                }

                column(Quantity; Quantity)
                {

                }
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(Unit_of_Measure; "Unit of Measure Code")
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Amount; Amount)
                {

                }
                column(AmountInWords; AmountInWords[1])
                {

                }
                column(Sno; Sno)
                {

                }
                column(TotalAmt; TotalAmt)
                {

                }
                column(TotalTax; TotalTax)
                {

                }
                column(GrandTotal; GrandTotal)
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
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


                trigger OnPreDataItem()
                var
                begin
                    Sno := 0;
                    GrandTotal := 0;
                end;

                trigger OnAfterGetRecord()
                var
                Begin

                    if "Purch. Cr. Memo Line"."No." = '' then
                        CurrReport.Skip();

                    Sno := Sno + 1;

                    if RecVendor.Get("Purch. Cr. Memo Hdr."."Buy-from Vendor No.") then;
                    if RecLocation.Get("Purch. Cr. Memo Hdr."."Location Code") then;

                    IGST_perc := 0;
                    IGST_Amt := 0;
                    CGST_perc := 0;
                    CGST_Amt := 0;
                    SGST_perc := 0;
                    SGST_Amt := 0;
                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Purch. Cr. Memo Line"."Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "Purch. Cr. Memo Line"."No.");
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


                    TotalTax += IGST_Amt + CGST_Amt + SGST_Amt;
                    TotalAmt += Amount;
                    GrandTotal := TotalAmt + TotalTax + "Line Discount %";

                    CLEAR(AmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWords, Round(TotalAmt), "Purch. Cr. Memo Hdr."."Currency Code");

                    CLEAR(TAmountInWords);
                    Check.InitTextVariable;
                    Check.FormatNoText(TAmountInWords, Round(TotalTax), "Purch. Cr. Memo Hdr."."Currency Code");


                End;
            }
            trigger OnAfterGetRecord()
            begin

            end;
        }
    }
    trigger OnPreReport()
    var
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

    trigger OnPostReport()
    var
    begin

    end;

    var
        Sno: Integer;
        CompanyInfo: Record "Company Information";
        Check: Report CheckPrint;
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
        refNo: Code[20];
        RecPPI: Record "Purch. Inv. Header";
        VendInvNo: Code[30];
        ACKNo: Text[250];
        IRNNo: Text[250];
        EwayNo: text[30];
        AckDate: Text;
        PI: Record "Purch. Inv. Header";
        VenInvNo: Code[20];
        recsalesline: Record "Purch. Cr. Memo Line";
        RecLocation: Record Location;


}