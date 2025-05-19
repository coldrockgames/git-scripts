@ECHO OFF
SET REPO=%1

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
ECHO Fixing "%1"...
frep *.yy  """$GMSprite"":""v1""," """$GMSprite"":""""," -r
frep *.yyp """$GMAudioGroup"":""v1""," "    {""$GMAudioGroup"":"""",""%%Name"":""audiogroup_default"",""name"":""audiogroup_default"",""resourceType"":""GMAudioGroup"",""resourceVersion"":""2.0"",""targets"":-1,}," -r -l

REM {"$GMAudioGroup":"","%Name":"audiogroup_default","name":"audiogroup_default","resourceType":"GMAudioGroup","resourceVersion":"2.0","targets":-1,},

cd..
GOTO END

:ERROR
ECHO Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
ECHO Usage: yypfix repo

:END
ECHO --- Finished "%REPO%" ---

:FINISHSILENT
