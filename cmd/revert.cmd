@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
git reset --hard
git clean -f -d
git status -s -b
IF EXIST .gitmodules git submodule foreach "git reset --hard"
IF EXIST .gitmodules git submodule foreach "git clean -f -d"
IF EXIST .gitmodules git submodule foreach "git status -s -b"

cd..

GOTO END

:ERROR
writein [r] Error: No repository specified or repository [y] """%REPO%""" [r] does not exist.
writein [y] HARD RESETS THE REPOSITORY! NO UNDO!
writein [y] Usage: revert repo
writein [y] Example: revert and-myapp

:END
ECHO --- Finished "%REPO%" ---
