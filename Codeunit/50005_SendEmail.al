codeunit 50026 SmsSentjobQueue
{
    // Permissions = tabledata "Sales Invoice Header" r
    var
        SalesInvoiceHeader: record "Sales Invoice Header";
        Salesperson: Record "Salesperson/Purchaser";
        SalesInvoiceHeader1: record "Sales Invoice Header";
        Customer: Record Customer;
        EmailBody: Text;
        SMTPMail: Codeunit "Email Message";
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        Outstr: OutStream;
        Instr: InStream;
        DuplicateBranch: Code[10];
        RFQHeader: Record "Sales RFQ Header";
        RFQLine: Record "Sales RFQ Line";
        ReportPath: Text[100];

    trigger OnRun()
    begin
        // IF SalesInvHdrNo <> '' THEN BEGIN
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("Sms Sent", FALSE);
        IF SalesInvoiceHeader.FINDSET THEN BEGIN
            REPEAT
                IF SalesInvoiceHeader."Sell-to Customer No." <> DuplicateBranch THEN BEGIN

                    //          SMTPMailSetup.GET;
                    SalesInvoiceHeader1.RESET;
                    SalesInvoiceHeader1.SETRANGE("No.", SalesInvoiceHeader."No.");
                    //SalesInvoiceHeader1.SETRANGE("Responsibility Center",'FEED|CATTLE');
                    IF SalesInvoiceHeader1.FINDSET THEN BEGIN
                        Customer.RESET;
                        Customer.SETRANGE("No.", SalesInvoiceHeader1."Sell-to Customer No.");
                        Customer.SETFILTER("E-Mail", '<>%1', '');
                        IF Customer.FINDFIRST THEN BEGIN
                            Clear(SMTPMail);
                            EmailBody := ('Dear Sir' + ',');
                            EmailBody += ('<br><br>');
                            EmailBody += ('Please find enclosed herewith your Invoice as per above mentioned subject for your kind perusal. If you found any discrepancy kindly let us know within 7 days after receiving the mail.');
                            EmailBody += ('<br><br>');
                            EmailBody += ('For any further information, please feel free to contact our dedicated executive.');
                            EmailBody += ('<br><br>');
                            SMTPMail.Create(Customer."E-Mail", 'Invoice' + ' ' + '(' + SalesInvoiceHeader1."No." + ')', EmailBody, true);
                            //   SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, Customer."E-Mail");
                            Salesperson.RESET;
                            IF Salesperson.GET(SalesInvoiceHeader1."Salesperson Code") THEN
                                SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, Salesperson."E-Mail");

                            RecRef.GetTable(SalesInvoiceHeader1);
                            TempBlob.CreateOutStream(Outstr);
                            //     Report.SaveAs(Report::"Sales Invoice New-GST", '', ReportFormat::Pdf, Outstr, RecRef);
                            TempBlob.CreateInStream(Instr);
                            SMTPMail.AddAttachment(SalesInvoiceHeader1."No." + '.pdf', 'PDF', Instr);

                            //  SMTPMail.AddAttachment(ReportPath, 'Invoice_' + DELCHR(SalesInvoiceHeader1."No.", '=', '/') + '.pdf');
                            SMTPMail.AppendToBody('With best regards!' + ',');
                            SMTPMail.AppendToBody('<BR>');
                            SMTPMail.AppendToBody('Sampoorna Team');
                            SMTPMail.AppendToBody('<BR><BR>');
                            SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
                            Clear(Email);
                            Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                            SalesInvoiceHeader."SMS Sent" := TRUE;
                            SalesInvoiceHeader.modify;
                        END;
                    END;
                    DuplicateBranch := SalesInvoiceHeader."Sell-to Customer No.";
                END;

            UNTIL SalesInvoiceHeader.NEXT = 0;

        END;
        //   END;
    end;


}