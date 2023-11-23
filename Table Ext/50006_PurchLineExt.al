tableextension 50006 PurLineExt extends "Purchase Line"
{
    fields
    {

        field(50000; "Requisition No."; Code[20])
        {
            DataClassification = Tobeclassified;

        }
        field(50001; "Requisition Line No."; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50002; Application; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Application Master".Code;
        }
        field(50003; project; Code[40])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Project Master".Code;
        }
        field(50004; "Delivery Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50005; POP; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50006; BQ; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50007; "End Customer"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = Customer."No.";
        }
        field(50008; LT; TEXT[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50009; SPQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50010; MOQ; Integer)
        {
            DataClassification = Tobeclassified;
        }
        field(50011; "Employee Code"; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50012; "MOQ Value"; Decimal)
        {
            DataClassification = Tobeclassified;
            DecimalPlaces = 0 : 5;
        }
        field(50013; "Brand Name"; code[10])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Item Brand".Code;
        }
        field(50014; "Remarks"; Text[100])
        {
            DataClassification = Tobeclassified;
        }

        field(50015; "Estimated Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50016; "Confirm Date"; Date)
        {
            DataClassification = Tobeclassified;
        }
        field(50017; "Make Order Qty"; Decimal)
        {
            DataClassification = Tobeclassified;

        }
        field(50018; "Remaining Qty"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(50019; "Total Qty"; Decimal)
        {
            DataClassification = Tobeclassified;
        }
        field(50020; "Commision"; Decimal)
        {
            DataClassification = Tobeclassified;
            trigger OnValidate()
            begin

                if Rec.Commision <> 0 then begin
                    Rec."Line Amount" := Rec.Quantity * Rec."Direct Unit Cost";
                    Rec.Validate("Line Amount");
                    Rec."Line Amount" := Rec."Line Amount" + (Rec."Line Amount" * Rec.Commision) / 100;
                END else begin
                    Rec."Line Amount" := Rec.Quantity * Rec."Direct Unit Cost";
                    Rec.Validate("Line Amount");
                END;
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                if Rec.Commision <> 0 then begin
                    Rec."Line Amount" := Rec.Quantity * Rec."Direct Unit Cost";
                    Rec."Line Amount" := Rec."Line Amount" + (Rec."Line Amount" * Rec.Commision) / 100;
                    Rec."Line Amount" := Rec."Line Amount" - (Rec."Line Amount" * Rec."Line Discount %") / 100;
                end;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                if "Document Type" = "Document Type"::Quote then begin
                    "Total Qty" := Quantity;
                    "Remaining Qty" := Quantity;
                end;

            end;
        }
    }
}