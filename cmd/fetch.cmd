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
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
