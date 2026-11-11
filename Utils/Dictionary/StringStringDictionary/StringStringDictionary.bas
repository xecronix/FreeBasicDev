#include once "StringStringDictionary.bi"

Constructor StringStringDictionary()
    this.store = new StringAnyDictionary()
    this.trash = new BzList()
end constructor

Destructor StringStringDictionary()
    this.ClearDictionary()
    delete this.store
    delete this.trash
end destructor

sub StringStringDictionary.Add(k as string, v as string)
    dim pV as StrVal ptr = new StrVal
    this.trash->Add(pV)
    pV->v = v 
    this.store->Add(k, pV)
end sub

sub StringStringDictionary.Remove(k as string)
    this.store->Remove(k)
end sub

function StringStringDictionary.GetDictionaryKey(idx as integer) as string
        return this.store->GetDictionaryKey(idx)
end function

function StringStringDictionary.GetVal(k as string) as string
    dim pNode as StrVal ptr = this.store->GetVal(k)
    if pNode = 0 then
        return ""
    end if
    return pNode->v
end function

function StringStringDictionary.GetCount() as integer
    return this.store->GetCount()
end function

sub StringStringDictionary.ClearDictionary()
    this.store->ClearDictionary()
    
    while this.trash->GetCount() > 0
        dim pNode as StrVal ptr = this.trash->Pop()
        delete pNode
    wend
end sub






