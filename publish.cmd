@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF [%2]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO --- www publish of %REPO% ---
CALL push.cmd %1 %2 -a
CALL merge.cmd %1 dev master -cp
CALL switch.cmd %1 dev

GOTO END

:NOMSG
ECHO Error: No commit message specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: publish repo "message"

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
