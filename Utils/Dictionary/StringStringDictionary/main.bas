#include once "StringStringDictionary.bi"

print "================================" 
print "==  StringAnyDictionary Demo  ==" 
print "================================" 
print ""

dim sd as StringStringDictionary 

sd.Add("apple", "red")
sd.Add("banana", "yellow")
sd.Add("grape", "green")
Print sd.GetCount()  ' should be 3
print "A Banana is a "; sd.GetDictionaryKey(1) ' should be banana
' what color is a banana
dim c as string = sd.GetVal("banana")
print "A banana is: "; c

' let's change the color
sd.Add("banana", "green")
c = sd.GetVal("banana")
Print "Now a banana is: "; c
Print sd.GetCount() ' still should be 3

' lets loose the banana
sd.Remove("banana")
print "The key is: "; sd.GetDictionaryKey(1) ' should be grape
Print sd.GetCount() ' should be 2

Sleep
