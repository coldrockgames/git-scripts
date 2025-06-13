@ECHO OFF
SET REPO=%1
SET ROOT=%2
SET WILDCARD=*

IF [%REPO%]==[] GOTO ALL
IF [%REPO%]==[all] GOTO ALL

ECHO %REPO% | findstr /C:"*" >nul
IF NOT ERRORLEVEL 1 (
	SET WILDCARD=%REPO%
	GOTO ALL
)

IF NOT EXIST %REPO% GOTO ERROR

CD %REPO%
IF [%ROOT%]==[root] GOTO CONTINUE_WITH_SUBS
IF NOT EXIST .git GOTO FINISH_NOT_A_REPO

:CONTINUE_WITH_SUBS
IF NOT EXIST .git GOTO SCANSUB
writein Status of [y] "%REPO%"
git status -s -b
IF EXIST .gitmodules git submodule foreach "git status -s -b"
CD..

GOTO END

:ERROR
writein [r] Error: No repository specified or repository "%REPO%" does not exist.
writein [y] Usage: 
writein [y] status [] repo [root]
writein [y] status all [] (or status without arguments) 
writein will check the status of all repositories
writein [y] status [] without arguments or with a wildcard ( [y] status gml* [] ) 
writein will create a formatted shortlist of all repositories 
writein matching the pattern and their state
writein Specify [y] root [] as second parameter to scan subfolders even when they 
writein are not a repository

:END
GOTO FINISHLINE

:SCANSUB
ECHO --- Scanning sub folder %REPO% ---
FOR /D %%G in (%WILDCARD%) DO CALL status-short.cmd %%~nxG %ROOT%
cd..
GOTO FINISHSILENT

:ALL
FOR /D %%G in (%WILDCARD%) DO CALL status-short.cmd %%~nxG
GOTO FINISHSILENT

:FINISH_NOT_A_REPO
cd..
ECHO %REPO% is not a repository

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
