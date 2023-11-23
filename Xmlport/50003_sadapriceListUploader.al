xmlport 50003 "Sada Price List Uploader"
{
    Caption = 'Sada Price Uploader';
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

                textattribute(AccountNo)
                {

                }
                textattribute(ItemNo)
                {

                }
                textattribute(ItemName)
                {

                }
                textattribute(CustomerNo)
                {


                }
                textattribute(CustomerName)
                {

                }
                textattribute(EndCustomerName)
                {

                }
                textattribute(DebitNumber)
                {

                }
                textattribute(ItemStartDate)
                {

                }
                textattribute(ItemExpiryDate)
                {

                }
                textattribute(Currency)
                {

                }
                textattribute(DebitOpenQty)
                {

                }
                textattribute(DebitShipQty)
                {

                }
                textattribute(DebitRemQty)
                {

                }
                textattribute(DebitOpenQtyPercentage)
                {

                }
                textattribute(AdjCost)
                {

                }
                textattribute(AdjResale)
                {

                }
                textattribute(DBCDCPLPrice)
                {

                }
                textattribute(RemainingQty)
                {

                }
                textattribute(BuyingCustomer1)
                {

                }
                textattribute(BuyingCustomer2)
                {

                }
                textattribute(BuyingCustomer3)
                {

                }
                textattribute(BuyingCustomer4)
                {

                }
                textattribute(BuyingCustomer5)
                {

                }
                textattribute(BuyingCustomerQty1)
                {

                }
                textattribute(BuyingCustomerQty2)
                {

                }
                textattribute(BuyingCustomerQty3)
                {

                }
                textattribute(BuyingCustomerQty4)
                {

                }
                textattribute(BuyingCustomerQty5)
                {

                }
                trigger OnBeforeInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;
                    Evaluate("ItemStartDate1", ItemStartDate);
                    Evaluate(ItemExpiryDate1, ItemExpiryDate);
                    Evaluate(Currency1, Currency);
                    Evaluate(DebitOpenQty1, DebitOpenQty);
                    Evaluate(DebitShipQty1, DebitShipQty);
                    Evaluate(DebitRemQty1, DebitRemQty);
                    Evaluate(DebitOpenQtyPercentage1, DebitOpenQtyPercentage);
                    Evaluate(AdjCost1, AdjCost);
                    Evaluate(AdjResale1, AdjResale);
                    Evaluate(DBCDCPLPrice1, DBCDCPLPrice);
                    Evaluate(RemainingQty1, RemainingQty);

                    Sadaprice1.Reset();
                    if SadaPrice1.FindLast() then begin
                        entryno := SadaPrice1."Entry No" + 1;
                    end;
                    SP.Reset();
                    SP.Init();
                    sp."Entry No" := entryno;
                    SP.Insert();

                    sp."Account No." := AccountNo;
                    SP."Item No. (MPN)" := ItemNo;
                    SP."Item Name" := ItemName;
                    SP."Customer No." := CustomerNo;
                    SP."Customer Name" := CustomerName;
                    SP."End Customer Name" := EndCustomerName;
                    SP."Debit Number" := DebitNumber;
                    SP."Item Start Date" := ItemStartDate1;
                    SP."Item Expiry Date" := ItemExpiryDate1;
                    SP.Currency := Currency1;
                    SP."Debit Open Qty" := DebitOpenQty1;
                    SP."Debit Ship Qty" := DebitShipQty1;
                    SP."Debit Rem. Qty" := DebitRemQty1;
                    SP."Debit Open Qty Percentage" := DebitOpenQtyPercentage1;
                    SP."Adj. Cost" := AdjCost1;
                    SP."Adj. Resale" := AdjResale1;
                    SP."DBC. (DCPL Price)" := DBCDCPLPrice1;
                    SP."Remaining Qty" := RemainingQty1;
                    SP."Buying Customer 1" := BuyingCustomer1;
                    SP."Buying Customer 2" := BuyingCustomer2;
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
        Message('Sada Price list Import Successfully');
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
        SP: Record "Sada price List";
        heading: Boolean;
        entryno: Integer;
        ItemStartDate1: Date;

        ItemExpiryDate1: Date;
        Currency1: Decimal;
        DebitOpenQty1: Decimal;
        DebitShipQty1: Decimal;
        DebitRemQty1: Decimal;
        DebitOpenQtyPercentage1: Decimal;
        AdjCost1: Decimal;
        AdjResale1: Decimal;
        DBCDCPLPrice1: Decimal;
        RemainingQty1: Decimal;
}