tableextension 50028 PostGateentryHead extends "Posted Gate Entry Header"
{
    fields
    {
        field(50000; "Container No."; Code[30])
        {
            DataClassification = Tobeclassified;
        }
        field(50001; "Transporter No."; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50002; "Source No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}