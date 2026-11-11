
@echo off
rem File: build.bat

setlocal
set "ROOT=%~dp0"
set "FBC=fbc"

if not exist "%ROOT%Lib" mkdir "%ROOT%Lib"
if not exist "%ROOT%Inc" mkdir "%ROOT%Inc"

rem ==========================================
rem Build BzList
rem ==========================================

"%FBC%" -lib ^
    -i "%ROOT%Utils\BzList" ^
    "%ROOT%Utils\BzList\BzList.bas" ^
    -x "%ROOT%Lib\libBzList.a"

if errorlevel 1 exit /b 1

copy /y "%ROOT%Utils\BzList\BzList.bi" "%ROOT%Inc\BzList.bi" >nul
if errorlevel 1 exit /b 1

echo BzList build successful.

rem ==========================================
rem Build StringAnyDictionary
rem ==========================================

"%FBC%" -lib ^
    -i "%ROOT%Inc" ^
    -i "%ROOT%Utils\Dictionary\StringAnyDictionary" ^
    "%ROOT%Utils\Dictionary\StringAnyDictionary\StringAnyDictionary.bas" ^
    -x "%ROOT%Lib\libStringAnyDictionary.a"

if errorlevel 1 exit /b 1

copy /y "%ROOT%Utils\Dictionary\StringAnyDictionary\StringAnyDictionary.bi" "%ROOT%Inc\StringAnyDictionary.bi" >nul
if errorlevel 1 exit /b 1

echo StringAnyDictionary build successful.

rem ==========================================
rem Build StringStringDictionary
rem ==========================================

"%FBC%" -lib ^
    -i "%ROOT%Inc" ^
    -i "%ROOT%Utils\Dictionary\StringStringDictionary" ^
    "%ROOT%Utils\Dictionary\StringStringDictionary\StringStringDictionary.bas" ^
    -x "%ROOT%Lib\libStringStringDictionary.a"

if errorlevel 1 exit /b 1

copy /y "%ROOT%Utils\Dictionary\StringStringDictionary\StringStringDictionary.bi" "%ROOT%Inc\StringStringDictionary.bi" >nul
if errorlevel 1 exit /b 1

echo StringStringDictionary build successful.

rem ==========================================
rem Build BzData
rem ==========================================

"%FBC%" -lib ^
    -i "%ROOT%Inc" ^
    -i "%ROOT%Utils\BzData" ^
    "%ROOT%Utils\BzData\BzData.bas" ^
    "%ROOT%Utils\BzData\BzRecord.bas" ^
    "%ROOT%Utils\BzData\BzField.bas" ^
    -x "%ROOT%Lib\libBzData.a"

if errorlevel 1 exit /b 1

copy /y "%ROOT%Utils\BzData\BzData.bi" "%ROOT%Inc\BzData.bi" >nul
if errorlevel 1 exit /b 1

echo BzData build successful.

echo.
echo All libraries built successfully.
