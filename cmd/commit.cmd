@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF [%2]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Performing local commit in "%REPO%"...
git commit -a -m %2
IF EXIST .gitmodules git submodule foreach "git commit -a -m changes_from_project_%REPO%"

cd..

GOTO END

:NOMSG
ECHO Error: No commit message specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: commit repo "message"

:END
IF [%REPO2%]==[] GOTO FINISHLINE
IF [%REPO%]==[%REPO2%] GOTO FINISHLINE
CALL commit.cmd %REPO2% %2
GOTO FINISHSILENT

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
