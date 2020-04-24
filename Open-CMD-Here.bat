@echo off

REM VERIFYING BAT WAS RUN AS ADMIN
net session > nul 2>&1
if /i not %errorlevel%==0 (
  echo You need to run this script as Admin genius.
  echo Exiting
  pause
  goto:eof
)


REM DESCRIBING AND VERIFYING YOU WANT TO INSTALL THE SCRIPT
Echo Hello Father
Echo This will change the registry to add "Open Admin CMD window here" to the context menu.
Echo USAGE: You must hold SHIFT and then RIGHT CLICK inside a folder to use it! ///
Echo -----------------------------------
Echo CONTINUING WILL INSTALL THE SCRIPT.
Echo -----------------------------------
pause


REM CHANGING REGISTRY TO ADD OPEN CMD HERE TO CONTEXT MENU
call :setreg "HKCR\Directory\shell\runas"
call :setreg "HKCR\Directory\Background\shell\runas"

:setreg
  call :setrunas "%~1"
  call :setcommand "%~1\command"
  goto :eof

:setrunas
  call :setregval "%~1" /d "Open CMD window here (&Admin)"
  call :setregval "%~1" /v Extended
  call :setregval "%~1" /v NoWorkingDirectory
  goto :eof

:setcommand
  call :setregval "%~1" /d "cmd.exe /s /k pushd \"%%%%V\""
  goto :eof

:setregval
  reg add "%~1" "%~2" "%~3" /f > nul 2>&1
  goto :eof
