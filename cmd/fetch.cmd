@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO --- Fetching %REPO% ---
git fetch
cd..

GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: fetch repo

:END
IF [%REPO2%]==[] GOTO FINISHLINE
IF [%REPO%]==[%REPO2%] GOTO FINISHLINE
CALL list.cmd %REPO2%
GOTO FINISHSILENT

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
