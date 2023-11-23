page 50014 "Terms Condition Subform"
{
    PageType = ListPart;
    // ApplicationArea = All;
    //   UsageCategory = Administration;
    SourceTable = "Terms Condition Line";
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Remarks1; Rec.Remarks1)
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}