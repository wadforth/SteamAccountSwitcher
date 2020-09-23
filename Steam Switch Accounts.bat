@echo off
color 70
mode con: cols=50 lines=10
setlocal enabledelayedexpansion
cd %localappdata%
TITLE Steam Account Switcher

set /a counter = 0
set /a counterFix=%counter%+1
set textFile = 0

:steamProcess
tasklist | find /i "steam.exe" && taskkill /im steam.exe /F
cls

:folder
if not exist SteamAccountSwitcher ( 
md SteamAccountSwitcher  && cd SteamAccountSwitcher && GOTO accountSetup
) else ( cd SteamAccountSwitcher && GOTO configExist)

:configExist
if exist config.txt  (
GOTO configFile) else (
GOTO accountSetup)

:configFile
 for /f "tokens=*" %%x in (config.txt) do (
    set /a textFile+=1
    set account[!textFile!]=%%x
	
) 
GOTO selectionScreen

:accountSetup
set /p accountInput="How many accounts would you like to use? "
cls
powershell -Command Write-Host "/  Main Account Set-up" -background "blue"
:accountLoop
call :checkInput %accountInput% || goto :invalidInput
set /p "account=Username: " 
echo %account% >> config.txt
set /a counter+=1
 if %counter% == %accountInput% ( %0 ) else ( 
cls && echo /  Alt Account %counterFix% && GOTO accountLoop )
cls

:selectionScreen
mode con: cols=56 lines=20
cls
echo(
echo	========================================================
echo 		Select your account
echo ========================================================
echo(
echo 1 - %account[1]%
echo 2 - %account[2]%
echo 3 - %account[3]%
echo 4 - %account[4]%
echo 5 - %account[5]%
echo 6 - %account[6]%
echo 7 - %account[7]%
echo(
echo 8 - Edit Users
echo 9 - Delete Data
echo(
powershell -Command Write-Host "DO NOT SELECT BLANK OPTIONS" -background "red"
echo You need to use all options at-least once to bypass the login stage.
echo(
CHOICE /C 123456789

IF ERRORLEVEL 9 GOTO 9
IF ERRORLEVEL 8 GOTO 8
IF ERRORLEVEL 7 GOTO 7
IF ERRORLEVEL 6 GOTO 6
IF ERRORLEVEL 5 GOTO 5
IF ERRORLEVEL 4 GOTO 4
IF ERRORLEVEL 3 GOTO 3
IF ERRORLEVEL 2 GOTO 2
IF ERRORLEVEL 1 GOTO 1

:9
cd ..
RD /S /Q "SteamAccountSwitcher" 
cls
echo Data has been deleted.  Exiting...
timeout 3 >nul
exit
:8
break>config.txt
cls
powershell -Command Write-Host "/ Editing Accounts" -background "green" 
powershell -Command Write-Host "WARNING!" -background "red" -foreground "white"
powershell -Command Write-Host "YOU MAY NEED TO RESTART APP AS OLD ACCOUNTS WILLL SHOW - SHOULD BE FIXED IN NEXT VERSION" -background "red" -foreground "white"
GOTO accountSetup
:7
set username=%account[7]%
GOTO end
:6
set username=%account[6]%
GOTO end
:5
set username=%account[5]%
GOTO end
:4
set username=%account[4]%
GOTO end
:3
set username=%account[3]%
GOTO end
:2
set username=%account[2]%
GOTO end
:1
set username=%account[1]%
GOTO end

:end
reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %username% /f
reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
start steam://open/main

exit

:invalidInput
cls
echo Invalid Input - Try a number between 2-7.
goto accountSetup

:checkInput
for /f  "delims=234567" %%a in ("%1") do exit /b 1
exit /b 0
