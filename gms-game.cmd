@ECHO OFF
ECHO Preparing gamemaker project (html and build script)...

SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%

ECHO Creating _assets_ folder
mkdir _assets_

ECHO Finding repository location
SET RUNIN=
IF EXIST C:\Work\Dev\git\%REPO% SET RUNIN=C:\Work\Dev\git\%REPO%
IF EXIST C:\Work\Dev\github\%REPO% SET RUNIN=C:\Work\Dev\github\%REPO%

IF [%RUNIN%]==[] GOTO ERROR

ECHO Copying coldrock project build file
COPY /Y C:\Work\dev\git\gms-global\libs\pre_project_step_coldrock.bat %RUNIN%\pre_project_step.bat

ECHO Running linqpad html-fix
lprun8 C:\Work\dev\git\mbar-global\LinqpadQueries\gms-index-html-fix.linq %RUNIN%
GOTO END

:ERROR
ECHO Error: No repository specified or "%REPO%" does not exist in C:\Work\Dev\git and C:\Work\Dev\github
ECHO Usage: gms-game repo
ECHO Will create the _assets_ folder and copy the pre_project_step script to the project.

:END
CD..
ECHO --- Finished "%REPO%" ---
