pageextension 50040 BALedEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        addbefore(GLEntriesPart)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                SubPageLink = "Posting Date" = field("Posting Date"), "Document No." = field("Document No.");
            }
        }
    }

}