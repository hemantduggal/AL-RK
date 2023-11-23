tableextension 50003 LocationExt1 extends Location
{
    fields
    {
        field(50000; "Location Type"; Code[20])
        {
            DataClassification = Tobeclassified;
            TableRelation = "Location Type".Code;
        }
    }
}