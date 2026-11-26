@echo off
setlocal
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  echo InteriorMind setup is incomplete. Open README.md for installation steps.
  pause
  exit /b 1
)
".venv\Scripts\python.exe" -m interiormind.app
if errorlevel 1 pause
endlocal
