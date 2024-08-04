@ECHO OFF
SET REPO=%1
SET ROOT=%2

IF [%REPO%]==[] GOTO ALL
IF [%REPO%]==[all] GOTO ALL
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
IF [%ROOT%]==[root] GOTO CONTINUE_WITH_SUBS
IF NOT EXIST .git GOTO FINISH_NOT_A_REPO

:CONTINUE_WITH_SUBS
IF NOT EXIST .git GOTO SCANSUB
ECHO Status of "%REPO%":
git status -s -b
IF EXIST .gitmodules git submodule foreach "git status -s -b"
cd..

GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: status repo [root] or status all [root]
ECHO Status all will check the status of all repositories
ECHO Specify root as second parameter to scan subfolders even when they 
ECHO are not a repository.

:END
IF [%REPO2%]==[] GOTO FINISHLINE
IF [%REPO%]==[%REPO2%] GOTO FINISHLINE
REM The "root" as second parameter tells the script, it is no longer in root folder,
REM so SCANSUB may run
CALL status.cmd %REPO2% root
GOTO FINISHSILENT

:SCANSUB
ECHO --- Scanning sub folder %REPO% ---
FOR /D %%G in ("*") DO CALL status.cmd %%~nxG %ROOT%
cd..
GOTO FINISHSILENT

:ALL
FOR /D %%G in ("*") DO CALL status.cmd %%~nxG %ROOT%
GOTO FINISHSILENT

:FINISH_NOT_A_REPO
cd..
ECHO %REPO% is not a repository

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
