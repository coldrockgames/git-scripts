@ECHO OFF
SET REPO=%1

IF [%REPO%]==[*] GOTO ALL
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
IF [%2]==[] GOTO PULLALL

ECHO Pulling "%REPO%/%2"...
git pull -v --no-rebase --no-edit "origin" %2
GOTO SUBS

:PULLALL
ECHO Pulling "%REPO%" (full)...
git pull -v --no-rebase --no-edit --all
GOTO SUBS

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: pull repo [branch]
ECHO If branch is specified only this branch will be pulled.
GOTO FINISHLINE

:SUBS
IF NOT EXIST .gitmodules GOTO END
ECHO Processing submodules in %REPO%...
git submodule foreach "git checkout master"
git submodule foreach "git fetch"
git submodule foreach "git merge"
cd..
CALL push.cmd %REPO% "submodule update"
GOTO END_NO_STEP_OUT

:END
cd..

:END_NO_STEP_OUT
GOTO FINISHLINE

:ALL
FOR /D %%G in ("*") DO CALL pull.cmd %%~nxG %2
GOTO FINISHSILENT

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
