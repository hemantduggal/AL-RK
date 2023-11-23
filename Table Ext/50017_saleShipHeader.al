tableextension 50017 SaleShipHead extends "Sales Shipment Header"
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
        field(50010; "Sale Order type"; Option)
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
        }
        field(50015; Narration; Text[100])
        {
            DataClassification = Tobeclassified;
        }
        field(50017; "Customer PO No."; Code[20])
        {
            DataClassification = Tobeclassified;
        }
        field(50018; Zone; Code[10])
        {
            DataClassification = Tobeclassified;
        }
    }
}