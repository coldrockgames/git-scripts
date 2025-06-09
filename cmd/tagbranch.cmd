@ECHO OFF
SET REPO=%1
SET BRANCH=%2
SET TAG=%3
SET BRANCH_AFTER=%4

IF [%REPO%]==[] GOTO ERROR
IF [%BRANCH%]==[] GOTO ERROR
IF [%TAG%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

ECHO Creating local tag "%REPO%/%TAG%" in branch %BRANCH%...
ECHO Push before switch
CALL push.cmd %REPO% "Push before tag %TAG%"
CALL switch.cmd %REPO% %BRANCH%
CALL tag.cmd %REPO% %TAG%

IF [%BRANCH_AFTER%]==[] GOTO SKIP_AFTER
CALL switch.cmd %REPO% %BRANCH_AFTER%

:SKIP_AFTER
CALL list.cmd %REPO%
GOTO END

:ERROR
ECHO Parameter error.
ECHO Usage: tagbranch repo branch tag [branch-after]
ECHO Example: tagbranch gml-raptor main 2506.1 [dev]

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
