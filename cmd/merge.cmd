@ECHO OFF
SET REPO=%1

IF [%2]==[] GOTO NOMSG
IF [%3]==[] GOTO NOMSG
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Pushing "%REPO%/%2"...
CALL pull.cmd %REPO%
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
git merge --no-edit %2
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
writein [r] Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
writein [gr] Usage: [y] merge repo from to [-c] or [-cp] [-2]
writein [y] -c [gr] will commit the merge locally directly if possible
writein [y] -cp [gr] will commit and push to the remote in one step if possible
writein [gr] By default, the script will switch to the first repo [y] (from)
writein [gr] after merging. Supply [y] -2 [gr] as last argument, to switch to the second afterwards.
writein [gr] NOTE on submodules: This script does not modify submodules in any way!

:END
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
