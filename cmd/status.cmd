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
FOR /D %%G in (%WILDCARD%) DO CALL :STATUS_SHORT %%~nxG
GOTO FINISHSILENT

:STATUS_SHORT
SET SUBREPO=%1

CD %SUBREPO%
REM Count changes
SET COUNT=0
FOR /f %%A IN ('git status -s ^| find /c /v ""') DO SET COUNT=%%A
REM Get current branch
FOR /f "tokens=1,2 delims= " %%A IN ('git branch ^| findstr "^\*"') DO (
    SET "BRANCH=%%B"
)

REM Get Branch string length
SET STR=%BRANCH%
SET BRANCHLEN=0
:STRLEN
IF DEFINED STR (
    SET "STR=%STR:~1%"
    SET /A BRANCHLEN+=1
    GOTO STRLEN
)

REM pad-right the count to 4 digits
SET "COUNTPAD=   "
IF %COUNT% GTR 9 SET "COUNTPAD=  "
IF %COUNT% GTR 99 SET "COUNTPAD= "
IF %COUNT% GTR 999 SET "COUNTPAD="
IF %COUNT%==0 SET "COUNTPAD=    "

REM pad-left the branch to 8 digits
IF %BRANCHLEN% GTR 1 SET "BRANCHPAD=      "
IF %BRANCHLEN% GTR 2 SET "BRANCHPAD=     "
IF %BRANCHLEN% GTR 3 SET "BRANCHPAD=    "
IF %BRANCHLEN% GTR 4 SET "BRANCHPAD=   "
IF %BRANCHLEN% GTR 5 SET "BRANCHPAD=  "
IF %BRANCHLEN% GTR 6 SET "BRANCHPAD= "
IF %BRANCHLEN% GTR 7 SET "BRANCHPAD="

REM Remember current code page
FOR /f "tokens=2 delims=:" %%A IN ('chcp') DO SET OLDCP=%%A
SET OLDCP=%OLDCP: =%
SET OLDCP=%OLDCP:.=%

REM Switch to unicode
chcp 65001 >nul

SET BRANCHCOL=[c]
SET COUNTCOL=[g]
SET PRE=✔

IF [%BRANCH%]==[main] SET BRANCHCOL=[y]
IF [%BRANCH%]==[master] SET BRANCHCOL=[y]
IF [%BRANCH%]==[dev] SET BRANCHCOL=[gr]

IF %COUNT% GTR 0 (
	SET PRE=🔥
	SET COUNTCOL=[r]
	SET COUNTTEXT=%COUNT% changes!
)

SET REPOCOL=[gr]
IF %COUNTCOL%==[r] SET REPOCOL=[r]
SET PRE=%PRE% %COUNTPAD%%COUNT%
SET BR="%BRANCH% %BRANCHPAD%:"
writein %COUNTCOL% "%PRE%" %BRANCHCOL% %BR% %REPOCOL% %SUBREPO%

REM Switch back
chcp %OLDCP% >nul
CD..
GOTO :EOF

:END
CD..

:FINISH_NOT_A_REPO
cd..
ECHO %REPO% is not a repository

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
