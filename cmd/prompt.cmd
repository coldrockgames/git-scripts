@ECHO OFF
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
ECHO _
SET PATH=%PATH%;%LOCALAPPDATA%\coldrock.games.git-identities;%~dp0;%~dp0..\tools
SET SCRIPTHOME=%~dp0
SET DEVHOME=%cd%
SET IDHOME=%LOCALAPPDATA%\coldrock.games.git-identities
COPY /Y "%SCRIPTHOME%..\tools\gsupdatecheck.exe" "%IDHOME%\gsupdatecheck.exe" >NUL 2>&1
REM CMD /K "%IDHOME%\gsupdatecheck.exe" 2>nul
"%IDHOME%\gsupdatecheck.exe" 2>nul
IF %ERRORLEVEL% NEQ 0 (
	writeIn [r] Can't check for script updates. Another script tab seems to be running the update check.
)
CMD /K

REM CMD /K "%~dp0..\tools\gsupdatecheck.exe"
