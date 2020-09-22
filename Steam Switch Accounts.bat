@echo off
color 70
mode con: cols=50 lines=10
setlocal
cd %localappdata%
TITLE Steam Account Switcher

:steamProcess
echo 		Process Check
powershell -Command Write-Host "/ steam.exe" -foreground "blue"
timeout 3 >nul
tasklist | find /i "steam.exe" && echo steam.exe is running  && powershell -Command Write-Host "terminating process..." -foreground "red" && timeout 3 >nul && taskkill /im steam.exe /F || echo( && echo process "steam.exe" not running. && loading... && timeout 2 >nul
cls

:folder
if not exist SteamAccountSwitcher ( 
md SteamAccountSwitcher  && cd SteamAccountSwitcher && GOTO accountSetup
) else ( cd SteamAccountSwitcher && GOTO configFile)

:configFile
if exist config.txt  (
< config.txt (
  set /p mainuser=
  set /p altuser=
) && GOTO selectionScreen) else (
GOTO accountSetup )

:accountSetup
break>config.txt
powershell -Command Write-Host "/   Main Account Set-up" -foreground "blue"
set /p "mainuser=Username: " 
echo %mainuser% >> config.txt
cls
powershell -Command Write-Host "/   Alt Account Set-up" -foreground "blue"
set /p "altuser=Username: "
echo %altuser% >> config.txt

:selectionScreen
mode con: cols=56 lines=20
cls
echo(
echo	========================================================
echo 		Select your account
echo ========================================================
echo(
echo 1 - %mainuser%
echo 2 - %altuser%
echo(
echo 3 - Edit Users
echo 4 - Delete Data
echo(
echo(
echo Script currently only supports two accounts.
echo(
echo You need to use both options at-least once to bypass the login stage.
echo(
echo(
echo(
echo(
CHOICE /C 1234 

IF ERRORLEVEL 4 GOTO 4
IF ERRORLEVEL 3 GOTO 3
IF ERRORLEVEL 2 GOTO 2
IF ERRORLEVEL 1 GOTO 1

:4
cd ..
RD /S /Q "SteamAccountSwitcher" 
cls
echo Data has been deleted.  Exiting...
timeout 3 >nul
exit
:3
cls
GOTO accountSetup
:2
set username=%altuser%
GOTO end
:1
set username=%mainuser%
GOTO end

:end
reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %username% /f
reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
start steam://open/main

exit