@ECHO OFF
SET REPO=%1
SET BDEL=0
SET LOCA=0

IF [%2]==[] GOTO NOMSG
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

SET ACTION=Creating
IF [%3]==[-d] SET ACTION=Deleting
IF [%4]==[-d] SET ACTION=Deleting

IF [%3]==[-d] SET BDEL=1
IF [%4]==[-d] SET BDEL=1
IF [%3]==[-l] SET LOCA=1
IF [%4]==[-l] SET LOCA=1
				  
cd %REPO%
ECHO %ACTION% local branch %2 in "%REPO%"...
IF [%BDEL%]==[1] GOTO DELETEBRANCH

ECHO Creating local branch %2 in "%REPO%"...
git checkout -b %2
IF [%LOCA%]==[1] GOTO LISTBRANCHES

ECHO Pushing "%REPO%" to origin...
git push origin %2
git branch --set-upstream-to=origin/%2

:LISTBRANCHES
ECHO List of branches for "%REPO%":
git branch --list
cd..
IF [%LOCA%]==[1] GOTO END
cd %REPO%
git branch --list --remotes
cd..
GOTO END

:DELETEBRANCH
ECHO Deleting local branch %2 in "%REPO%"...
git branch %3 %2
IF [%LOCA%]==[1] GOTO LISTBRANCHES
ECHO Pushing "%REPO%" to origin...
git branch %3 -r origin/%2
git push origin --delete %2
cd..
GOTO END

:NOMSG
ECHO Error: No branch name specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: branch repo branchname [-d] [-l]
ECHO -l to create/delete the branch only locally
ECHO -d will delete the branch (together with -l only local)
ECHO NOTE on submodules: This script does not modify submodules in any way!

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
