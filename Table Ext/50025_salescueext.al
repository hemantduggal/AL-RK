tableextension 50025 salescueext extends "Sales Cue"
{
    fields
    {
        field(50000; "Item Expired Within 15days"; Integer)
        {
            Caption = 'Item Expired Within 15 days';
            Editable = false;
            // FieldClass = FlowField;
            // CalcFormula =
        }
        field(50001; "Item Expired Within 30days"; Integer)
        {
            Caption = 'Item Expired Within 30 days';
            Editable = false;
            // FieldClass = FlowField;
            // CalcFormula =
        }
    }
}
