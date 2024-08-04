@ECHO OFF

SET %ACCOUNT%=mike.barthold_3244154

SET OLDNAME=%1
SET NEWNAME=%2
IF [%OLDNAME%]==[] GOTO ERROR
IF [%NEWNAME%]==[] GOTO ERROR
IF NOT EXIST "%OLDNAME%" GOTO ERROR

ECHO --- RENAME GMS PROJECT %OLDNAME% TO %NEWNAME% ---
ECHO ---

SET /P CONT=Continue y/n?

IF [%CONT%]==[y] GOTO GO_AHEAD
GOTO FINISHLINE

:GO_AHEAD
CD "%OLDNAME%"
ren "%OLDNAME%.yyp" "%NEWNAME%.yyp"
ren "%OLDNAME%.resource_order" "%NEWNAME%.resource_order"
ECHO Renaming project file...
frep *.yy "%OLDNAME%" "%NEWNAME%" -r
CD ..
ECHO Renaming project folder...
REN "%OLDNAME%" "%NEWNAME%"
ECHO Renaming project layout...
REN "%APPDATA%\GameMakerStudio2\%ACCOUNT%\Layouts\%OLDNAME%\%OLDNAME%" "%APPDATA%\GameMakerStudio2\%ACCOUNT%\Layouts\%OLDNAME%\%NEWNAME%"
REN "%APPDATA%\GameMakerStudio2\%ACCOUNT%\Layouts\%OLDNAME%" "%APPDATA%\GameMakerStudio2\%ACCOUNT%\Layouts\%NEWNAME%"
GOTO FINISHLINE

:ERROR
ECHO Error: 2 arguments needed
ECHO Usage: gms-rename oldname newname
ECHO Script must be launched outside of the project folder that shall be renamed!
ECHO Example: If you want to rename C:\Dev\myproj, you must be in C:\Dev

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
