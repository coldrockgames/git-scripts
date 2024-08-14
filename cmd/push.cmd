@ECHO OFF
SET REPO=%1
SET PULL_FIRST=
SET ADD_FIRST=a

IF [%REPO%]==[*] GOTO ALL
IF [%REPO%]==[] GOTO ERROR
IF [%2]==[] GOTO ERROR
IF [%3]==[-a] SET ADD_FIRST=
IF [%4]==[-a] SET ADD_FIRST=
IF [%3]==[-p] SET PULL_FIRST=p
IF [%4]==[-p] SET PULL_FIRST=p

IF [%3]==[-ap] SET ADD_FIRST=
IF [%3]==[-ap] SET PULL_FIRST=p
IF [%3]==[-pa] SET ADD_FIRST=
IF [%3]==[-pa] SET PULL_FIRST=p

IF NOT EXIST %REPO% GOTO ERROR
IF [%PULL_FIRST%]==[p] GOTO PULL_FIRST
IF [%ADD_FIRST%]==[a] GOTO ADD_FIRST
GOTO BEGIN

:PULL_FIRST
ECHO Performing pull-first operation...
CALL pull.cmd %REPO%
IF [%ADD_FIRST%]==[a] GOTO ADD_FIRST
GOTO BEGIN

:ADD_FIRST
ECHO Performing add-first operation...
CALL add.cmd %REPO%

:BEGIN
cd %REPO%
ECHO Looking for submodules in "%REPO%"...
IF EXIST .gitmodules git submodule foreach "git commit -a -m ""%2"""
IF EXIST .gitmodules git submodule foreach "git push origin"

IF [%REPO%]==[gms-global] GOTO COPY_SETTINGS
GOTO DO_PUSH_NOW

:COPY_SETTINGS
ECHO Copying GameMaker Settings...
COPY /Y %APPDATA%\GameMakerStudio2\mike.barthold_3244154\* C:\Work\dev\git\gms-global\gamemaker_settings\%COMPUTERNAME%\appdata_roaming
COPY /Y %ProgramData%\GameMakerStudio2\User\*.* C:\Work\dev\git\gms-global\gamemaker_settings\%COMPUTERNAME%\programdata\User
COPY /Y %ProgramData%\GameMakerStudio2\language_settings.json C:\Work\dev\git\gms-global\gamemaker_settings\%COMPUTERNAME%\programdata\language_settings.json
cd..
CALL add.cmd %REPO%
cd %REPO%

:DO_PUSH_NOW
ECHO Pushing "%REPO%" to origin...
git commit -a -m %2
git push origin 
cd..

GOTO END

:NOMSG
ECHO Error: No commit message specified
IF [%REPO%]==[] GOTO ERROR
GOTO USAGE

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: push repo "message" [-p] [-a] [-pa] [-ap]
ECHO BY DEFAULT, an ADD operation will be performed before pushing!
ECHO -a parameter will AVOID to run the add script before pushing.
ECHO -p parameter will cause to run the pull script before pushing.
ECHO -a and -p can also be specified as a single -ap or -pa parameter.

:END
GOTO FINISHLINE

:ALL
FOR /D %%G in ("*") DO CALL push.cmd %%~nxG %2 %3 %4
GOTO FINISHSILENT

:FINISHLINE
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
