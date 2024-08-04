@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO --- %REPO% branches ---
git branch --list
git branch --list --remotes
IF EXIST .gitmodules git submodule foreach "git branch --list"
IF EXIST .gitmodules git submodule foreach "git branch --list --remotes"

ECHO --- %REPO% tags ---
git tag --list
git tag --list origin
IF EXIST .gitmodules git submodule foreach "git tag --list"
IF EXIST .gitmodules git submodule foreach "git tag --list origin"
cd..

GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: list repo

:END
IF [%REPO2%]==[] GOTO FINISHLINE
IF [%REPO%]==[%REPO2%] GOTO FINISHLINE
CALL list.cmd %REPO2%
GOTO FINISHSILENT

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
