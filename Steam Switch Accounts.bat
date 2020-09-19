@echo off
color 70
mode con: cols=50 lines=10
TITLE Steam Account Switcher

setlocal EnableDelayedExpansion
setlocal enabledelayedexpansion

:steamProcess
echo 		Process Check
powershell -Command Write-Host "/ steam.exe" -foreground "blue"
timeout 3 >nul
tasklist | find /i "steam.exe" && echo steam.exe is running  && powershell -Command Write-Host "terminating process..." -foreground "red" && timeout 3 >nul && taskkill /im steam.exe /F || echo( && echo process "steam.exe" not running. && loading... && timeout 2 >nul
cls

:configFile
if exist %localappdata%\SteamAccountSwitcher\config.txt  (
< %localappdata%\SteamAccountSwitcher\config.txt (
  set /p mainuser=
  set /p altuser=
) && GOTO selectionScreen) else (
GOTO accountSetup )

:accountSetup
powershell -Command Write-Host "/   Main Account Set-up" -foreground "blue"
set /p "mainuser=Username: " 
echo %mainuser% >> %localappdata%\SteamAccountSwitcher\config.txt
cls
powershell -Command Write-Host "/   Alt Account Set-up" -foreground "blue"
set /p "altuser=Username: "
echo %altuser% >> %localappdata%\SteamAccountSwitcher\config.txt

cls

:selectionScreen
mode con: cols=56 lines=20
echo(
echo	========================================================
echo 		Select your account
echo ========================================================
echo(
echo 1 - %mainuser%
echo 2 - %altuser%
echo(
echo(
echo Script currently only supports two accounts.
echo(
echo You need to use both options at-least once to bypass the login stage.
echo(
echo(
echo(
echo(
echo(
CHOICE /M Select /C 12

If Errorlevel 2 Goto 2
If Errorlevel 1 Goto 1

:2
set username=%altuser%
Goto end
:1
set username=%mainuser%
Goto end



:end
reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %username% /f
reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
start steam://open/main

exit