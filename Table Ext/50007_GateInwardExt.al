tableextension 50007 GateInwardExt extends "Gate Entry Header"
{
    fields
    {
        field(50000; "Container No."; Code[30])
        {
            DataClassification = Tobeclassified;
        }
        field(50001; "Transporter Name"; Code[10])
        {
            DataClassification = Tobeclassified;
        }
        field(50002; "Source No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Driver Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Mobile No."; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Reason; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Damage,Short,Access;
        }
    }
}
