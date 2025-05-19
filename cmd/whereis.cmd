@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Current branch of "%1":
git branch
IF EXIST .gitmodules git submodule foreach "git branch"

cd..
GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: whereis repo

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
