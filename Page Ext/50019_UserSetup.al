pageextension 50019 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("HO User"; Rec."HO User")
            {
                Applicationarea = All;
            }
            field(Branch; Rec.Branch)
            {
                Applicationarea = All;
            }
            field(Zone; Rec.Zone)
            {
                Applicationarea = All;
            }
            field(Salesperson; Rec.Salesperson)
            {
                Applicationarea = All;
            }
            field("Product manager"; Rec."Product manager")
            {
                Applicationarea = All;
            }
            field("Purchase Order Creation"; Rec."Purchase Order Creation")
            {
                Applicationarea = All;
            }
            field("Purchase Order"; Rec."Purchase Order")
            {
                Applicationarea = All;
            }
            field("Purchase Quote"; Rec."Purchase Quote")
            {
                Applicationarea = All;
            }
            field("Posted Purchase Invoice"; Rec."Posted Purchase Invoice")
            {
                Applicationarea = All;
            }
            field("Posted Purchase Receipt"; Rec."Posted Purchase Receipt")
            {
                Applicationarea = All;
            }
            field("Sale Quote"; Rec."Sale Quote")
            {
                Applicationarea = All;
            }
        }
    }
}

