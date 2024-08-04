@ECHO OFF
SET ORIGIN=C:\Work\Dev\Git\mbar-global\java\gdx-new-game
SET CLASSES=%ORIGIN%-classes

SET REPO=%1
SET ROOTNS=%2
SET GAMENAME=%3
SET GAMECLASS=%4

IF [%REPO%]==[] GOTO ERROR
IF [%ROOTNS%]==[] GOTO ERROR
IF [%GAMENAME%]==[] GOTO ERROR
IF [%GAMECLASS%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Creating standard files for "%GAMENAME%"
PREP %ORIGIN% . /NOLOG /NODEL

ECHO Patching command scripts, build files and config files...
FREP backupAssets.cmd "$REPO" "%REPO%"
REM - Dropbox age is over
REM FREP upload-dropbox.cmd "$REPO" "%REPO%"
REM FREP upload-dropbox.cmd "$GAMENAME" "%GAMENAME%"
REM FREP uploadVersionFile.ftp "$REPO" "%REPO%"
REM FREP uploadVersionFile.ftp "$GAMENAME" "%GAMENAME%"
FREP packDesktopExe.cmd "$REPO" "%REPO%"
FREP packDesktopExe.cmd "$ROOTNS" "%ROOTNS%"
FREP packDesktopExe.cmd "$GAMENAME" "%GAMENAME%"

FREP .\.idea\runConfigurations\android.xml "$REPO" "%REPO%"
FREP .\.idea\runConfigurations\Desktop.xml "$REPO" "%REPO%"
FREP .\.idea\runConfigurations\Desktop.xml "$ROOTNS" "%ROOTNS%"
FREP .\.idea\runConfigurations\Desktop___prod.xml "$REPO" "%REPO%"
FREP .\.idea\runConfigurations\Desktop___prod.xml "$ROOTNS" "%ROOTNS%"

FREP .\gradle\wrapper\gradle-wrapper.properties "-bin.zip" "-all.zip"

FREP build.gradle "$GAMENAME" "%GAMENAME%"
FREP build.gradle "$ROOTNS" "%ROOTNS%"
FREP .\android\build.gradle "$ROOTNS" "%ROOTNS%"
FREP .\desktop\build.gradle "$ROOTNS" "%ROOTNS%"

FREP .\android\assets\app-info\product.properties "$GAMENAME" "%GAMENAME%"

ECHO Preparing game classes and standard screens...
MKDIR .\core\src\main\java\mbar\games\%ROOTNS%\model
MKDIR .\core\src\dev\java\mbar\games\%ROOTNS%
MKDIR .\core\src\dev\java\mbar\games\%ROOTNS%\designers
MKDIR .\core\src\prod\java\mbar\games\%ROOTNS%
MKDIR .\core\src\test\java\mbar\games\%ROOTNS%

MKDIR .\android\assets\audio\effects
MKDIR .\android\assets\audio\music
MKDIR .\android\assets\audio\ambience
MKDIR .\android\assets\effects
MKDIR .\android\assets\images
MKDIR .\android\assets\meta
MKDIR .\android\assets\shaders
MKDIR .\android\assets\textures

MKDIR .\localStorage
MKDIR .\localStorage\assets
MKDIR .\localStorage\tools

COPY /Y %CLASSES%\$GAMECLASS.java .\core\src\main\java\mbar\games\%ROOTNS%\%GAMECLASS%.java
COPY /Y %CLASSES%\DesignerEntryPoint.java .\core\src\dev\java\mbar\games\%ROOTNS%\designers\DesignerEntryPoint.java
COPY /Y %CLASSES%\$GAMECLASSSettings.java .\core\src\main\java\mbar\games\%ROOTNS%\%GAMECLASS%Settings.java
COPY /Y %CLASSES%\G.java .\core\src\main\java\mbar\games\%ROOTNS%\G.java
COPY /Y %CLASSES%\GameTriggers.java .\core\src\main\java\mbar\games\%ROOTNS%\GameTriggers.java

COPY /Y %CLASSES%\AndroidLauncher.java .\android\src\mbar\games\%ROOTNS%\AndroidLauncher.java
COPY /Y %CLASSES%\DesktopLauncher.java .\desktop\src\mbar\games\%ROOTNS%\desktop\DesktopLauncher.java

FREP .\core\src\main\java\mbar\games\%ROOTNS%\%GAMECLASS%.java "$ROOTNS" "%ROOTNS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\%GAMECLASS%.java "$GAMECLASS" "%GAMECLASS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\%GAMECLASS%Settings.java "$ROOTNS" "%ROOTNS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\%GAMECLASS%Settings.java "$GAMECLASS" "%GAMECLASS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\G.java "$ROOTNS" "%ROOTNS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\GameTriggers.java "$ROOTNS" "%ROOTNS%"

FREP .\core\src\dev\java\mbar\games\%ROOTNS%\designers\DesignerEntryPoint.java "$ROOTNS" "%ROOTNS%"

FREP .\android\src\mbar\games\%ROOTNS%\AndroidLauncher.java "$ROOTNS" "%ROOTNS%"
FREP .\android\src\mbar\games\%ROOTNS%\AndroidLauncher.java "$GAMECLASS" "%GAMECLASS%"
FREP .\android\src\mbar\games\%ROOTNS%\AndroidLauncher.java "$GAMENAME" "%GAMENAME%"

FREP .\desktop\src\mbar\games\%ROOTNS%\desktop\DesktopLauncher.java "$ROOTNS" "%ROOTNS%"
FREP .\desktop\src\mbar\games\%ROOTNS%\desktop\DesktopLauncher.java "$GAMECLASS" "%GAMECLASS%"
FREP .\desktop\src\mbar\games\%ROOTNS%\desktop\DesktopLauncher.java "$GAMENAME" "%GAMENAME%"

PREP %CLASSES%\screens .\core\src\main\java\mbar\games\%ROOTNS%\screens /NOLOG /NODEL

FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\intro\IntroScreen.java "$ROOTNS" "%ROOTNS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\intro\IntroScreen.java "$GAMECLASS" "%GAMECLASS%"
	 
FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\intro\IntroActionStage.java "$ROOTNS" "%ROOTNS%"
	 
FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\menu\MenuScreen.java "$ROOTNS" "%ROOTNS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\menu\MenuScreen.java "$GAMECLASS" "%GAMECLASS%"
	 
FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\menu\MenuActionStage.java "$ROOTNS" "%ROOTNS%"
	 
FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\menu\MenuUiStage.java "$ROOTNS" "%ROOTNS%"
FREP .\core\src\main\java\mbar\games\%ROOTNS%\screens\menu\MenuUiStage.java "$GAMECLASS" "%GAMECLASS%"

DEL .\android\assets\badlogic.jpg
RD /S /Q .\core\src\mbar

IF EXIST .git GOTO ADDTOGIT
ECHO Creating .git repository
git init

:ADDTOGIT
cd..

ECHO Adding files to source control...
CALL add.cmd %REPO%

ECHO Adding platform submodule...
CALL addsub.cmd %REPO% gdx-platform-module platform

ECHO Performing initial compile to see if all is good
cd %REPO%
call gradlew desktop:clean createDebugVersion --rerun-tasks
cd..
CALL add.cmd %REPO%

GOTO END

:ERROR
ECHO Error: No repository/game name specified or repository "%REPO%" does not exist.
ECHO Usage: newgame repo rootnamespace gameName gameClassName
ECHO Example: newgame gdx-escape escapethedungeon escape-the-dungeon EscapeGame
ECHO NOTE: You may not use any strings with blanks! No escaping of parameters allowed!

:END

:FINISHLINE
ECHO --- Finished "%REPO%" ---
