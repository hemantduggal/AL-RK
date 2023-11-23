xmlport 50005 "Sada price update"
{
    Caption = 'Sada price update';
    Format = VariableText;
    Direction = Import;
    TextEncoding = WINDOWS;
    // TableSeparator = '';
    //FieldDelimiter = '"';
    //FieldSeparator = ';';
    //  textattributeDelimiter = '"';
    FieldSeparator = ',';

    schema
    {
        textelement(Root)
        {

            tableelement(Sadapr; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textattribute(ItemNo)
                {

                }
                textattribute(saprice)
                {

                }



                trigger OnBeforeInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;


                    sadaprice.Reset();
                    sadaprice.SetRange("Item No. (MPN)", ItemNo);
                    if sadaprice.FindFirst() then begin
                        Evaluate(Saprice1, saprice);
                        sadaprice.Validate("DBC. (DCPL Price)", Saprice1);
                    end;
                    sadaprice.Modify();
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
        Message('sada price updated  Successfully');
    end;

    var
        sadaprice: Record "Sada price List";
        heading: Boolean;
        entryno: Integer;
        Allocationtype1: Option ,Allocate,"Non- Allocate";
        Pricecategory1: Option ,SADA,"Non-SADA";
        Saprice1: Decimal;
}