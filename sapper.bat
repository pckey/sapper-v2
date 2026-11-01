@echo off
setlocal EnableExtensions
REM sapper.bat — portable launcher.
REM Resolves lib/sapper.py relative to THIS file, so you can copy the whole
REM sapper-v2 folder to another PC / cloud drive and it keeps working without
REM editing any paths. Run it from your project directory (the .sapper graph
REM is created in the current working directory, not next to this file).
set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "SAPPER_PY=%SCRIPT_DIR%\lib\sapper.py"

REM Pick a Python 3 runtime. Prefer the Windows 'py' launcher's newest 3.x,
REM then fall back to python / python3 on PATH. Keep exe and args separate so
REM cmd does not treat "py -3" as a single (nonexistent) command name.
set "PYEXE="
set "PYARGS="
where py >nul 2>&1 && set "PYEXE=py" && set "PYARGS=-3"
if not defined PYEXE ( where python >nul 2>&1 && set "PYEXE=python" )
if not defined PYEXE ( where python3 >nul 2>&1 && set "PYEXE=python3" )
if not defined PYEXE (
  echo [sapper] ERROR: no Python 3 found. >&2
  echo [sapper] Install Python 3.8+ from python.org and ensure 'py' or 'python' is on PATH. >&2
  exit /b 1
)

"%PYEXE%" %PYARGS% "%SAPPER_PY%" %*
