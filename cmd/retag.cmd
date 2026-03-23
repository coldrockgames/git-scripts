@ECHO OFF
SET REPO=%1
SET TAG=%2

IF [%TAG%]==[] GOTO NOMSG
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Moving existing tag "%REPO%/%TAG%" to the current commit...
REM Rufe tag.cmd auf und uebergebe automatisch das -f (Force) Flag
CALL tag.cmd %REPO% %TAG% -f

GOTO END

:NOMSG
ECHO Error: No tag name specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Move a tag to the current commit
ECHO Usage: retag repo tagname

:END
