
#include once "BzList.bi"

' ==========================================
' METHOD IMPLEMENTATIONS
' ==========================================

constructor BzList()
    this.count = 0
    this.head = 0
    this.tail = 0
    this.areIndexesValid = false
    this.pIndexes = 0
end constructor

' Destructor implementation (Handles automatic memory cleanup)
destructor BzList()
    this.ClearList()
    deallocate this.pIndexes
end destructor

sub BzList.BuildIndex()
    if this.areIndexesValid = true then
        return
    end if
    
    if this.count = 0 then
        return
    end if
    
    this.pIndexes = reallocate(this.pIndexes, this.count * sizeof(ListNode ptr))
    dim pNode as ListNode ptr = this.head
    for i as integer = 0 to this.count - 1
        this.pIndexes[i] = pNode
        pNode = pNode->forward
    next
    this.areIndexesValid = true

end sub

function BzList.IsSafeIndex(idx as integer) as boolean
    if idx < 0 or idx > this.count - 1 or this.count = 0 then
        return false
    end if
    return true
end function

function BzList.Add(s as any ptr) as boolean
    dim newNode as ListNode ptr = new ListNode
    newNode->subject = s
    newNode->forward = 0
    newNode->backward = 0

    if (this.head = 0) then
        this.head = newNode
        this.tail = newNode
        this.count = 1
    else
        newNode->backward = this.tail
        this.tail->forward = newNode
        this.tail = newNode
        this.count = this.count + 1
    end if
    this.areIndexesValid = false
    return true
end function

function BzList.InsertAt(idx as integer, s as any ptr) as boolean
    
    if idx > this.count or idx < 0 then 
        return false
    end if
    
    if this.count = 0 or idx = this.count then
        return this.Add(s)
    end if
    
    dim newNode as ListNode ptr = new ListNode
    newNode->subject = s
    newNode->forward = 0
    newNode->backward = 0
    
    if idx = 0 then
        newNode->forward = this.head
        this.head = newNode
        this.head->forward->backward = this.head
    else
        dim h as ListNode ptr = this.GetNode(idx - 1)
        dim f as ListNode ptr = this.GetNode(idx)

        h->forward = newNode
        newNode->backward = h
        newNode->forward = f
        f->backward = newNode
        
    end if
    this.areIndexesValid = false
    this.count += 1
    
    return true
end function

function BzList.Remove(idx as integer) as any ptr
    if this.IsSafeIndex(idx) = false  then 
        return 0
    end if
       
    dim pNode as ListNode ptr = this.GetNode(idx)
    dim pRetval as any ptr = 0
    
    if pNode = 0 then 
        return 0
    end if
    
    ' idx is head of list
    if idx = 0 then
        if this.count > 1 then
            this.head = pNode->forward
            this.head->backward = 0
        else
            this.head = 0
            this.tail = 0
        end if
    
    ' idx is tail of list
    elseif idx = this.count - 1 then
        pNode->backward->forward = 0
        this.tail = pNode->backward
        
    ' remove idx somewhere within the list
    else
        pNode->backward->forward = pNode->forward
        pNode->forward->backward = pNode->backward
    end if
    
    pRetval = pNode->subject
    delete pNode
    this.areIndexesValid = false
    this.count -= 1
    return pRetval    
end function

' Read-only property helper
function BzList.GetCount() as integer
    return this.count
end function

function BzList.GetNode(idx as integer) as ListNode ptr
    this.BuildIndex()
    if this.IsSafeIndex(idx) = true then
        dim pNode as ListNode ptr = this.pIndexes[idx]
        return pNode
    end if
    return 0    
end function

function BzList.GetIdx(idx as integer) as any ptr
    this.BuildIndex()
    if this.IsSafeIndex(idx) = true then
        dim pNode as ListNode ptr = this.pIndexes[idx]
        return pNode->subject
    end if
    return 0
end function

function BzList.GetFirst() as any ptr
    if this.head = 0 then return 0
    return this.head->subject
end function

function BzList.GetLast() as any ptr
    if this.tail = 0 then return 0
    return this.tail->subject
end function

sub BzList.ClearList() 
    dim current as ListNode ptr = this.head
    while current <> 0
        dim nextNode as ListNode ptr = current->forward
        delete current
        current = nextNode
    wend
    this.head = 0
    this.tail = 0 
    this.count = 0
    this.areIndexesValid = false
end sub

function BzList.Pop() as any ptr
    if this.count = 0 then
        return 0
    end if
    
    dim retval as any ptr
    dim node as ListNode ptr = this.tail
    
    if this.count = 1 then
        this.head = 0
        this.tail = 0
    else
        this.tail = node->backward
        this.tail->forward = 0
    end if   
    
    this.count -= 1
    retval = node->subject
    delete node
    this.areIndexesValid = false
    return retval
end function
