table 50007 "Sales RFQ Line"
{
    fields
    {
        field(1; "RFQ Doc No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = IF (Type = CONST(FA)) "Fixed Asset"."No."
            ELSE
            IF (Type = CONST(Item)) Item."No.";

            trigger OnValidate()
            var
                p: Page 32;
                RecItem: Record Item;
                saleRfq: Record "Sales RFQ Header";
                Sadapr: Record "Sada price List";
                linewiseappsetup: Record Linewiseapprovalsetup;
                ItemBrand: Record "Item Brand";
            begin
                RecItem.Reset();
                RecItem.get("Item No.");
                Description := RecItem.Description;
                "Description 2" := RecItem."Search Description";

                UOM := RecItem."Base Unit of Measure";
                Brand := RecItem.Brand;
                MOQ := RecItem."MOQ(Minimum order Qty)";
                SPQ := RecItem."SPQ(Std. product Qty)";
                LT := RecItem."Lead Time";
                saleRfq.Reset();
                saleRfq.Get("RFQ Doc No.");
                Salesperson := saleRfq.Salesperson;
                "Customer No." := saleRfq."Customer No.";
                "Document Date" := saleRfq."Document Date";
                "Location Code" := saleRfq.Location;
                "Customer Name" := saleRfq."Customer Name";
                ItemBrand.Reset();
                ItemBrand.SetRange(Code, Brand);
                if ItemBrand.FindFirst() then begin
                    "Product Manager" := ItemBrand."Product Manager";
                    "Product Manager 2" := ItemBrand."Product Manager 2";
                    "Product Manager Assistant" := ItemBrand."Product Manager Assistant";
                    "Product Manager Assistant 2" := ItemBrand."Product Manager Assistant 2";
                end;
                /*
                linewiseappsetup.Reset();
                linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Price Update");
                if linewiseappsetup.FindFirst() then begin
                    if linewiseappsetup.Enable = true then begin

                        if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
                            Sadapr.Reset();
                            Sadapr.SetRange("Item No. (MPN)", "Item No.");
                            Sadapr.SetRange("Customer No.", "Customer No.");
                            Sadapr.SetFilter("Item Start Date", '<= %1', "Document Date");
                            Sadapr.SetFilter("Item Expiry Date", '>=%1', "Document Date");
                            if Sadapr.FindFirst() then begin
                                "Direct Unit Cost" := Sadapr."DBC. (DCPL Price)";
                                "Price Update Status" := "Price Update Status"::"Pending For Approval";
                                Message('Approval request sent');
                            end else begin
                                "Direct Unit Cost" := RecItem."Unit Cost";
                                "Price Update Status" := "Price Update Status"::"Pending For Approval";
                                Message('Approval request sent');
                            end;

                        end;
                    end;
                  
            end;
  */
                "Direct Unit Cost" := RecItem."Unit Cost";
            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(4; Quantity; Decimal)
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            begin
                Rate := Quantity * "Direct Unit Cost";
            end;
        }
        field(5; "Customer No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(6; UOM; Text[30])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Unit of Measure".Code;

        }
        field(7; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Target Price';
            DecimalPlaces = 0 : 5;
            DataClassification = Tobeclassified;
            trigger OnValidate()
            var
                RecItem: Record Item;
                linewiseappsetup: Record Linewiseapprovalsetup;
            begin
                linewiseappsetup.Reset();
                linewiseappsetup.SetFilter("On the Basis", '%1', linewiseappsetup."On the Basis"::"Less Margin");
                if linewiseappsetup.FindFirst() then begin
                    if linewiseappsetup.Enable = true then begin
                        RecItem.Reset();
                        RecItem.Get(Rec."Item No.");
                        if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
                            if "Direct Unit Cost" < (RecItem."DCPL Price" + RecItem."Margin %") then begin
                                "Margin is Less" := true;
                                //send margin approval req to sales head
                                "Margin Less Status" := "Margin Less Status"::"Pending For Approval";
                                Message('Approval request sent to sales Head Due to margin is less then the mentioned in item');
                            end;
                        end else begin
                            if "Direct Unit Cost" < (RecItem."Purchase price" + RecItem."Margin %") then begin
                                "Margin is Less" := true;
                                //send margin approval req to sales head
                                "Margin Less Status" := "Margin Less Status"::"Pending For Approval";
                                Message('Approval request sent to sales Head Due to margin is less then the mentioned in item');
                            end;
                        end;
                    end;
                end;
                Rate := Quantity * "Direct Unit Cost";
            end;
        }
        field(8; Rate; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(9; Brand; Code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Item Brand".Code;
        }
        field(10; Application; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Application Master".Code;
        }
        field(11; project; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Project Master".Code;
        }
        field(12; Salesperson; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(13; "Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(14; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Item,FA;
            //Editable = false;
        }
        field(15; "Cost price"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(16; "Design Part No."; code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Customer Design Part"."Design Part No.";
        }
        field(17; "Document Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(18; "Replenishment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","sales Quote","sales Order";
            trigger OnValidate()
            begin

            end;
        }
        field(19; "Location Code"; Code[30])
        {
            DataClassification = Tobeclassified;
            TableRelation = Location.Code;
        }
        field(20; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released,"SO Created";
        }
        field(21; LT; TEXT[10])
        {
            DataClassification = Tobeclassified;
        }
        field(22; SPQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(23; MOQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(24; "Approval Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(25; Remarks; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(26; "Margin is Less"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(27; "Margin Less Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(28; "Price Update Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(29; "Brand Approval Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(30; "Quote Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(31; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Confirm Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(34; "Estimated Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50035; "Cancelation reason"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50036; Cancel; Boolean)
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            begin
                if "Quote Created" = false then begin
                    if Cancel = true then
                        TestField("Cancelation reason");
                end else
                    Error('Quote already created for the line no %1', "Line No.");
            end;
        }
        field(37; "Product Manager"; Text[50])
        {
            DataClassification = Tobeclassified;
        }

        field(38; "Product Manager Assistant"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(39; "Product Manager 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(40; "Product Manager Assistant 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
        field(41; "Customer Part No."; Text[50])
        {
            DataClassification = Tobeclassified;
            // TableRelation = "Customer Design Part"."Design Part No.";
        }
        field(42; "Description 2"; Text[50])
        {
            DataClassification = Tobeclassified;
        }
    }

    keys
    {
        key(Key1; "RFQ Doc No.", "Line No.")
        {

            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    var

    begin
        /*
        if "Brand Approval Status" = "Brand Approval Status"::Approved then
            Error('You can not delete approved line');
        if "Margin Less Status" = "Margin Less Status"::Approved then
            Error('You can not delete approved line');
        if "Price Update Status" = "Price Update Status"::Approved then
            Error('You can not delete approved line');
*/
    end;

    trigger OnModify()
    begin
        if ("Quote Created" = true) then
            Error('Quote already created for the line no %1', "Line No.");
    end;

    var
        GLAcc: Record 15;
        Item: Record 27;
}

