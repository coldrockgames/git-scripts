@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
REM git count-objects -vH |find "count:" & git count-objects -vH |find "size:"
REM IF EXIST .gitmodules git submodule foreach "git count-objects -vH"
mfsize .git 

cd..

GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: sizeof repo

:END
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
