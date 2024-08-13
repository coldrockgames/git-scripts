@ECHO OFF
SET REPO=%1

SET PR=
IF [%2]==[-prev] SET PR=/startrev:PREV

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Launching tortoise diff window...
start tortoisegitproc /command:diff /path:./%REPO% %PR%
GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: diff repo [-prev]
ECHO This script will show you the tortoise diff view for the repo,
ECHO which will compare your working space with the local repo. 
ECHO Use -prev argument to compare with previous committed version
ECHO (i.e. the version before the latest commit).

:END
