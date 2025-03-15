@ECHO OFF
CLS
ECHO ___________________________________________________
ECHO  _____/\\\\\\\\\\\\__/\\\\\\\\\\\__/\\\\\\\\\\\\\\\_        
ECHO   ___/\\\//////////__\/////\\\///__\///////\\\/////__       
ECHO    __/\\\_________________\/\\\___________\/\\\_______      
ECHO     _\/\\\____/\\\\\\\_____\/\\\___________\/\\\_______     
ECHO      _\/\\\___\/////\\\_____\/\\\___________\/\\\_______    
ECHO       _\/\\\_______\/\\\_____\/\\\___________\/\\\_______   
ECHO        _\/\\\_______\/\\\_____\/\\\___________\/\\\_______  
ECHO         _\//\\\\\\\\\\\\/___/\\\\\\\\\\\_______\/\\\_______ 
ECHO          __\////////////____\///////////________\///________
ECHO           ___________________________________________________
ECHO -
SET PATH=%PATH%;%LOCALAPPDATA%\coldrock.games.git-identities;%~dp0;%~dp0..\tools
SET PERSONALBRANCH=%1
SET DEVBRANCH=%2
SET SCRIPTHOME=%~dp0
SET DEVHOME=%cd%
SET IDHOME=%LOCALAPPDATA%\coldrock.games.git-identities

SET RETRY=0
:TRY_AGAIN
COPY /Y "%SCRIPTHOME%..\tools\gsupdatecheck.exe" "%IDHOME%\gsupdatecheck.exe" >NUL 2>&1

"%IDHOME%\gsupdatecheck.exe" 2>nul
IF [%ERRORLEVEL%]==[0] GOTO SUCCESS
SET /a RETRY+=1
IF [%RETRY%]==[3] GOTO FAIL
writeIn Checking for updates...
mwait 0.5 -s
GOTO TRY_AGAIN

:FAIL
writeIn [y] Can't check for script updates. Another script tab seems to be running the update check.

:SUCCESS
IF [%PERSONALBRANCH%]==[] GOTO OPEN_CMD
writeIn [gr] Your personal git branch name is set to [y] %PERSONALBRANCH%
IF [%DEVBRANCH%]==[] GOTO OPEN_CMD
writeIn [gr] Your git development branch name is set to [y] %DEVBRANCH%
ECHO -

:OPEN_CMD
SET PROMPT=$E[1;35m$P$G$E[1;37m
CMD /K
