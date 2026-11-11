#include once "XecronixStr.bi"

Function JoinStrings(arr() As String, delimiter As String) As String
    Dim As String result = ""
    For i As Integer = LBound(arr) To UBound(arr)
        result &= arr(i)
        If i < UBound(arr) Then result &= delimiter
    Next i
    Return result
End Function