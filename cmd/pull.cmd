@ECHO OFF
SET REPO=%1
SET WILDCARD=*

IF [%REPO%]==[*] GOTO ALL
IF [%REPO%]==[] GOTO ERROR

ECHO %REPO% | findstr /C:"*" >nul
IF NOT ERRORLEVEL 1 (
	SET WILDCARD=%REPO%
	GOTO ALL
)

IF NOT EXIST %REPO% GOTO ERROR

cd %REPO%
IF [%2]==[] GOTO PULLALL

writein [gr] Pulling [y] "%REPO%/%2" [] ...
git pull -v --no-rebase --no-edit "origin" %2
GOTO SUBS

:PULLALL
writein [gr] Pulling [y] "%REPO%" (full) [] ...
git pull -v --no-rebase --no-edit --all
GOTO SUBS

:ERROR
writein [r] Error: No repository specified or repository "%REPO%" does not exist.
writein [gr] Usage: [y] pull repo [branch] [submodule-branch=main]
writein [gr] If branch is specified only this branch will be pulled.
writein [gr] Specify a [y] submodule-branch [gr] only, if you want to checkout
writein [gr] a different branch than [y] main [gr] of the submodules.
GOTO FINISHLINE

:SUBS
IF NOT EXIST .gitmodules GOTO END
SET SUBBRANCH=%3
IF [%SUBBRANCH%]==[] SET SUBBRANCH=main
ECHO Processing submodules in %REPO% (checkout-branch: %SUBBRANCH%)...
git submodule foreach "git checkout %SUBBRANCH%"
git submodule foreach "git fetch"
git submodule foreach "git merge"
cd..
CALL push.cmd %REPO% "submodule update"
GOTO END_NO_STEP_OUT

:END
cd..

:END_NO_STEP_OUT
GOTO FINISHLINE

:ALL
FOR /D %%G in (%WILDCARD%) DO CALL pull.cmd %%~nxG %2
GOTO FINISHSILENT

:FINISHLINE
writein [g] --- Finished [y] "%REPO%" [g] ---

:FINISHSILENT
