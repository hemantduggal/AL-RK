pageextension 50051 custlist extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }

            field("Mobile Phone No."; Rec."Mobile Phone No.")
            {
                ApplicationArea = All;
            }


            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }

            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }
}