# FreeBasicDev

A FreeBASIC development workspace containing reusable libraries and utilities.

## Contents

- `Utils/BzList`: linked list implementation.
- `Utils/Dictionary`: string-keyed dictionaries for strings and pointers.
- `Utils/BzData`: data, record, and field utilities.
- `Utils/XecronixStr`: string utilities.
- `Inc`: shared include files, refreshed by the build script.
- `Lib`: generated static libraries (excluded from Git).
- `Projects` and `ThirdParty`: workspace folders reserved for projects and dependencies.

Git does not track empty folders, so some workspace folders appear only after
building or adding files.

## Build on Windows

Install FreeBASIC and make sure `fbc` is available on `PATH`. From a Command Prompt
in the repository root, run:

```bat
build.bat
```

The script builds BzList, StringAnyDictionary, StringStringDictionary, and BzData,
places their static libraries in `Lib`, and copies their include files to `Inc`.
XecronixStr is not included in this build script.

The utility folders also contain example `main.bas` programs and `.tiko` project
files. Compiled executables, static libraries, object files, and `.tiko` build
caches are excluded from version control.
