xmlport 50007 "SalesRFQ Import"
{
    Caption = 'Sales RFQ';
    DefaultFieldsValidation = true;
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = MSDOS;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Header"; "Sales RFQ Header")
            {
                AutoSave = false;
                XmlName = 'SalesRFQ';
                UseTemporary = true;
                textelement(Docdate)
                {
                }
                textelement(postingdate)
                {
                }

                textelement(custno)
                {
                }
                textelement(remarks)
                {
                }
                textelement(location)
                {
                }
                textelement(salesperson)
                {
                }
                textelement(itemno)
                {
                }
                textelement(quantity)
                {
                }
                textelement(uom)
                {
                }

                textelement(rate)
                {
                }
                textelement(brand)
                {
                }
                textelement(application)
                {
                }
                textelement(project)
                {
                }
                textelement(type)
                {

                }
                textelement(costprice)
                {
                }
                textelement(designpartno)
                {
                }

                textelement(lt)
                {
                }
                textelement(spq)
                {

                }
                textelement(moq)
                {
                }


                trigger OnAfterInitRecord()
                begin
                    IF (SkipFirstLine = FALSE) THEN BEGIN
                        SkipFirstLine := TRUE;
                        currXMLport.SKIP;
                    END;
                end;

                trigger OnAfterInsertRecord()
                begin
                    IF (SkipFirstLine = FALSE) THEN
                        SkipFirstLine := TRUE;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    IF (SkipFirstLine = FALSE) THEN BEGIN
                        SkipFirstLine := TRUE;
                        currXMLport.SKIP;
                    END;


                    T_36.RESET;
                    IF NOT T_36.FINDFIRST THEN BEGIN
                        T_36.INIT;
                        T_36."RFQ Doc No." := noseries.GetNextNo('SRFQ', Today, true);
                        IF T_36.INSERT(TRUE) THEN BEGIN
                            SODocNo := T_36."RFQ Doc No.";

                            T_36_1.VALIDATE("Customer No.", custno);
                            Evaluate(Docdate1, Docdate);
                            T_36_1.VALIDATE("Document Date", Docdate1);
                            Evaluate(postingdate1, postingdate);
                            T_36_1.VALIDATE("Posting Date", postingdate1);
                            T_36_1.VALIDATE(Location, location);
                            T_36_1.VALIDATE(Salesperson, salesperson);
                            T_36_1.MODIFY;
                            T_37.RESET;
                            T_37.SETRANGE("RFQ Doc No.", SODocNo);
                            IF T_37.FINDLAST THEN
                                LastLineNo := T_37."Line No." + 10000
                            ELSE
                                LastLineNo := 10000;

                            T_37.INIT;
                            T_37.VALIDATE("RFQ Doc No.", SODocNo);
                            T_37."Line No." := LastLineNo;
                            T_37.Insert();
                            EVALUATE(type1, type);
                            T_37.VALIDATE(Type, type1);
                            T_37.VALIDATE("Item No.", ItemNo);
                            RecItem.Reset();
                            RecItem.get(T_37."Item No.");
                            T_37.Description := RecItem.Description;
                            UOM := RecItem."Base Unit of Measure";
                            Salesperson := T_36_1.Salesperson;
                            T_37."Customer No." := T_36_1."Customer No.";
                            T_37."Document Date" := T_36_1."Document Date";
                            T_37."Location Code" := T_36_1.Location;
                            T_37.VALIDATE(UOM, UOM);

                            EVALUATE(T_37.Quantity, quantity);
                            T_37.VALIDATE(Quantity);
                            if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
                                Sadapr.Reset();
                                Sadapr.SetRange("Item No. (MPN)", T_37."Item No.");
                                Sadapr.SetRange("Customer No.", T_37."Customer No.");
                                Sadapr.SetFilter("Item Start Date", '<= %1', T_37."Document Date");
                                Sadapr.SetFilter("Item Expiry Date", '>=%1', T_37."Document Date");
                                if Sadapr.FindFirst() then begin
                                    T_37."Direct Unit Cost" := Sadapr."DBC. (DCPL Price)";
                                    T_37."Price Update Status" := T_37."Price Update Status"::"Pending For Approval";
                                    Message('Approval request sent');
                                    // T_37.Modify();
                                end;
                            end else begin
                                T_37."Direct Unit Cost" := RecItem."Unit Cost";
                                T_37."Price Update Status" := T_37."Price Update Status"::"Pending For Approval";
                                Message('Approval request sent');
                                // T_37.Modify()

                                if RecItem."Price Category" = RecItem."Price Category"::"Non-SADA" then begin
                                    if T_37."Direct Unit Cost" < (RecItem."Purchase price" + RecItem."Margin %") then begin
                                        T_37."Margin is Less" := true;
                                        T_37."Margin Less Status" := T_37."Margin Less Status"::"Pending For Approval";
                                        // T_37.Modify();
                                    end;
                                    Message('Approval request sent to sales Head Due to margin is less then the mentioned in item');
                                end;
                            end;
                            T_37.VALIDATE("Customer No.", T_36."Customer No.");
                            // EVALUATE(directunitcost1, directunitcost);
                            // T_37.VALIDATE("Direct Unit Cost", directunitcost1);
                            T_37.Rate := T_37.Quantity * T_37."Direct Unit Cost";


                            EVALUATE(rate1, rate);
                            T_37.VALIDATE(Rate, rate1);
                            T_37.VALIDATE(Application, application);
                            T_37.VALIDATE(project, project);
                            T_37.Validate(Salesperson, T_36_1.Salesperson);
                            EVALUATE(costprice1, costprice);
                            T_37.VALIDATE("Cost price", costprice1);

                            T_37.Validate(LT, lt);
                            EVALUATE(spq1, spq);
                            T_37.VALIDATE(SPQ, spq1);

                            EVALUATE(moq1, moq);
                            T_37.VALIDATE(MOQ, moq1);

                            T_37.Modify();
                        END;


                    END;
                end;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        MESSAGE('Sales RFQ imported successfully')
    end;

    var
        SkipFirstLine: Boolean;
        TotalCount: Integer;
        TotalCountBAl: Integer;
        BalanceAccount: Text;
        T_36: Record "Sales RFQ Header";
        SODocNo: Code[20];
        T_36_1: Record "Sales RFQ Header";
        T_37: Record "Sales RFQ Line";
        LastLineNo: Integer;
        salesH: Record "Sales RFQ Header";
        Docdate1: Date;
        postingdate1: Date;
        RecItem: Record Item;
        directunitcost1: Decimal;
        rate1: Decimal;
        type1: Option " ",Item,FA;

        costprice1: Decimal;
        spq1: Integer;
        moq1: Integer;
        noseries: Codeunit NoSeriesManagement;
        Sadapr: Record "Sada price List";

}

