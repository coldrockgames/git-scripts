@ECHO OFF
GOTO ENDBLOCKED
SET SERVER_URL=**USER**
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF EXIST %REPO% GOTO ERROR

ECHO Cloning %REPO% from **PROVIDER**...
git clone -v --recurse-submodules %SERVER_URL%/%REPO%.git %REPO%

IF EXIST "%REPO%\.gitmodules" GOTO CHECKSUBS
GOTO CHECKIGNORE

:CHECKSUBS
ECHO Switching submodules to **MAIN** branch
cd %REPO%
git submodule foreach "git switch **MAIN**"
cd..

:CHECKIGNORE
IF EXIST "%REPO%\.gitignore" GOTO CHECKBRANCH
IF NOT EXIST "%SCRIPTHOME%..\.gitignore" GOTO WARN
ECHO Copying ignore file...
copy "%SCRIPTHOME%..\*.gitignore" "%REPO%"
copy "%SCRIPTHOME%..\*.gitattributes" "%REPO%"
GOTO ADDNOW

:WARN
ECHO Warning: %SCRIPTHOME%..\.gitignore not found. The clone will have no .gitignore and .gitattributes settings!
GOTO CHECKBRANCH

:ADDNOW
cd %REPO%
git add -v *.gitignore
git add -v *.gitattributes
cd..
CALL push.cmd %REPO% "Initial commit with added .gitignore and .gitattributes files"

:CHECKBRANCH
IF [%2]==[-b] GOTO BRANCH
GOTO ENDSILENT

:BRANCH
ECHO Creating dev branch
CALL branch.cmd %REPO% dev
CALL switch.cmd %REPO% dev
GOTO ENDSILENT

:ERROR
ECHO Error: No repository specified or directory "%REPO%" already exists.
ECHO Usage: **SCRIPT** repo [-b]
ECHO -b will create a dev branch local and on the remote. USE WITH CARE and only if that branch does not already exist!

:END
ECHO --- Finished "%REPO%" ---

:ENDSILENT
REM try to silently switch to the dev branch if it exists
CALL switch.cmd %REPO% dev >nul 2>&1
CALL status.cmd %REPO%
GOTO ENDIMMEDIATE

:ENDBLOCKED
ECHO THIS SCRIPT MAY NOT RUN! Use the identity.cmd script to set up a clone identity!

:ENDIMMEDIATE

