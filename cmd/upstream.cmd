@ECHO OFF
SET REPO=%1
SET BRANCH=%2

IF [%REPO%]==[] GOTO ERROR
IF NOT EXIST %REPO% GOTO ERROR

IF [%BRANCH%]==[] SET BRANCH=dev

SET MARKER=%REPO%\.git\.upstream_set

IF EXIST %MARKER% GOTO DO_IT
writein [r] -
writein [r] - No upstream set! Execute [y] "win-set-upstream.cmd" [r] in %REPO% first!
writein [r] -
GOTO END

:DO_IT
writein [y] Merging remote upstream/%BRANCH% into current branch...
CD %REPO%
writein [gr] Fetching upstream/%BRANCH%...
git fetch upstream
git merge --no-edit upstream/%BRANCH%
start tortoisegitproc /command:resolve /path:. 2>NUL
CD..
writein [g] Merge completed. Look for conflicts and resolve them before you continue!
GOTO END

:ERROR
writein [r] Error: No repository specified or repository "%REPO%" does not exist.

:USAGE
writein [gr] Usage: [y] upstream repo [branch]
writein [gr] BY DEFAULT, the [y] dev branch [gr] will be merge into the current branch.
writein [y] [branch] [gr] merges the specified branch from the remote into the current branch.

:END
