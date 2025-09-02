@ECHO OFF
SET REPO=%1

IF "%2"=="" GOTO NOMSG
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Switching "%REPO%" to %2...
git switch %2 %3
git branch
cd..
GOTO END

:NOMSG
ECHO Error: No branch name specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: switch repo branchname [-m]
ECHO -m will merge any local changes of your current branch into the new branch

:END
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
