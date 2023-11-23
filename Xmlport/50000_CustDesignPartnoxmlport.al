xmlport 50000 "ImportCustDesignpartNo"
{
    Caption = 'Import Customer Design part No.';
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

            tableelement(CustomerDesignPart; Integer)
            {

                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textattribute(ItemNo)
                {

                }
                textattribute(CustomerNo)
                {

                }
                textattribute(ItemBrand)
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

                    if CustDesignpartNo1.FindLast() then begin
                        CustDesignpartNo.Init();
                        CustDesignpartNo.Validate("Design Part No.", DesignPartNo);
                        CustDesignpartNo.Insert();
                        CustDesignpartNo.Validate("Item No.", ItemNo);
                        CustDesignpartNo.Validate("Customer No.", CustomerNo);
                        CustDesignpartNo.Validate(Brand, ItemBrand);

                        CustDesignpartNo.Modify();
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
        CustDesignpartNo: Record "Customer Design Part";
        CustDesignpartNo1: Record "Customer Design Part";
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