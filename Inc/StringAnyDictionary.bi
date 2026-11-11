#include once "BzList.bi"
#inclib "BzList"

type StrKeyVal
    k as string
    pV as any ptr
end type


type StringAnyDictionary
    public:
        declare Constructor()
        declare Destructor()
        
        declare sub Add(k as string, pV as any ptr)
        declare sub Remove(k as string)
        declare function GetVal(k as string) as any ptr
        declare function GetCount() as integer
        declare sub ClearDictionary()
        declare function GetDictionaryKey(idx as integer) as string
        
    private:
        declare function GetNode(k as string) as StrKeyVal ptr
        store as BzList ptr
end type
