@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Remote branch stats for "%REPO%"
git remote --v
IF EXIST .gitmodules git submodule foreach "git remote show origin"

cd..

GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: origin repo

:END
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
