#include once "BzData.bi"

Constructor BzField(fieldValue as string = "", fieldComment as string = "")
    this.SetVal(fieldValue)
    this.SetComment(fieldComment)
end constructor

Destructor BzField()
end destructor
        
function BzField.GetComment() as string
    return this.comment
end function

function BzField.GetVal() as string
    return this.valstr
end function
        
sub BzField.SetComment(fieldComment as string) 
    this.comment = fieldComment
end sub

sub BzField.SetVal(fieldValue as string) 
    this.valstr = fieldValue
end sub

function BzField.ToString() as string
    dim escaped as string = ""

    for i as integer = 1 to len(this.valstr)
        dim ch as string = mid(this.valstr, i, 1)

        if ch = "\" or ch = "|" then
            escaped &= "\"
        end if

        escaped &= ch
    next i
    return "|" & escaped & "|" & this.comment
end function
