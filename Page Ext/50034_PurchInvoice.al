pageextension 50034 PurchInv extends "Purchase Invoice"
{
    actions
    {

        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
    }
}