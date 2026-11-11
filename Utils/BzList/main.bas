#include once "BzList.bi"

print "================================" 
print "======= BzList Demo ========" 
print "================================" 
print ""
print "Heap Example:"

sub printList(lst as BzList ptr)
    dim pStr as string ptr
    for i as integer = 0 to lst->GetCount() - 1
    ' GetIdx returns an Any Ptr to the subject data.  
    ' One of the strings str1 -  str4 in this case. 
    pStr = lst->GetIdx(i) 
    print *pStr ' Notice value of operator * to deref the pointer.
next    
end sub

dim pStringList as BzList ptr = new BzList()
dim str1 as string = "String 1"
dim str2 as string = "String 2"
dim str3 as string = "String 3"
dim str4 as string = "String 4"
dim str5 as string = "Insert to Head"

pStringList->Add(@str1)
pStringList->Add(@str2)
pStringList->Add(@str4)

pStringList->InsertAt(2,@str3)
pStringList->InsertAt(0,@str5)
pStringList->InsertAt(99,@str5)
pStringList->InsertAt(-1,@str5)

printList(pStringList)
delete pStringList

' can also use the BzList on the stack instead of the heap
print ""
print "Stack Example:"
dim stringList as BzList

stringList.Add(@str1)
stringList.Add(@str2)
stringList.Add(@str3)
stringList.Add(@str4)

printList(@stringList)

print ""
print "remove tail:"
stringList.Remove(3)
printList(@stringList)

print ""
print "remove middle"
stringList.Remove(1)
printList(@stringList)

print ""
print "remove head"
stringList.Remove(0)
printList(@stringList)

print "Elements in list: "; str(stringList.GetCount())
print ""
print "remove head (again)"
stringList.Remove(0)
printList(@stringList)

print "Elements in list: "; str(stringList.GetCount())

Sleep
