xmlport 50004 "PriceCat&AllocationType"
{
    Caption = 'Price Cat&Allocation Type Uploader';
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
                textattribute(Pricecategory)
                {

                }
                textattribute(AllocationType)
                {

                }


                trigger OnBeforeInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;
                    Evaluate(Pricecategory1, Pricecategory);
                    Evaluate(Allocationtype1, AllocationType);


                    RecItem.Reset();
                    RecItem.SetRange("No.", ItemNo);
                    if RecItem.FindFirst() then begin
                        Evaluate(Pricecategory1, Pricecategory);
                        RecItem.validate("Price Category", Pricecategory1);
                        Evaluate(Allocationtype1, AllocationType);
                        RecItem.validate("Allocation Type", Allocationtype1);
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
        Message('Price Category and allocation type updated Successfully');
    end;

    var
        RecItem: Record Item;
        heading: Boolean;
        entryno: Integer;
        Allocationtype1: Option ,Allocate,"Non- Allocate";
        Pricecategory1: Option ,SADA,"Non-SADA";
}