@ECHO OFF
SET REPO=%1
SET OLDBRANCH=%2
SET NEWBRANCH=%3

IF [%REPO%]==[] GOTO ERROR
IF [%OLDBRANCH%]==[] SET OLDBRANCH=main
IF [%NEWBRANCH%]==[] SET NEWBRANCH=%OLDBRANCH%

ECHO --- PURGE ALL HISTORY FROM %REPO% REPOSITORY
ECHO --------------------------------------------------------
ECHO ---                                                  ---
ECHO ---      DANGER! DANGER! AND EVEN MORE DANGER!       ---
ECHO ---                                                  ---
ECHO --------------------------------------------------------
ECHO ---
ECHO --- This is a not-reversable DESTRUCTIVE OPERATION
ECHO --- All history of the repository will be purged
ECHO --- local and remote on the server!
ECHO ---
ECHO --- Are you really... really... REALLY SURE?
ECHO --------------------------------------------------------
ECHO --- Do you really... really... REALLY know what'ya doin?
ECHO --------------------------------------------------------
SET /P CONT=Continue y/n?

IF [%CONT%]==[y] GOTO GO_AHEAD
GOTO FINISHLINE

:GO_AHEAD
cd %REPO%
git checkout --orphan latest_branch
git add -A
git commit -am "History purge. Repository reset."
git branch -D %OLDBRANCH%
git branch -m %NEWBRANCH%
git push -f origin %NEWBRANCH%
git gc --aggressive --prune=all
git push -u origin %NEWBRANCH%
cd..

:FINISHLINE
writein [g] --- Finished [y] "%REPO%" [g] ---
GOTO FINISHSILENT

:ERROR
ECHO . Error: No repository specified or repository "%REPO%" does not exist.
ECHO . Usage: purge-history repo [old_main] [new_main]
ECHO . 
ECHO . You can use this script also to rename your main branch in one go
ECHO . (but history will still be purged!)
ECHO . If you do not specify any branch names, "main" will be used as default
ECHO . for both, old and new.

:FINISHSILENT
