xmlport 50006 "Updateprice&margin"
{

    Caption = 'Update price & margin';
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

            tableelement(Sadaprice; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textattribute(ItemNo)
                {

                }
                textattribute(Purchaseprice)
                {

                }
                textattribute(margin)
                {

                }


                trigger OnBeforeInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;



                    RecItem.Reset();
                    RecItem.SetRange("No.", ItemNo);
                    if RecItem.FindFirst() then begin
                        Evaluate(purchprice1, Purchaseprice);
                        RecItem.validate("Purchase price", purchprice1);
                        Evaluate(margin1, margin);
                        RecItem.validate("Margin %", margin1);
                    end;
                    RecItem.Modify();
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
        Message('Price and Margin update Successfully');
    end;

    var
        RecItem: Record Item;
        heading: Boolean;
        entryno: Integer;
        purchprice1: Decimal;
        margin1: Decimal;
}