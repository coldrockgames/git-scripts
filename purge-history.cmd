@ECHO OFF
SET REPO=%1
SET BRANCH=%2

IF [%REPO%]==[] GOTO ERROR
IF [%BRANCH%]==[] SET BRANCH=master

ECHO --- PURGE ALL HISTORY FROM %REPO% REPOSITORY
ECHO --------------------------------------------------------
ECHO ---
ECHO --- DANGER! DANGER! AND EVEN MORE DANGER!
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
git branch -D %BRANCH%
git branch -m %BRANCH%
git push -f origin %BRANCH%
git gc --aggressive --prune=all
git push -u origin %BRANCH%
cd..

:FINISHLINE
ECHO --- Finished "%REPO%" ---
GOTO FINISHSILENT

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: purge-history repo [alternative_master_branch_name]

ECHO If the master branch is named "master" on the server, you do not need
ECHO to specify the alternative name.
ECHO On some sites, "master" is named "main" these days. If your remote
ECHO uses "main" as the master-branch-name, you should supply "main" as second
ECHO argument to this script.

:FINISHSILENT
