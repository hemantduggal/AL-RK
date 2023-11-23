report 50014 PackingListReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PackingList.rdl';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_; "No.")
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            { }
            column(Sell_to_Contact_No_; "Sell-to Contact No.")
            { }
            column(CompanyName; Company.Name)
            { }
            column(CompanyAddr; Company.Address)
            { }


            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No." = field("No.");

                column(Document_No_; "Document No.")
                { }
                column(Line_No_; "Line No.")
                { }
                column(Description; Description)
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(SrNo; SrNo)
                { }


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    SrNo += 1;
                end;
            }


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;

    begin
        Company.Get()
    end;

    var
        Company: Record "Company Information";
        SrNo: Integer;
}