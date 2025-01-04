@ECHO OFF

SET REPO=%1
IF [%REPO%]==[] GOTO ERROR

IF [%PERSONALBRANCH%]==[] GOTO ERROR
IF [%DEVBRANCH%]==[] GOTO ERROR

ECHO Merging %REPO% from %PERSONALBRANCH% to %DEVBRANCH%...
CALL merge %REPO% %PERSONALBRANCH% %DEVBRANCH% -cp

SET /P RESOLVE=Need to resolve (y/n)?
IF %RESOLVE%==[y] CALL resolve.cmd %REPO%

GOTO END

:ERROR
ECHO Error: This prompt installation has no "dev" and no "personal" git branch configured!

:USAGE
ECHO Usage: merge2me repo

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
