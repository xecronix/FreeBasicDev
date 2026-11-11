#include once "StringAnyDictionary.bi"
#include once "BzList.bi"

#inclib "BzList"
#inclib "StringAnyDictionary"

type StrVal
    v as string
end type


type StringStringDictionary
    public:
        declare Constructor()
        declare Destructor()
        
        declare sub Add(k as string, v as string)
        declare sub Remove(k as string)
        declare function GetVal(k as string) as string
        declare function GetCount() as integer
        declare sub ClearDictionary()
        declare function GetDictionaryKey(idx as integer) as string
        
    private:
        declare function GetNode(k as string) as StrVal ptr
        store as StringAnyDictionary ptr
        trash as BzList ptr
end type
