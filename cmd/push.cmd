@ECHO OFF
SET REPO=%1
SET PULL_FIRST=
SET ADD_FIRST=a

IF [%REPO%]==[*] GOTO ALL
IF [%REPO%]==[] GOTO ERROR
IF [%2]==[] GOTO ERROR
IF [%3]==[-a] SET ADD_FIRST=
IF [%4]==[-a] SET ADD_FIRST=
IF [%3]==[-p] SET PULL_FIRST=p
IF [%4]==[-p] SET PULL_FIRST=p

IF [%3]==[-ap] SET ADD_FIRST=
IF [%3]==[-ap] SET PULL_FIRST=p
IF [%3]==[-pa] SET ADD_FIRST=
IF [%3]==[-pa] SET PULL_FIRST=p

IF NOT EXIST %REPO% GOTO ERROR
IF [%PULL_FIRST%]==[p] GOTO PULL_FIRST
IF [%ADD_FIRST%]==[a] GOTO ADD_FIRST
GOTO BEGIN

:PULL_FIRST
ECHO Performing pull-first operation...
CALL pull.cmd %REPO%
IF [%ADD_FIRST%]==[a] GOTO ADD_FIRST
GOTO BEGIN

:ADD_FIRST
ECHO Performing add-first operation...
CALL add.cmd %REPO%

:BEGIN
cd %REPO%
ECHO Looking for submodules in "%REPO%"...
IF EXIST .gitmodules git submodule foreach "git commit -a -m ""%2"""
IF EXIST .gitmodules git submodule foreach "git push origin"

ECHO Pushing "%REPO%" to origin...
git commit -a -m %2
git push origin 
cd..

GOTO END

:NOMSG
ECHO Error: No commit message specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: push repo "message" [-p] [-a] [-pa] [-ap]
ECHO BY DEFAULT, an ADD operation will be performed before pushing!
ECHO -a parameter will AVOID to run the add script before pushing.
ECHO -p parameter will cause to run the pull script before pushing.
ECHO -a and -p can also be specified as a single -ap or -pa parameter.

:END
GOTO FINISHLINE

:ALL
FOR /D %%G in ("*") DO CALL push.cmd %%~nxG %2 %3 %4
GOTO FINISHSILENT

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
