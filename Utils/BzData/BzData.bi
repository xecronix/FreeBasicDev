#include once "BzList.bi"
#include once "StringStringDictionary.bi"

#inclib "BzList"
#inclib "StringStringDictionary"
#inclib "StringAnyDictionary"

type BzField
    public:
        declare Constructor(fieldValue as string = "", fieldComment as string = "")
        declare Destructor()
        
        declare function GetComment() as string
        declare function GetVal() as string
        
        declare sub SetComment(c as string)
        declare sub SetVal(v as string) 
        
        declare function ToString() as string
        
    private:
        comment as string
        valstr as string
end type

enum BzRecordTypes
    COMMENT
    DATA_ROW
    HEADER
end enum

type BzRecord
    public:
        declare Constructor(kind as BzRecordTypes)
        declare Destructor()
        
        declare sub AddField(field as BzField ptr)
        declare function GetFields() as BzList ptr
        declare function GetKind() as BzRecordTypes
        
        declare function ToString() as string
        
    private:
        fields as BzList ptr
        kind as BzRecordTypes
end type


type BzData
    public:
        declare Constructor()
        declare Destructor()
        declare function ParseStr(dataStr as string) as string
        declare function GetRow(idx as integer, outval as StringStringDictionary ptr) as boolean
        declare function GetRecord(idx as integer) as BzRecord ptr
        declare function GetHeaderRecord() as BzRecord ptr
        declare function GetCount() as integer
        declare function ToString as string
        declare sub ClearDB()
        
    private:
        declare function ParseRecord(kind as BzRecordTypes) as string
        declare function ParseFieldComment(fld as BzField ptr) as string
        declare function ParseField(rec as BzRecord ptr) as string
        declare function Advance() as boolean
        declare sub SkipWhite()
        
        records as BzList ptr
        fields as BzList ptr
        headers as BzList ptr
        dataStr as string
        dataIdx as integer
        dataPeekIdx as integer
        lineNum as integer
        columnNum as integer
        current as string
        forward as string
        numFields as integer
        
end type  


