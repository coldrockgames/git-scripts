@ECHO OFF
SET REPO=%1
SET FILTER=

IF [%REPO%]==[] GOTO ERROR
IF [%REPO%]==[all] GOTO ALL
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
IF EXIST .git GOTO SUBS

REM LOOP THROUGH ALL FOLDERS
ECHO Starting recursive submodule update of subfolders...
FOR /D %%G in ("*") DO CALL updsub.cmd %%~nxG %2
GOTO FINISHSILENT

:ERROR
writein [r] Error: No repository specified or repository "%REPO%" does not exist.
writein [gr] Usage: [y] updsub repo [submodule-branch=main]
writein [gr] If repo is [y] all [gr] , all subs of [y] all local repositories [gr] will be updated!
writein [gr] Specify a [y] submodule-branch [gr] only, if you want to checkout
writein [gr] a different branch than [y] main [gr] of the submodules.
GOTO FINISHLINE

:SUBS
IF NOT EXIST .gitmodules GOTO END
ECHO Processing submodules in %REPO%...
SET SUBBRANCH=%2
IF [%SUBBRANCH%]==[] SET SUBBRANCH=main
ECHO Processing submodules in %REPO% (checkout-branch: %SUBBRANCH%)...
git submodule foreach "git checkout %SUBBRANCH%"
git submodule foreach "git fetch"
git submodule foreach "git merge"
cd..
CALL push.cmd %REPO% "submodule update"
GOTO FINISHLINE

:ALL
FOR /D %%G in ("%FILTER%*") DO CALL updsub.cmd %%~nxG
GOTO FINISHSILENT

:END
cd..

:FINISHLINE
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
