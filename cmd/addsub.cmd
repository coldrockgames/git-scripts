@ECHO OFF
SET SERVER_URL=https://mike_barthold@bitbucket.org/mike_barthold
SET REPO=%1
SET SUB=%2
SET FOLDER=%3

IF [%REPO%]==[] GOTO ERROR
IF [%SUB%]==[] GOTO ERROR
IF [%FOLDER%]==[] SET FOLDER=%SUB%

IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
git submodule add %SERVER_URL%/%SUB%.git %3
cd %FOLDER%
git switch master
cd..
cd..

GOTO END

:ERROR
ECHO Error: No repository or submodule specified or repository "%REPO%" does not exist.
ECHO Usage: add repo submodule [folder]
ECHO Example: add gdx-escape gdx-platform-module platform

:END
ECHO --- Finished "%REPO%" ---
