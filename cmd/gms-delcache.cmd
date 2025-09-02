@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR

ECHO Deleting GameMaker cache for %REPO%...

SET "SUBSTR=%REPO:~0,10%"
SET "CAC=%APPDATA%\GameMakerStudio2\Cache\GMS2CACHE"
SET "IDE=%APPDATA%\GameMakerStudio2\Cache\GMS2IDE"

for /f %%i in ('dir /a:d /b "%CAC%\%SUBSTR%*"') do rd /s /q %CAC%\%%i
for /f %%i in ('dir /a:d /b "%IDE%\%SUBSTR%*"') do rd /s /q %IDE%\%%i

ECHO Cache deleted.
GOTO END

:ERROR
ECHO Error: No project name specified
ECHO Usage: gms-delcache project_name
ECHO Will delete the gms-cache in your appdata folder (gms + ide cache)

:END
writein [g] --- Finished [y] "%REPO%" [g] ---
