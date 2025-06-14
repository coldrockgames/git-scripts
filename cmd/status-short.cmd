@echo off

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

SET BRANCHCOL=[gr]
SET COUNTCOL=[g]
SET PRE=✔

IF [%BRANCH%]==[main] SET BRANCHCOL=[y]
IF [%BRANCH%]==[master] SET BRANCHCOL=[y]
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

:END
CD..

