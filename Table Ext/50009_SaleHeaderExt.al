tableextension 50009 SaleHead extends "Sales Header"
{
    fields
    {
        field(50000; Remarks; text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50001; "Deriver Mobile No."; text[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50002; "Final Destination"; text[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50003; "Pre-Carriage"; text[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50004; "Vessel/Flight No."; text[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50005; "Port of Discharge"; text[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50006; "Port of  Loading"; text[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50007; "Place of Rcpt by Pre. Carg"; text[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50008; "Terms of Delivery"; text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50009; "Short Close"; Boolean)
        {
            DataClassification = Tobeclassified;
        }
        field(50010; "Sale Order Type"; Option)
        {
            OptionMembers = ,Domestic,Export;
        }
        field(50011; "RFQ Doc No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50012; "FAE Opportunity Document No."; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "FAE Header"."Opportunity Document No.";
        }
        field(50013; "Gate Entry No."; Code[20])
        {
            // TableRelation = "Posted Gate Entry Header"."No.";
            //WHERE("Entry Type" = filter(Outward), "Source No." = field("No."));
            /*
            NotBlank = true;
            TableRelation = "Posted Gate Entry Header"."No." WHERE("Entry Type" = filter(Outward),
            "Location Code" = FIELD("Location Code"));
            */
        }
        field(50014; "So Type"; Option)
        {
            OptionMembers = ,Sample,Regular;
        }
        field(50015; Narration; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50017; "Customer PO No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50018; Zone; Code[20])
        {
            DataClassification = Tobeclassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(50019; "Cancelation reason"; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50020; Cancel; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Dummy Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Quote Validity"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50023; "Salesperson"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                cust: Record Customer;
            begin
                cust.Reset();
                cust.SetRange("No.", "Sell-to Customer No.");
                if cust.FindFirst() then begin
                    Zone := cust.Zone;
                    Salesperson := cust."Salesperson Code";
                end;
            end;
        }
    }
    trigger OnAfterInsert()
    var
        UserSetRec: Record "User Setup";
    begin
        UserSetRec.Get(UserId);
        Zone := UserSetRec.Zone;
        Salesperson := UserSetRec.Salesperson;
        "Shortcut Dimension 2 Code" := UserSetRec.Branch;
    end;

    trigger OnBeforeModify()
    var
        saleshipheader: Record "Sales Shipment Header";
    begin
        if "Document Type" = "Document Type"::Order then begin
            saleshipheader.Reset();
            saleshipheader.SetRange("Order No.", "No.");
            if saleshipheader.FindFirst() then
                Error('You have already created the shipment for the Order %1', "No.");
        end;
    end;
}

