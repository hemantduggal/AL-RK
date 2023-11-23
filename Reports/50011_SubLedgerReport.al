report 50011 Sub_LedgerReport
{
    UsageCategory = Administration;
    Caption = 'Sub Ledger Report new';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SubLedgernew.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter(Invoice));

            column(startdate; startdate)
            {

            }
            column(Enddate; Enddate)
            {

            }
            column(cmpname; CompanyInfo.Name)
            {

            }
            column(Posting_Date; format("Posting Date"))
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Document_Type; "Document Type")
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Amount; Amount)
            {

            }

            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Applied Cust. Ledger Entry No." = field("Entry No.");
                DataItemTableView = where(Unapplied = const(false), "Entry Type" = filter(Application), "Initial Document Type" = filter(Payment));
                column(Document_No1; "Document No.")
                {

                }
                column(Posting_Date1; format("Posting Date"))
                {

                }
                column(Amount1; Amount)
                {

                }
                column(Document_Type1; "Document Type")
                {

                }
                dataitem("Cust. Ledger Entry1"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Entry No." = field("Cust. Ledger Entry No.");
                    column(Document_No2; "Document No.")
                    {

                    }
                    column(Posting_Date2; format("Posting Date"))
                    {

                    }
                    column(Amount2; Amount)
                    {

                    }
                    column(Document_Type2; "Document Type")
                    {

                    }
                    trigger OnAfterGetRecord()
                    begin

                    end;
                    /*
                    dataitem("Sales Invoice Header"; "Sales Invoice Header")
                    {
                        DataItemLink = "No." = field("Document No.");
                        dataitem("Sales Invoice Line"; "Sales Invoice Line")
                        {
                            DataItemLink = "Document No." = field("No.");
                            column(itemNo_; "No.")
                            {

                            }
                            column(Brand; Brand)
                            {

                            }
                            column(Unit_Cost; "Unit Cost")
                            {

                            }
                        }
                    }
                    */
                }
                trigger OnAfterGetRecord()
                begin

                end;
            }

        }
    }



    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(startdate; startdate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = all;
                }
                field(Enddate; Enddate)
                {
                    Caption = 'End Date';
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnPreReport()
    var
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        startdate: date;
        Enddate: date;
        recCust: Record Customer;
        RecCLE: Record "Cust. Ledger Entry";
        RecItem: Record Item;
}