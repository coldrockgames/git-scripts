@ECHO OFF

IF [%1]==[] GOTO ERROR
IF [%1]==[?] GOTO QUERY

writein [g] csversion - Set Version of C# Projects to %1
frep *.csproj "<AssemblyVersion>" "    <AssemblyVersion>%1</AssemblyVersion>" -r -l
frep *.csproj "<FileVersion>" "    <FileVersion>%1</FileVersion>" -r -l
frep *.csproj "<Version>" "    <Version>%1</Version>" -r -l
GOTO END

:QUERY
mgrep *.csproj "<Version>" -r -0 +0
GOTO END

:ERROR
writein [r] csversion argument error
writein [r] You must specify the version to set in the solution or ? to query current version
writein [y] Usage: csversion ? [] (this will grep the current version)
writein [y] Usage: csversion 7.0.0

:END
