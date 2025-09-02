@ECHO OFF
SET WI="%~dp0..\tools\writein.exe"

SET IDHOME=%LOCALAPPDATA%\coldrock.games.git-identities
IF NOT EXIST "%IDHOME%" MKDIR "%IDHOME%"

SET FREP="%~dp0..\tools\frep.exe"
SET ANOTHERID=y

:START_IDENTITY
IF [%ANOTHERID%]==[y] GOTO MAKE_IDENTITY
GOTO END

:MAKE_IDENTITY
%WI% [y] . [gr]
%WI% [y] . [y] Creating new git clone identity
%WI% [y] . [gr] You will be asked for a [y] shortname [] of the identity.
%WI% [y] . [gr] This will be the suffix of the clone script name.
%WI% [y] . [y] Example: [] You enter [y] gh [] as shortname, your script will be named [y] clonegh [].
%WI% [y] . [gr]

:ENTER_SHORTNAME
SET /P SHORTNAME=Enter the shortname for the identity:
IF [%SHORTNAME%]==[] GOTO SHORTNAME_ERROR

:ENTER_PROVIDER
SET /P IDTYPE=Enter 1 for github, 2 for bitbucket or 3 for gitlab:
IF [%IDTYPE%]==[1] GOTO MAIN_BRANCH_NAME
IF [%IDTYPE%]==[2] GOTO MAIN_BRANCH_NAME
IF [%IDTYPE%]==[3] GOTO MAIN_BRANCH_NAME
GOTO PROVIDER_ERROR

:MAIN_BRANCH_NAME
SET /P MAINBRANCH=Enter the main branch name of this provider (i.e. "main" or "master"):
IF [%MAINBRANCH%]==[] GOTO MAIN_BRANCH_ERROR
IF [%IDTYPE%]==[1] GOTO MAKE_GITHUB
IF [%IDTYPE%]==[2] GOTO MAKE_BITBUCKET
IF [%IDTYPE%]==[3] GOTO MAKE_GITLAB
GOTO END

:MAKE_GITHUB
:ENTER_GHUSER
SET GPROV=github
SET /P GHUSER=Enter your github user name or organization:
IF [%GHUSER%]==[] GOTO GHUSER_ERROR
SET DESTCMD="%IDHOME%\clone%SHORTNAME%.cmd"
COPY /Y "%~dp0\clone.cmd" %DESTCMD%
SET DESTSUB="%IDHOME%\addsub%SHORTNAME%.cmd"
COPY /Y "%~dp0\addsub.cmd" %DESTSUB%
%FREP% %DESTCMD% "**USER**" "SET SERVER_URL=https://github.com/%GHUSER%" -l
%FREP% %DESTCMD% "**PROVIDER**" "ECHO Cloning %%REPO%% from github/%GHUSER%..." -l
%FREP% %DESTSUB% "**USER**" "SET SERVER_URL=https://github.com/%GHUSER%" -l
%FREP% %DESTSUB% "**PROVIDER**" "ECHO Adding sub module %%SUB%% from github/%GHUSER% to %%REPO%%..." -l
GOTO COMMON_REPLACE

:MAKE_BITBUCKET
:ENTER_BBUSER
SET GPROV=bitbucket
SET /P BBUSER=Enter your bitbucket user name:
IF [%BBUSER%]==[] GOTO BBUSER_ERROR
:ENTER_BBWORKSPACE
SET /P BBWSP=Enter your bitbucket workspace name:
IF [%BBWSP%]==[] GOTO BBWSP_ERROR
SET DESTCMD="%IDHOME%\clone%SHORTNAME%.cmd"
COPY /Y "%~dp0\clone.cmd" %DESTCMD%
SET DESTSUB="%IDHOME%\addsub%SHORTNAME%.cmd"
COPY /Y "%~dp0\addsub.cmd" %DESTSUB%
%FREP% %DESTCMD% "**USER**" "SET SERVER_URL=https://%BBUSER%@bitbucket.org/%BBWSP%" -l
%FREP% %DESTCMD% "**PROVIDER**" "ECHO Cloning %%REPO%% from bitbucket/%BBWSP%..." -l
%FREP% %DESTSUB% "**USER**" "SET SERVER_URL=https://%BBUSER%@bitbucket.org/%BBWSP%" -l
%FREP% %DESTSUB% "**PROVIDER**" "ECHO Adding sub module %%SUB%% from bitbucket/%BBWSP% to %%REPO%%..." -l
GOTO COMMON_REPLACE

:MAKE_GITLAB
:ENTER_GLUSER
SET GPROV=gitlab
SET /P GLUSER=Enter your gitlab user name or project name:
IF [%GLUSER%]==[] GOTO GLUSER_ERROR
SET DESTCMD="%IDHOME%\clone%SHORTNAME%.cmd"
COPY /Y "%~dp0\clone.cmd" %DESTCMD%
SET DESTSUB="%IDHOME%\addsub%SHORTNAME%.cmd"
COPY /Y "%~dp0\addsub.cmd" %DESTSUB%
%FREP% %DESTCMD% "**USER**" "SET SERVER_URL=https://gitlab.com/%GLUSER%" -l
%FREP% %DESTCMD% "**PROVIDER**" "ECHO Cloning %%REPO%% from gitlab/%GLUSER%..." -l
%FREP% %DESTSUB% "**USER**" "SET SERVER_URL=https://gitlab.com/%GLUSER%" -l
%FREP% %DESTSUB% "**PROVIDER**" "ECHO Adding sub module %%SUB%% from gitlab/%GLUSER% to %%REPO%%..." -l
GOTO COMMON_REPLACE

:COMMON_REPLACE
%FREP% %DESTCMD% "GOTO ENDBLOCKED" "REM clone script for %GPROV%"
%FREP% %DESTCMD% "**MAIN**" "%MAINBRANCH%"
%FREP% %DESTCMD% "**SCRIPT**" "clone%SHORTNAME%"

%FREP% %DESTSUB% "GOTO ENDBLOCKED" "REM add submodule script for %GPROV%"
%FREP% %DESTSUB% "**MAIN**" "%MAINBRANCH%"
%FREP% %DESTSUB% "**SCRIPT**" "addsub%SHORTNAME%"
GOTO NEXT_IDENTITY

:MAIN_BRANCH_ERROR
%WI% [r] .
%WI% [r] . You must enter the name of the main branch of this provider!
%WI% [r] .
GOTO MAIN_BRANCH_NAME

:PROVIDER_ERROR
%WI% [r] .
%WI% [r] . You must enter 1, 2 or 3!
%WI% [r] .
GOTO ENTER_PROVIDER

:SHORTNAME_ERROR
%WI% [r] .
%WI% [r] . You must enter a shortname for your identity!
%WI% [r] .
GOTO ENTER_SHORTNAME

:GHUSER_ERROR
%WI% [r] .
%WI% [r] . You must enter your github user name or organization to create an identity!
%WI% [r] .
GOTO ENTER_GHUSER

:BBUSER_ERROR
%WI% [r] .
%WI% [r] . You must enter your bitbucket user name to create an identity!
%WI% [r] .
GOTO ENTER_BBUSER

:BBWSP_ERROR
%WI% [r] .
%WI% [r] . You must enter your bitbucket workspace name to create an identity!
%WI% [r] .
GOTO ENTER_BBWORKSPACE

:GLUSER_ERROR
%WI% [r] .
%WI% [r] . You must enter your gitlab user name or project name to create an identity!
%WI% [r] .
GOTO ENTER_GLUSER

:NEXT_IDENTITY
SET /P ANOTHERID=Create another identity (y/n)?
GOTO START_IDENTITY

:END
%WI% [y] . -- Identity setup finished --
