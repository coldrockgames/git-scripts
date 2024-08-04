@ECHO OFF
SET REPO=%1
SET FILEMASK=%2
IF [%FILEMASK%]==[] SET FILEMASK=*.*

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
git checkout -- "%FILEMASK%"
git status -s -b
IF EXIST .gitmodules git submodule foreach "git checkout ""%FILEMASK%"""
IF EXIST .gitmodules git submodule foreach "git status -s -b"

cd..

GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: revert repo [filemask]
ECHO Example: revert and-myapp *.java

:END
ECHO --- Finished "%REPO%" ---
