@ECHO OFF
SET REPO=%1
SET COMMAND=%2

IF [%COMMAND%]==[] GOTO NOCMD
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Launching tortoise %COMMAND% window...
start tortoisegitproc /command:%COMMAND% /path:./%REPO%
GOTO END

:NOCMD
ECHO This script shall not be run directly.
GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: diff repo [-prev]
ECHO This script will show you the tortoise diff view for the repo.

:END
