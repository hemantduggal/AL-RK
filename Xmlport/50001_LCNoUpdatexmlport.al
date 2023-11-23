xmlport 50001 "ImportLCNo"
{
    Caption = 'Import LC No.';
    Format = VariableText;
    Direction = Import;
    TextEncoding = WINDOWS;
    // TableSeparator = '';
    // TableSeparator = '';
    //FieldDelimiter = '"';
    //FieldSeparator = ';';
    FieldDelimiter = '"';
    FieldSeparator = ',';

    schema
    {
        textelement(Root)
        {

            tableelement(LCNum; Integer)
            {

                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textattribute(LCNo)
                {

                }
                textattribute(AMOUNT)
                {

                }
                textattribute(DATE1)
                {

                }
                textattribute(DesignPartNo)
                {

                }

                trigger OnBeforeInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;
                    LCNUmber.Reset();
                    if LCNUmber.FindLast() then begin
                        Evaluate(datevar, DATE1);
                        Evaluate(amountvar, AMOUNT);
                        LCNUmber.Init();
                        LCNUmber.Validate("LC No.", LCNo);
                        LCNUmber.Insert();

                        LCNUmber.Validate(Amount, amountvar);
                        LCNUmber.Validate(LC_Date, datevar);
                        LCNUmber.Modify();
                    end;
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
        Message('Customer Design Part No. Import Successfully');
    end;

    procedure GetDocNo(No: Code[20])
    begin
        GlobalJobNo := No;
        //GlobalJobaskNo := JobTaskNo;
    end;

    local procedure GetEntryNo(No: Code[20]): Code[20]
    begin
        /*
                RecJobTask.RESET;
                RecJobTask.SETRANGE("Budget No.", RecJob."Budget No.");
                IF RecJobTask.FINDLAST THEN
                    EXIT(RecJobTask."Budget No.")
                ELSE
                    EXIT;
                    */

    end;

    var
        datevar: Date;
        amountvar: Decimal;
        LCNUmber: Record "LC No";
        CustDesignpartNo: Record "Customer Design Part";

        Linenum: Integer;
        LineNo: Code[20];
        IQty: Decimal;
        ItemQty1: Decimal;
        ItemUnitPrice1: Decimal;
        DocumentDate1: Date;
        OrderDate1: Date;
        OrderType1: Option Export,Domestic;
        Docno: Code[20];
        heading: Boolean;
        FulfilmentThrough1: Option " ",Production,Inventory;
        GlobalJobNo: Code[20];
}