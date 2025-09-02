@ECHO OFF

SET REPO=%1
IF [%REPO%]==[] GOTO ERROR

IF [%PERSONALBRANCH%]==[] GOTO ERROR
IF [%DEVBRANCH%]==[] GOTO ERROR

ECHO Merging %REPO% from %DEVBRANCH% to %PERSONALBRANCH%...
CALL merge.cmd %REPO% %DEVBRANCH% %PERSONALBRANCH% -cp -2

CALL resolve.cmd %REPO%

GOTO END

:ERROR
ECHO Error: This prompt installation has no "dev" and no "personal" git branch configured!

:USAGE
ECHO Usage: merge2me repo

:END
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
