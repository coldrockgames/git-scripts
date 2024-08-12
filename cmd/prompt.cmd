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
SET PATH=%PATH%;%~dp0;%~dp0..\tools;%LOCALAPPDATA%\coldrock.games.git-identities
SET SCRIPTHOME=%~dp0
SET DEVHOME=%cd%
SET IDHOME=%LOCALAPPDATA%\coldrock.games.git-identities
REM COPY /Y "%SCRIPTHOME%..\tools\gsupdatecheck.exe" "%IDHOME%\gsupdatecheck.exe" >NUL 2>NUL
REM "%IDHOME%\gsupdatecheck.exe"

REM CMD /K "%IDHOME%\gsupdatecheck.exe"
CMD /K "%~dp0..\tools\gsupdatecheck.exe"
