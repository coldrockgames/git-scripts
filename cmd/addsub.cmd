@ECHO OFF
GOTO ENDBLOCKED
SET SERVER_URL=**USER**
SET REPO=%1
SET SUB=%2
SET FOLDER=%3

IF [%REPO%]==[] GOTO ERROR
IF [%SUB%]==[] GOTO ERROR
IF [%FOLDER%]==[] SET FOLDER=%SUB%

IF NOT EXIST %REPO% GOTO ERROR

ECHO Adding sub module %SUB% from **PROVIDER** to %REPO%...
cd %REPO%
git submodule add %4 %SERVER_URL%/%SUB%.git %FOLDER%
cd %FOLDER%
git switch **MAIN**
cd..
cd..

GOTO END

:ERROR
ECHO Error: No repository or submodule specified or repository "%REPO%" does not exist.
ECHO Usage: **SCRIPT** repo submodule [folder]
ECHO Example: **SCRIPT** gdx-escape gdx-platform-module platform

:END
writein [g] --- Finished [y] "%REPO%" [g] ---
GOTO ENDIMMIDIATE

:ENDBLOCKED
ECHO THIS SCRIPT MAY NOT RUN! Use the identity.cmd script to set up a clone identity!

:ENDIMMIDIATE
