
type ListNode
    backward as ListNode ptr
    forward  as ListNode ptr
    subject  as any ptr
end type

' Define the LinkedList Type as a Class object
type BzList
    public:
        declare constructor()
        declare destructor()
        declare function Add(s as any ptr) as boolean
        declare function InsertAt(idx as integer, s as any ptr) as boolean
        declare function Remove(idx as integer) as any ptr
        declare function GetIdx(idx as integer) as any ptr
        declare function GetFirst() as any ptr
        declare function GetLast() as any ptr
        declare sub ClearList()
        declare function Pop() as any ptr
        declare function GetCount() as integer

    private:
        declare sub BuildIndex()
        declare function GetNode(idx as integer) as ListNode ptr
        declare function IsSafeIndex(idx as integer) as boolean
        count as integer
        head as ListNode ptr
        tail as ListNode ptr
        pIndexes as ListNode ptr ptr
        areIndexesValid as boolean
end type
