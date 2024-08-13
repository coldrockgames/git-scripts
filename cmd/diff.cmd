@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Launching tortoise diff window...
start tortoisegitproc /command:diff /path:./%REPO%
GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: diff repo [-prev]
ECHO This script will show you the tortoise diff view for the repo.

:END
