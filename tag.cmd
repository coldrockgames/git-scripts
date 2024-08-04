@ECHO OFF
SET REPO=%1

IF "%2"=="" GOTO NOMSG
IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Creating local tag "%REPO%/%2"...
ECHO NOTE: Tags are NOT applied to sub modules!
git tag %2 %3
REM IF EXIST .gitmodules git submodule foreach "git tag %2 %3"

ECHO Pushing "%REPO%/%2" to origin...
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
ECHO Usage: tag repo tagname [commitId]

:END
IF [%REPO2%]==[] GOTO FINISHLINE
IF [%REPO%]==[%REPO2%] GOTO FINISHLINE
CALL tag.cmd %REPO2% %2 %3
GOTO FINISHSILENT

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
