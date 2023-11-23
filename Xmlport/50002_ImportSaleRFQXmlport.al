
/*xmlport 50002 "Import Sales RFQ Lines"
{
    Caption = 'Import Sales RFQ Lines';
    Format = VariableText;
    Direction = Import;
    TextEncoding = WINDOWS;
    // TableSeparator = '';
    //FieldDelimiter = '"';
    //FieldSeparator = ';';
    //   FieldDelimiter = '"';
    FieldSeparator = ',';

    schema
    {
        textelement(Root)
        {

            tableelement(SaleRFQLines; Integer)
            {

                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textattribute(itemno)
                {

                }
                textattribute(description)
                {

                }
                textattribute(quantity)
                {

                }
                textattribute(customerno)
                {

                }
                textattribute(uom)
                {

                }
                textattribute(directunitcost)
                {

                }
                textattribute(rate)
                {

                }
                textattribute(brand)
                {

                }
                textattribute(application)
                {

                }
                textattribute(project)
                {

                }
                textattribute(salesperson)
                {

                }

                textattribute(type)
                {

                }
                textattribute(costprice)
                {

                }
                textattribute(designpartno)
                {

                }
                textattribute(documentdate)
                {

                }

                textattribute(locationcode)
                {

                }

                textattribute(lt)
                {

                }
                textattribute(spq)
                {

                }
                textattribute(moq)
                {

                }


                trigger OnBeforeInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;
                    Evaluate(quantity1, quantity);
                    Evaluate(directunitcost1, directunitcost);
                    Evaluate(costprice1, costprice);
                    Evaluate(rate1, rate);
                    Evaluate(type1, type);
                    Evaluate(documentdate1, documentdate);
                    Evaluate(costprice1, costprice);
                    Evaluate(spq1, spq);
                    Evaluate(moq1, moq);
                    //  LineNo := GetNextLineNo();

                    LineNo := GlobalJobNo;

                    RecJob.RESET();
                    RecJobTask.RESET();

                    RecJobTask1.SETRANGE("RFQ Doc No.", GlobalJobNo);
                    IF RecJobTask1.FindLast() THEN
                        Linenum := RecJobTask1."Line No." + 10000
                    else
                        Linenum := 10000;
                    RecJobTask.Init();
                    RecJobTask.Validate("RFQ Doc No.", GlobalJobNo);
                    RecJobTask.Validate("Line No.", Linenum);
                    RecJobTask.Insert();

                    RecJob.SetRange("RFQ Doc No.", RecJobTask."RFQ Doc No.");

                    RecJobTask.Validate("Item No.", itemno);
                    RecJobTask.Validate(Description, description);
                    RecJobTask.Validate(Quantity, quantity1);

                    RecJobTask.Validate(UOM, uom1);
                    RecJobTask.Validate("Direct Unit Cost", directunitcost1);
                    RecJobTask.Validate(Rate, rate1);
                    RecJobTask.Validate(Brand, brand);
                    RecJobTask.Validate(Application, application);
                    RecJobTask.Validate(project, project);
                    RecJobTask.Validate(Salesperson, salesperson);
                    RecJobTask.Validate(Type, type1);
                    RecJobTask.Validate("Cost price", costprice1);
                    RecJobTask.Validate("Design Part No.", designpartno);
                    RecJobTask.Validate(Type, type1);
                    RecJobTask.Validate("Cost price", costprice1);
                    RecJobTask.Validate("Design Part No.", designpartno);
                    RecJobTask.Validate("Document Date", documentdate1);
                    RecJobTask.Validate("Location Code", locationcode);
                    RecJobTask.Validate(LT, lt);
                    RecJobTask.Validate(SPQ, spq1);
                    RecJobTask.Validate(MOQ, moq1);
                    RecJobTask.Modify();

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
        Message('RFQ Lines Import Successfully');
    end;

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

    var
        RecJob: Record "Sales RFQ Header";
        BudgetNo1: Code[20];
        outcome1: Text[250];
        output1: Text[250];
        activityno1: Code[20];
        subactivityno1: Code[20];
        startdate1: Date;
        enddate1: Date;
        budget1: Decimal;
        RecJobTask1: Record "Sales RFQ Line";
        RecJobTask: Record "Sales RFQ Line";
        //RecJob: Record "Budget Header";
        NoOfLoops: Integer;
        RecHeader: Record "Sales RFQ Header";
        RecHeader1: Record "Sales RFQ Header";
        RecSLine: Record "Sales RFQ Line";
        RecSLine1: Record "Sales RFQ Line";
        Linenum: Integer;
        LineNo: Code[20];
        IQty: Decimal;
        ItemQty1: Decimal;
        ItemUnitPrice1: Decimal;

        OrderDate1: Date;
        OrderType1: Option Export,Domestic;
        Docno: Code[20];
        heading: Boolean;
        FulfilmentThrough1: Option " ",Production,Inventory;
        GlobalJobNo1: Code[20];
        rfqdocno1: code[20];
        itemno1: code[20];
        description1: text[50];
        quantity1: Decimal;
        customerno1: code[10];
        uom1: text[30];
        directunitcost1: Decimal;
        rate1: Decimal;
        brand1: code[10];
        application1: code[40];
        project1: code[40];
        salesperson1: code[20];
        linenumber1: Integer;
        type1: Option " ",Item,FA;
        costprice1: Decimal;
        designpartno1: code[50];
        documentdate1: Date;
        locationcode1: Code[30];

        lt1: TEXT[10];
        spq1: Integer;
        moq1: Integer;
        GlobalJobNo: Code[20];
        
}
*/