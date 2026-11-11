#include once "BzData.bi"

Constructor BzRecord (kind as BzRecordTypes)
    this.kind = kind
    fields = new BzList()
end constructor

Destructor BzRecord ()
    delete fields
end destructor

sub BzRecord.AddField(fieldData as BzField ptr)
    this.fields->Add(fieldData)
end sub

function BzRecord.GetFields() as BzList ptr
    return this.fields
end function

function BzRecord.GetKind() as BzRecordTypes
    return this.kind
end function


function BzRecord.ToString() as string
    dim retval as string = ""
    for i as integer = 0 to fields->GetCount() - 1
        dim fld as BzField ptr = fields->GetIdx(i)
        retval &= fld->ToString()
    next
    retval &= !";\n"
    return retval
end function





