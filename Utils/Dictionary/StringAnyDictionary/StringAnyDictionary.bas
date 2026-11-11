#include once "StringAnyDictionary.bi"
#include once "BzList.bi"

Constructor StringAnyDictionary()
    this.store = new BzList()
end constructor

Destructor StringAnyDictionary()
    this.ClearDictionary()
    delete this.store
end destructor

sub StringAnyDictionary.Add(k as string, pV as any ptr)
    dim pNode as StrKeyVal ptr = this.GetNode(k)
    if pNode <> 0 then
        pNode->pV = pV
    else
        pNode = new StrKeyVal
        pNode->k = k
        pNode->pV = pV
        this.store->Add(pNode)
    end if
end sub

sub StringAnyDictionary.Remove(k as string)
    dim pNode as StrKeyVal ptr
    for i as integer = 0 to this.store->GetCount() - 1
        pNode = this.store->GetIdx(i)
        if pNode->k = k then
            this.store->Remove(i)
            delete pNode
            exit sub
        end if
    next
end sub

function StringAnyDictionary.GetDictionaryKey(idx as integer) as string
    dim pNode as StrKeyVal ptr = this.store->GetIdx(idx)
    if pNode = 0 then
        return ""
    end if
    return pNode->k
end function

function StringAnyDictionary.GetVal(k as string) as any ptr
    dim pNode as StrKeyVal ptr = this.GetNode(k)
    if pNode = 0 then
        return 0
    end if
    return pNode->pV
end function

function StringAnyDictionary.GetNode(k as string) as StrKeyVal ptr
    dim pNode as StrKeyVal ptr
    for i as integer = 0 to this.store->GetCount() - 1
        pNode = this.store->GetIdx(i)
        if pNode->k = k then
            return pNode
        end if
    next
    return 0
end function

function StringAnyDictionary.GetCount() as integer
    return this.store->GetCount()
end function

sub StringAnyDictionary.ClearDictionary()
    dim pNode as StrKeyVal ptr
    for i as integer = 0 to this.store->GetCount() - 1
        pNode = this.store->pop()
        delete pNode
    next
end sub






