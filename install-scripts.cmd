@ECHO OFF
SET WI="%~dp0\tools\writein.exe"
%WI% [y] . [gr] 
%WI% [y] . [y] Welcome to the git-scripts installer!
%WI% [y] . [y] Copyright (c)2024-current coldrock.games
%WI% [y] . [gr] 
%WI% [y] . [gr] This will install a [y] shortcut [] on your desktop
%WI% [y] . [gr] pointing to your working folder and adding
%WI% [y] . [gr] the script location to the PATH variable
%WI% [y] . [gr] (temporarily, only in the created prompt script)
%WI% [y] . [gr] 
%WI% [y] . [gr] You can run this script as often as you like,
%WI% [y] . [gr] to create as many pre-configured prompts as you need,
%WI% [y] . [gr] if you have different working folders for different
%WI% [y] . [gr] git providers (like github and bitbucket)
%WI% [y] . [gr] 

:ENTER_SHORTCUT_NAME
SET /P SCNAME=Enter the name of the shortcut to create:
IF [%SCNAME%]==[] GOTO NOSHORTCUTNAME

:ENTER_WORKING_FOLDER
SET /P WKD=Clone destination folder (your dev-working-folder):
IF [%WKD%]==[] GOTO NOWORKINGFOLDER

SET GITMING=%ProgramFiles%\Git
IF EXIST "%GITMING%" GOTO CREATE_SHORTCUT

:ENTER_GIT_PATH
%WI% [r] .
%WI% [r] . git for windows installation not found
%WI% [r] .
SET /P GITMING=git-for-windows installation folder:
IF NOT EXIST %GITMING% GOTO NOGITFORWINDOWS

:CREATE_SHORTCUT
REM create-shortcut.exe --work-dir "C:\path\to\files" --arguments "--myarg=myval" "C:\path\to\files\file.ext" "C:\path\to\shortcuts\shortcut.lnk"
"%GITMING%\mingw64\bin\create-shortcut.exe" --work-dir "%WKD%" "%~dp0cmd\prompt.cmd" "%USERPROFILE%\Desktop\%SCNAME%.lnk"
GOTO STEP2

:NOSHORTCUTNAME
%WI% [r] . *ERROR* You must enter a valid name for the shortcut!
GOTO ENTER_SHORTCUT_NAME

:NOWORKINGFOLDER
%WI% [r] . *ERROR* You must enter a path where to clone your repos!
GOTO ENTER_WORKING_FOLDER

:NOGITFORWINDOWS
%WI% [r] . *ERROR* You must enter the path, where git-for-windows is installed!
GOTO ENTER_GIT_PATH

:STEP2
%WI% [g] .
%WI% [g] . git-scripts installation finished successfully!
%WI% [g] .

SET /P IDENTITY=Do you want to setup your git-identities now (y/n)?
IF [%IDENTITY%]==[y] GOTO IDENTITIES
%WI% [y] .
%WI% [y] . Identity setup skipped
%WI% [y] .
GOTO END

:IDENTITIES
CALL identity.cmd

:END
%WI% [y] . -- git-scripts installer finished --
PAUSE
