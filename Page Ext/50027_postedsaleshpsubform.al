pageextension 50027 postSaleshpSubformExt extends "Posted Sales Shpt. Subform"
{
    layout
    {
        modify(Description)
        {
            Caption = 'Manufacture Part No.';
        }
        addafter("Location Code")
        {
            field(Brand; Rec.Brand)
            {
                Applicationarea = All;
            }

            field(LT; Rec.LT)
            {
                Applicationarea = All;
            }

            field(SPQ; Rec.SPQ)
            {
                Applicationarea = All;
            }
            field(MOQ; Rec.MOQ)
            {
                Applicationarea = All;
            }
            field("Commission %"; Rec."Commission %")
            {
                Applicationarea = All;
            }
        }
    }
}