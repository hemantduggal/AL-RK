codeunit 50006 SubLedger
{
    procedure InsertData(CustNo: Code[10]; startdate: date; enddate: date)
    var
        CLE: Record "Cust. Ledger Entry";
        DCLE: Record "Detailed Cust. Ledg. Entry";
        CLE1: Record "Cust. Ledger Entry";
        subledtemp: Record "Sub Ledger Temp Table";
        subledtemp1: Record "Sub Ledger Temp Table";
        subledtemp2: Record "Sub Ledger Temp Table";
        SIL: Record "Sales Invoice Line";
        GLEntry: Record "G/L Entry";
        BALE: Record "Bank Account Ledger Entry";
        BAcc: Record "Bank Account";
        accname: Code[10];
        scmh: Record "Sales Cr.Memo Header";
        sih: Record "Sales Invoice Header";
        salepersn: Record "Salesperson/Purchaser";
        salepername: Text[50];
        payterm: code[10];
    begin
        sih.Reset();
        scmh.Reset();
        subledtemp.DeleteAll();
        CLE.Reset();
        subledtemp.Reset();
        CLE.SetFilter("Document Type", '%1', CLE."Document Type"::Invoice);
        CLE.SetRange("Posting Date", startdate, enddate);
        CLE.SetRange("Customer No.", CustNo);
        //  CLE.SetRange("Document No.", 'SI+/23-24/24');
        if CLE.FindSet() then begin
            repeat
                SIL.Reset();
                SIL.SetRange("Document No.", CLE."Document No.");
                SIL.SetFilter(Type, '%1', SIL.Type::Item);
                if SIL.FindFirst() then
                    repeat
                        subledtemp2.Reset();
                        if subledtemp2.FindLast() then;
                        subledtemp.Init();
                        subledtemp."Entry No" := subledtemp2."Entry No" + 1;
                        subledtemp.Insert();
                        subledtemp."Posting Date" := SIL."Posting Date";
                        subledtemp."Document No" := CLE."Document No.";
                        subledtemp."Product Name" := SIL."No.";
                        subledtemp.Quantity := SIL.Quantity;
                        subledtemp.Remarks := SIL.Remarks;
                        subledtemp."INR Rate" := SIL."Unit Cost";
                        if SIL.Amount > 0 then
                            subledtemp."Debit Amt" := SIL.Amount
                        else
                            if SIL.Amount < 0 then
                                subledtemp."Credit Amt" := SIL.Amount;

                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", CLE."Document No.");
                        GLEntry.SetRange("G/L Account Name", 'Sale Account');
                        if GLEntry.Findfirst() then
                            GLEntry.CalcFields("G/L Account Name");
                        subledtemp.Account := GLEntry."G/L Account Name";
                        sih.Reset();
                        sih.SetRange("No.", SIL."Document No.");
                        if sih.FindFirst() then begin
                            subledtemp."Payment Term" := sih."Payment Terms Code";
                            salepersn.reset();
                            salepersn.SetRange(Code, sih."Salesperson Code");
                            if salepersn.FindFirst() then
                                subledtemp."Salesperson Name" := salepersn.Name;

                        end;
                        subledtemp.Modify();

                    until sil.Next() = 0;

                //Payment
                DCLE.Reset();
                DCLE.SetRange("Applied Cust. Ledger Entry No.", CLE."Entry No.");
                DCLE.SetRange(Unapplied, false);
                DCLE.SetFilter("Entry Type", '%1', DCLE."Entry Type"::Application);
                DCLE.SetFilter("Initial Document Type", '%1', DCLE."Initial Document Type"::Payment);
                if DCLE.FindFirst() then begin
                    repeat
                        CLE1.Reset();
                        CLE1.SetRange("Entry No.", DCLE."Cust. Ledger Entry No.");
                        if CLE1.FindFirst() then begin
                            CLE1.CalcFields(Amount);
                            // Message('%1..%2', CLE1.Amount, CLE1."Document No.");
                            subledtemp2.Reset();
                            if subledtemp2.FindLast() then;
                            subledtemp.Init();
                            subledtemp."Entry No" := subledtemp2."Entry No" + 1;
                            subledtemp.Insert();
                            subledtemp."Posting Date" := CLE1."Posting Date";
                            subledtemp."Document No" := CLE1."Document No.";
                            if CLE1.Amount > 0 then
                                subledtemp."Debit Amt" := CLE1.Amount
                            else
                                if CLE1.Amount < 0 then
                                    subledtemp."Credit Amt" := CLE1.Amount;

                            BALE.Reset();
                            BALE.SetRange("Document No.", CLE1."Document No.");
                            if BALE.Findfirst() then begin
                                accname := BALE."Bank Account No.";
                                BAcc.Reset();
                                BAcc.SetRange("No.", accname);
                                if BAcc.FindFirst() then
                                    subledtemp.Account := BAcc.Name;
                            end;
                            subledtemp.Modify();
                        end;
                    until DCLE.Next() = 0;
                    //Payment
                END;
                //Credit Memo
                DCLE.Reset();
                DCLE.SetRange("Applied Cust. Ledger Entry No.", CLE."Entry No.");
                DCLE.SetRange(Unapplied, false);
                DCLE.SetFilter("Entry Type", '%1', DCLE."Entry Type"::Application);
                DCLE.SetFilter("Initial Document Type", '%1', DCLE."Initial Document Type"::"Credit Memo");
                if DCLE.FindFirst() then begin
                    repeat
                        CLE1.Reset();
                        CLE1.SetRange("Entry No.", DCLE."Cust. Ledger Entry No.");
                        if CLE1.FindFirst() then begin
                            CLE1.CalcFields(Amount);
                            // Message('%1..%2', CLE1.Amount, CLE1."Document No.");
                            subledtemp2.Reset();
                            if subledtemp2.FindLast() then;
                            subledtemp.Init();
                            subledtemp."Entry No" := subledtemp2."Entry No" + 1;
                            subledtemp.Insert();
                            subledtemp."Posting Date" := CLE1."Posting Date";
                            subledtemp."Document No" := CLE1."Document No.";
                            if CLE1.Amount > 0 then
                                subledtemp."Debit Amt" := CLE1.Amount
                            else
                                if CLE1.Amount < 0 then
                                    subledtemp."Credit Amt" := CLE1.Amount;
                            GLEntry.Reset();
                            GLEntry.SetRange("Document No.", CLE1."Document No.");
                            GLEntry.SetRange("G/L Account Name", 'Sale Account');
                            if GLEntry.Findfirst() then begin
                                GLEntry.CalcFields("G/L Account Name");
                                subledtemp.Account := GLEntry."G/L Account Name";
                            end;
                            subledtemp.Modify();
                        end;
                    until DCLE.Next() = 0;
                end;
            until CLE.Next() = 0;
        end;
    end;




}