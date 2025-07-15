@ECHO OFF
SET REPO=%1
SET TAG=%2
SET FORCE=%3

IF [%TAG%]==[] GOTO NOMSG
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Creating local tag "%REPO%/%TAG%"...
ECHO NOTE: Tags are NOT applied to sub modules!
git tag %FORCE% %TAG%
IF [%FORCE%]==[] GOTO PUSH
git push origin %FORCE% %TAG%
REM IF EXIST .gitmodules git submodule foreach "git tag %2 %3"

:PUSH
ECHO Pushing "%REPO%/%TAG%" to origin...
git push --tags
REM IF EXIST .gitmodules git submodule foreach "git push --tags"

ECHO List of tags for "%REPO%":
git tag --list
git tag --list origin
REM IF EXIST .gitmodules git submodule foreach "git tag --list"
REM IF EXIST .gitmodules git submodule foreach "git tag --list origin"

cd..

GOTO END

:NOMSG
ECHO Error: No tag name specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: tag repo tagname [-f]
ECHO Adding -f will force the tag to point to the current commit

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
