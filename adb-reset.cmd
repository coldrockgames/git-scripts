@ECHO OFF
mkill adb --all
IF "%1"=="" GOTO END
pause
:END
