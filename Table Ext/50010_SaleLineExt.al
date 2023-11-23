tableextension 50010 Saleline extends "Sales Line"
{
    fields
    {


        field(50000; Brand; code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Item Brand".Code;
        }

        field(50001; LT; TEXT[10])
        {
            DataClassification = Tobeclassified;
        }

        field(50002; SPQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50003; MOQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50004; "Commission %"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50005; "Customer Part No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "RFQ Doc No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50007; "Salesperson Code"; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50008; "RFQ Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50009; Application; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Application Master".Code;
        }
        field(50010; project; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Project Master".Code;
        }
        field(50011; "Cost price"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50012; Rate; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50013; "Margin is Less"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(50014; "Price Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(50015; Remarks; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50016; "Allocation Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(50017; "Line Approval Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(50018; "Remaining Approval Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }

        field(50019; "FAE Opportunity Document No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50020; "Fullfillment Type"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = ',Inventory,UID';
            OptionMembers = ,Inventory,UID;
        }
        field(50021; "UID Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50022; "UID"; code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50023; "Part No."; code[20])
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            begin
                UID := "Part No." + '_' + format("UID Date");
            end;
        }
        field(50024; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(50025; "Margin Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Open,Pending For Approval,Approved';
            OptionMembers = Open,"Pending For Approval",Approved;
        }
        field(50026; Partially; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(50027; "Estimated Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50028; "Confirm Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50029; "Cancelation reason"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50030; Cancel; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Quote Status"; Option)
        {
            DataClassification = Tobeclassified;
            OptionCaption = 'Feedback Pending,Lost,WON';
            OptionMembers = "Feedback Pending",Lost,WON;
        }
        field(50032; "Stock Qty"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; Reason; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                reci: Record Item;
                Sadapr: Record "Sada price List";
                RecItem: Record Item;
                SH: Record "Sales Header";
                RecItem1: Record Item;
            begin
                RecItem1.Reset();
                if RecItem1.Get("No.") then
                    Brand := RecItem1.Brand;
                /*
                                if Rec."Document Type" = Rec."Document Type"::Quote then begin
                                    RecItem.Reset();
                                    if RecItem.Get("No.") then;
                                    if RecItem."Price Category" = RecItem."Price Category"::SADA then begin
                                        Sadapr.Reset();
                                        Sadapr.SetRange("Item No. (MPN)", "No.");
                                        Sadapr.SetRange("Customer No.", "Sell-to Customer No.");
                                        Sadapr.SetFilter("Item Start Date", '>= %1', "Posting Date");
                                        Sadapr.SetFilter("Item Expiry Date", '<=%1', "Posting Date");
                                        if Sadapr.FindFirst() then begin
                                            "Unit Price" := Sadapr."DBC. (DCPL Price)";
                                        end;
                                    end;

                                end;
                */
            end;
        }
        field(50034; "Request Date"; Date)
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            begin
                "Requested Delivery Date" := "Request Date";

            end;
        }
    }
    trigger OnBeforeModify()
    var
        saleshipheader: Record "Sales Shipment Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            saleshipheader.Reset();
            saleshipheader.SetRange("Order No.", Rec."No.");
            if saleshipheader.FindFirst() then
                Error('You have already created the shipment for the Order %1', Rec."No.");
        end;
    end;
}