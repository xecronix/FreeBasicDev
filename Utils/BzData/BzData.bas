#include once "BzData.bi"

Constructor BzData()
    records = new BzList()
    fields  = new BzList()
    headers = new BzList()
end constructor

Destructor BzData()
    this.ClearDB()
    delete fields
    delete records
    delete headers
end destructor

sub BzData.ClearDB()
        while (this.fields->GetCount() > 0)
        dim p as BzField ptr = this.fields->Pop()
        delete p
    wend
    
    while (this.records->GetCount() > 0)
        dim p as BzRecord ptr = this.records->Pop()
        delete p
    wend
       
    while (this.headers->GetCount() > 0)
        dim p as BzRecord ptr = this.headers->Pop()
        delete p
    wend
    
end sub

function BzData.ParseStr(dataStr as string) as string
    this.ClearDB()
    dim firstRow as boolean = true
    dim ex as string
    this.dataStr = dataStr
    this.dataIdx = 0
    this.dataPeekIdx = 1
    this.current = ""
    this.forward = ""
    this.lineNum = 1
    this.columnNum = 0
    this.numFields = 0
    this.Advance()
    
    while this.dataIdx <= len(this.dataStr)
        this.SkipWhite()
        if this.dataIdx > len(this.dataStr) then 
            exit while
        end if
        if firstRow = true and this.current = "!" then
            this.Advance() ' consume the !
            this.SkipWhite()
            if this.current <> "|" then
                ex = "Expected | but found [" & this.current & "] on line[" & this.lineNum & "] column[" & this.columnNum & "]"
            else
                this.Advance() ' consume the open |
                ex = this.ParseRecord(BzRecordTypes.HEADER)
            end if
        elseif this.current = "!" then
            this.Advance()
            ex = this.ParseRecord(BzRecordTypes.COMMENT)
        elseif this.current = "|" then
            this.Advance()
            ex = this.ParseRecord(BzRecordTypes.DATA_ROW)
        else
            ex = "Found invalid char [" & this.current & "] on line[" & this.lineNum & "] column[" & this.columnNum & "]"
        end if
        firstRow = false
        if len(ex) > 0 then 
            return ex
        end if
    wend
    this.dataStr = "" ' maybe freebasic will free some memory.  IDK
    return ""
end function

function BzData.GetRow(idx as integer, outval as StringStringDictionary ptr) as boolean
    if outval = 0 then 
        return false
    end if
    outval->ClearDictionary()
    
    if this.headers->GetCount() = 0 then
        return false
    end if
    
    if idx < 0 or idx > this.records->GetCount() - 1 then 
        return false
    end if
    
    dim hdr as BzRecord ptr = this.headers->GetIdx(0)
    dim cols as BzList ptr = hdr->GetFields()
    dim row as BzRecord ptr = this.records->GetIdx(idx)
    dim vals as BzList ptr = row->GetFields()
    dim retval as boolean = false
    
    for i as integer = 0 to cols->GetCount() - 1
        dim fld as BzField ptr
        
        fld = cols->GetIdx(i)
        dim k as string = fld->GetVal()
        
        fld = vals->GetIdx(i)
        dim v as string = fld->GetVal()
        
        outval->Add(k, v)
        retval = true
    next
    return retval
end function

function BzData.GetRecord(idx as integer) as BzRecord ptr
    if idx < 0 or idx >= this.records->GetCount() then
        return 0
    end if
    
    return this.records->GetIdx(idx)
end function

function BzData.GetHeaderRecord() as BzRecord ptr
    if this.headers->GetCount() <> 1 then
        return 0
    end if
    
    return this.headers->GetFirst()
end function

function BzData.GetCount() as integer 
    return this.records->GetCount()
end function

function BzData.Advance() as boolean
    this.dataIdx += 1
    this.dataPeekIdx += 1
    dim retval as boolean = false
    
    this.current = ""    
    this.forward = ""
    if len(this.dataStr) > 0 then
        if this.dataIdx <= len(this.dataStr) then
            retval = true
            this.current = mid(this.dataStr, this.dataIdx, 1)
            if this.current = !"\n" then
                this.lineNum  += 1
                this.columnNum = 1
            else
                this.columnNum += 1
            end if
        end if
        
        if this.dataPeekIdx <= len(this.dataStr) then
            this.forward = mid(this.dataStr, this.dataPeekIdx, 1)
        end if
    end if
    return retval
end function

sub BzData.SkipWhite()
    while len(this.current) > 0 AndAlso len(trim(this.current, Any !" \r\n\t")) = 0
        this.Advance()
    wend
end sub

function BzData.ParseRecord(kind as BzRecordTypes) as string
    dim ex as string = ""
    dim pRec as BzRecord ptr
    if kind = BzRecordTypes.HEADER then
        pRec = new BzRecord(kind)
        this.headers->Add(pRec)
    elseif kind = BzRecordTypes.DATA_ROW then
        pRec = new BzRecord(kind) 
        this.records->Add(pRec)
    end if
    
    if kind = BzRecordTypes.COMMENT then
        while this.dataIdx <= len(this.dataStr) and this.current <> ";"
            this.Advance()
        wend
        if this.current <> ";" then 
            return "Found END OF INPUT while reading field data on line[" & this.lineNum & "] column[" & this.columnNum & "]"
        end if
        this.Advance()
        return ""
    end if
    
    while true
        ex = this.ParseField(pRec)
        if len(ex) > 0 then
            return ex
        end if
        
        if (this.current = ";") then
            exit while
        end if
        
        if this.Advance() = false then
            exit while
        end if
        
    wend
    
    if this.numFields = 0 then
        this.numFields = pRec->GetFields->GetCount()
    else
        if this.numFields <> pRec->GetFields->GetCount() then
            return   "Field/Column count mis-match detected"
        end if
    end if
    this.Advance() ' consume the ;
    return ""
end function

function BzData.ParseFieldComment(fld as BzField ptr) as string
    dim comment as string = "" 
    dim ex as string = ""

    while this.current <> "|" and this.current <> ";"
        comment &= this.current
        if this.Advance() = false then
            exit while
        end if
    wend
    
    if this.current = "|" or this.current = ";" or this.forward = ";" then 
        fld->SetComment(comment)    
    else
        return "Found END OF INPUT while reading field comment on line[" & this.lineNum & "] column[" & this.columnNum & "]"    
    end if
    
    return ""
end function

function BzData.ParseField(rec as BzRecord ptr) as string
    dim fieldData as string  = "" 
    dim ex as string = ""
    dim fld as BzField ptr = new BzField()
    this.fields->Add(fld)
    
    while  this.current <> "|"
        if this.current = "\" then
            if this.forward = "\" or this.forward = "|"  then
                fieldData &= this.forward
                this.Advance()
            else
                fieldData &= this.current
            end if
        else    
            fieldData &= this.current
        end if 
        
        if this.Advance() = false then
            exit while
        end if
    wend
   
    if this.current <> "|" then 
        return "Found END OF INPUT while reading field data on line[" & this.lineNum & "] column[" & this.columnNum & "]"
    end if

    fld->SetVal(fieldData)
    this.Advance()
    ex = this.ParseFieldComment(fld)
    if len(ex) <> 0 then
        return ex
    end if
    rec->AddField(fld)
    return ""
end function

function BzData.ToString() as string
    dim retval as string = ""
    dim pRec as BzRecord ptr
    if  this.headers->GetCount()  =1 then
        retval = "!"
        pRec = this.headers->GetFirst()
        retval &= pRec->ToString()
    end if
       
    for i as integer = 0 to this.records->GetCount() - 1
        pRec = this.records->GetIdx(i)
        retval &= pRec->ToString()
    next
    return retval

end function
