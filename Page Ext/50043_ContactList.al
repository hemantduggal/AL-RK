pageextension 50043 ContList extends "Contact List"
{
    layout
    {
        moveafter(Name; "E-Mail")

        modify("Job Title")
        {
            Caption = 'Designation';
            Visible = true;
        }
        moveafter("E-Mail"; "Job Title")
        moveafter("Job Title"; "Phone No.")
        modify("Mobile Phone No.")
        {

            Visible = true;
        }

        moveafter("Phone No."; "Mobile Phone No.")
        modify("Company Name")
        {
            visible = false;
        }
        modify("Business Relation")
        {
            visible = false;
        }
        modify("Salesperson Code")
        {
            visible = false;
        }
        modify("Territory Code")
        {
            visible = false;
        }
    }
}