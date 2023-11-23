xmlport 50008 "Jrnl Jrnl Uploader"
{
    Caption = 'General Journal Uploader';
    Format = VariableText;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ',';

    schema
    {
        textelement(Root)
        {

            tableelement(genjnl; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textattribute(DocumentDate)
                {

                }
                textattribute(PostingDate)
                {

                }
                textattribute(DocumentType)
                {

                }
                textattribute(DocumentNo)
                {

                }
                textattribute(AccountType)
                {

                }
                textattribute(AccountNo)
                {

                }
                textattribute(AccountName)
                {

                }
                textattribute(DebitAmount)
                {

                }
                textattribute(CreditAmount)
                {

                }
                textattribute(BalAccountType)
                {

                }
                textattribute(BalAccountNo)
                {

                }
                textattribute(ChequeNo)
                {

                }
                textattribute(ChequeDate)
                {

                }
                textattribute(ExternalDocumentNo)
                {

                }
                textattribute(Comment)
                {

                }
                trigger OnBeforeInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;

                    Evaluate(DocumentDate1, DocumentDate);
                    Evaluate(PostingDate1, PostingDate);
                    Evaluate(DocumentType1, DocumentType);
                    Evaluate(AccountType1, AccountType);
                    Evaluate(DebitAmount1, DebitAmount);
                    Evaluate(CreditAmount1, CreditAmount);
                    Evaluate(BalAccountType1, BalAccountType);
                    Evaluate(ChequeDate1, ChequeDate);

                    genjnlline.Reset();
                    if genjnlline.FindLast() then
                        entryno := genjnlline."Line No." + 10000
                    else
                        entryno := 10000;

                    SP.Reset();
                    SP.Init();
                    SP.validate("Journal Template Name", 'GENERAL');
                    SP.validate("Journal Batch Name", 'PAYROLL');
                    sp."Line No." := entryno;
                    SP.Insert();
                    sp."Document Date" := DocumentDate1;
                    SP."Document Type" := DocumentType1;
                    SP."Posting Date" := Today;

                    if DocumentNo = '' then
                        // SP."Document No." := noseries.GetNextNo('JOURNAL', Today, true)
                        SP.validate("Document No.", noseries.GetNextNo('JOURNAL', Today, true))
                    else
                        SP.validate("Document No.", DocumentNo);
                    SP."Account Type" := AccountType1;
                    SP."Account No." := AccountNo;
                    if DebitAmount1 <> 0 then
                        SP."Debit Amount" := DebitAmount1;
                    if CreditAmount1 <> 0 then
                        SP."Credit Amount" := CreditAmount1;
                    SP."Bal. Account Type" := BalAccountType1;
                    SP."Bal. Account No." := BalAccountNo;
                    SP."Cheque No." := ChequeNo;
                    SP."Cheque Date" := ChequeDate1;
                    SP."External Document No." := ExternalDocumentNo;
                    SP.Comment := Comment;
                    SP.Modify();
                end;
            }
        }
    }
    trigger OnPreXmlPort()
    begin
        Heading := true;
    end;

    trigger OnPostXmlPort()
    begin
        Message('Payroll data Import Successfully');
    end;
    /*
        procedure GetDocNo(No: Code[20])
        begin
            GlobalJobNo := No;
            //GlobalJobaskNo := JobTaskNo;
        end;

        local procedure GetEntryNo(No: Code[20]): Code[20]
        begin

            RecJobTask.RESET;
            RecJobTask.SETRANGE("RFQ Doc No.", RecJob."RFQ Doc No.");
            IF RecJobTask.FINDLAST THEN
                EXIT(RecJobTask."RFQ Doc No.")
            ELSE
                EXIT;

        end;
    */
    var
        SadaPrice1: Record "Sada price List";
        SP: Record "Gen. Journal Line";
        heading: Boolean;
        entryno: Integer;
        DocumentDate1: Date;
        PostingDate1: Date;
        DocumentType1: Option ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        AccountType1: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

        DebitAmount1: Decimal;
        CreditAmount1: Decimal;
        BalAccountType1: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

        ChequeDate1: Date;
        noseries: Codeunit NoSeriesManagement;
        genjnlline: Record "Gen. Journal Line";
}