@ECHO OFF

IF [%1]==[] GOTO ERROR
writein [g] csnuget - build %1 and publish to local feed

IF [%2]==[] GOTO DO_IT
CALL csversion %2

:DO_IT
IF EXIST delnuget.cmd CALL delnuget.cmd
dotnet pack %1 -o C:\Work\dev\git\net\_local_packages -nowarn:NU5128

GOTO END

:ERROR
writein [r] csnuget argument error
writein [r] You must specify the version to set in the solution
writein [y] Usage: csnuget csproj_or_sln [version_to_set]
writein [y] Example: csnuget libs.sln 7.3.1
writein [y] If you do not specify a version number, the current version of the project is reused.

:END
