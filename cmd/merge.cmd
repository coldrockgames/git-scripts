@ECHO OFF
SET REPO=%1

IF [%2]==[] GOTO NOMSG
IF [%3]==[] GOTO NOMSG
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Pushing "%REPO%/%2"...
CALL push.cmd %REPO% "Push before merge to %3"
cd %REPO%
ECHO Updating merge source "%REPO%/%2"
git switch %2
git fetch
git pull
git commit -a -m "Update merge source"
git push origin 
ECHO Updating merge target "%REPO%/%3"...
git switch %3
git fetch
git pull
git commit -a -m "Update merge source"

SET SWITCHBACK=%2
IF [%4]==[-2] SET SWITCHBACK=%3
IF [%5]==[-2] SET SWITCHBACK=%3

IF [%4]==[-c] GOTO MERGECOMMIT
IF [%4]==[-cp] GOTO MERGEPUSHCOMMIT
IF [%5]==[-c] GOTO MERGECOMMIT
IF [%5]==[-cp] GOTO MERGEPUSHCOMMIT

ECHO Merging "%REPO%/%2" into "%REPO%/%3"...
git merge   %2
cd..
GOTO END

:MERGECOMMIT
git merge --no-ff --commit -m "Merge %2 into %3" %2
cd..
GOTO END

:MERGEPUSHCOMMIT
git merge --no-ff --commit -m "Merge %2 into %3" %2
git push origin %3
git switch %SWITCHBACK%
cd..
CALL status.cmd %REPO%
GOTO END

:NOMSG
ECHO Error: No source and/or target branch specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: merge repo from to [-c or -cp] [-2]
ECHO -c will commit the merge locally directly if possible
ECHO -cp will commit and push to the remote in one step if possible
ECHO By default, the script will switch to the first repo (FROM)
ECHO after merging. Supply -2 as last argument, to switch to the second afterwards.
ECHO NOTE on submodules: This script does not modify submodules in any way!

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
