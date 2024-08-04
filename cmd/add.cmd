@ECHO OFF
SET REPO=%1
SET FILEMASK=%2
IF [%FILEMASK%]==[] SET FILEMASK=*

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
git add -v "%FILEMASK%"
IF EXIST .gitmodules git submodule foreach "git add -v ""%FILEMASK%"""
cd..

GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.
ECHO Usage: add repo [filemask]
ECHO Example: add and-myapp *.java

:END
ECHO --- Finished "%REPO%" ---
