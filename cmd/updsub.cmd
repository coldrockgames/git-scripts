@ECHO OFF
SET REPO=%1
SET FILTER=

IF [%REPO%]==[] GOTO ERROR
IF [%REPO%]==[all] GOTO ALL
IF [%REPO%]==[and] GOTO AND
IF [%REPO%]==[gdx] GOTO GDX
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
IF EXIST .git GOTO SUBS

REM LOOP THROUGH ALL FOLDERS
ECHO Starting recursive submodule update of subfolders...
FOR /D %%G in ("*") DO CALL updsub.cmd %%~nxG %2
GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: updsub repo [branch]
ECHO If branch is specified only this branch will be pulled.
GOTO FINISHLINE

:SUBS
IF NOT EXIST .gitmodules GOTO END
ECHO Processing submodules in %REPO%...
git submodule foreach "git checkout master"
git submodule foreach "git fetch"
git submodule foreach "git merge"
cd..
CALL push.cmd %REPO% "submodule update"
GOTO FINISHLINE

:AND
ECHO --- RUNNING SUBMODULE-UPDATE ON ANDROID REPOS ---
SET FILTER=and-
GOTO ALL

:GDX
ECHO --- RUNNING SUBMODULE-UPDATE ON LIBGDX REPOS ---
SET FILTER=gdx-
GOTO ALL

:ALL
FOR /D %%G in ("%FILTER%*") DO CALL updsub.cmd %%~nxG
GOTO FINISHSILENT

:END
cd..

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
