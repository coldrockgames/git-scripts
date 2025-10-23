@ECHO OFF

SET REPO=%1
IF [%REPO%]==[] GOTO ERROR

IF [%PERSONALBRANCH%]==[] GOTO ERROR
IF [%DEVBRANCH%]==[] GOTO ERROR

ECHO Merging %REPO% from %DEVBRANCH% to %PERSONALBRANCH%...
CALL merge.cmd %REPO% %DEVBRANCH% %PERSONALBRANCH%

CALL resolve.cmd %REPO%

SET PUSH=
SET /P PUSH=All conflicts resolved? Push and Continue y/n?
IF [%PUSH%]==[n] GOTO ABORTED

CALL push.cmd %REPO% "merge2me done"
CALL switch.cmd %REPO% %PERSONALBRANCH%
GOTO END

:ERROR
ECHO Error: This prompt installation has no "dev" and no "personal" git branch configured!

:USAGE
ECHO Usage: merge2me repo

:END
writein [g] --- Finished [y] "%REPO%" [g] ---
GOTO FINISHSILENT

:ABORTED
writein [r] Operation aborted.

:FINISHSILENT
