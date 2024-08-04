@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Launching tortoise conflict resolve window...
start tortoisegitproc /command:resolve /path:./%REPO%
GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: resolve repo
ECHO This script will show you the tortoise conflict resolution window 
ECHO without the need to open a windows explorer.

:END
