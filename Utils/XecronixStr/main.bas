#include once "XecronixStr.bi"

print "==============================="
print "===    XecronixStr Demo     ==="
print "==============================="
print ""
Print "JoinStrings:"
dim strs(...) as String = {"House", "Car", "Cat"}
print JoinStrings(strs(), " -> ")
print JoinStrings(strs(), ",")
print JoinStrings(strs(), !",\n")

sleep
