#include once "BzData.bi"

Function JoinStrings(arr() As String, delimiter As String) As String
    Dim As String result = ""
    For i As Integer = LBound(arr) To UBound(arr)
        result &= arr(i)
        If i < UBound(arr) Then result &= delimiter
    Next i
    Return result
End Function

'!"      \t\t\t  \n \r\r  !      \t\t\t  \n \r\r  |fruit||color||qty|;", _
dim db as BzData
dim as String records(...) = { _
!"      \t\t\t  \n \r\r  !      \t\t\t  \n \r\r  |fruit||color||qty|;", _
"|        banana          \|  ||yellow||1|;", _
"|grape||green||2|;", _
"|apple||red||3|;" _
}


dim dataStr as string = JoinStrings(records(), !"      \t\t\t  \n \r\r   ")
dim ex as string  = db.ParseStr(dataStr)
if len(ex) > 0 then
    print ex
else
    print db.ToString()
end if

dim row as StringStringDictionary

db.GetRow(0, @row)
print row.GetVal("fruit")
print row.GetVal("color")
print row.GetVal("qty")

db.GetRow(1, @row)
print row.GetVal("fruit")
print row.GetVal("color")
print row.GetVal("qty")

db.GetRow(2, @row)
print row.GetVal("fruit")
print row.GetVal("color")
print row.GetVal("qty")


if db.GetRow(3, @row) = true then
    print row.GetVal("fruit")
    print row.GetVal("color")
    print row.GetVal("qty")
end if

' check the return value.  
' true is success false is fail.  
db.GetRow(3, @row)
print row.GetVal("fruit")
print row.GetVal("color")
print row.GetVal("qty")

sleep