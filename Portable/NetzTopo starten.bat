@echo off
setlocal
title NetzTopo
cd /d "%~dp0"

rem ============================================================
rem  NetzTopo - Start ohne Installation
rem  Probiert nacheinander: mitgeliefertes Python, installiertes
rem  Python, offizielles Python von python.org (wird geladen).
rem  Protokoll: Daten\start-diagnose.txt
rem ============================================================

set "APPDIR=%~dp0"
set "NETZTOPO_HOME=%~dp0Daten"
set "PYTHONNOUSERSITE=1"
set "PYTHONHOME="
set "PYTHONPATH="
if not exist "%~dp0Daten" mkdir "%~dp0Daten"
set "LOG=%~dp0Daten\start-diagnose.txt"
echo NetzTopo-Start %date% %time% > "%LOG%"
echo Windows: >> "%LOG%"
ver >> "%LOG%"
echo Architektur: %PROCESSOR_ARCHITECTURE% %PROCESSOR_ARCHITEW6432% >> "%LOG%"

if not exist "%~dp0app\netztopo.py" goto noapp

rem --- Download-Sperre von Windows entfernen (Dateien aus dem Internet) ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -LiteralPath $env:APPDIR -Recurse -File -ErrorAction SilentlyContinue | Unblock-File -ErrorAction SilentlyContinue" >nul 2>&1

set "ARCH=win32"
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "ARCH=win64"
if /i "%PROCESSOR_ARCHITEW6432%"=="AMD64" set "ARCH=win64"
if /i "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "ARCH=win64"
set "PYARGS="

echo Suche Python ...

rem --- 1) mitgeliefertes Python ---
set "PY=%~dp0runtime\%ARCH%\python.exe"
call :try "%PY%"
if not errorlevel 1 goto run
set "PY=%~dp0runtime\win32\python.exe"
call :try "%PY%"
if not errorlevel 1 goto run

rem --- 2) zuvor geladenes offizielles Python ---
set "PY=%~dp0runtime\embed\python.exe"
call :try "%PY%"
if not errorlevel 1 goto run

rem --- 3) installiertes Python (py-Launcher oder python) ---
echo [Test] py -3 >> "%LOG%"
py -3 -c "import sys, ssl, sqlite3, ctypes; assert sys.version_info >= (3, 8)" >> "%LOG%" 2>&1
if errorlevel 1 goto trypython
set "PY=py"
set "PYARGS=-3"
goto run
:trypython
echo [Test] python >> "%LOG%"
python -c "import sys, ssl, sqlite3, ctypes; assert sys.version_info >= (3, 8)" >> "%LOG%" 2>&1
if errorlevel 1 goto download
set "PY=python"
goto run

rem --- 4) offizielles, signiertes Python von python.org laden ---
:download
echo.
echo Kein lauffaehiges Python gefunden. Lade offizielles Python 3.8 von python.org (ca. 8 MB) ...
echo [Download] %ARCH% >> "%LOG%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $u = if ($env:ARCH -eq 'win64') {'https://www.python.org/ftp/python/3.8.10/python-3.8.10-embed-amd64.zip'} else {'https://www.python.org/ftp/python/3.8.10/python-3.8.10-embed-win32.zip'}; $z = Join-Path $env:TEMP 'netztopo-python.zip'; Invoke-WebRequest -UseBasicParsing -Uri $u -OutFile $z; Expand-Archive -Force -LiteralPath $z -DestinationPath (Join-Path $env:APPDIR 'runtime\embed'); Remove-Item $z" >> "%LOG%" 2>&1
set "PY=%~dp0runtime\embed\python.exe"
call :try "%PY%"
if not errorlevel 1 goto run
goto fail

rem --- Start ---
:run
echo [Start] %PY% %PYARGS% >> "%LOG%"
echo Starte NetzTopo ...
"%PY%" %PYARGS% "%~dp0app\netztopo.py" %*
if errorlevel 1 goto crashed
exit /b 0

:crashed
echo.
echo NetzTopo wurde mit einem Fehler beendet.
echo Details: Daten\netztopo-fehler.log und Daten\start-diagnose.txt
pause
exit /b 1

:noapp
echo Die Datei app\netztopo.py fehlt.
echo Bitte die ZIP-Datei zuerst komplett entpacken (Rechtsklick - Alle extrahieren).
pause
exit /b 1

:fail
echo.
echo Python konnte nicht gestartet werden.
echo Moegliche Ursachen: Virenschutz/AppLocker blockiert python.exe, kein Internet fuer den Download.
echo Bitte die Datei Daten\start-diagnose.txt an den Support schicken.
pause
exit /b 1

rem --- Unterprogramm: funktioniert dieses Python? ---
:try
if not exist "%~1" exit /b 1
echo [Test] %~1 >> "%LOG%"
"%~1" -c "import sys, ssl, sqlite3, ctypes; print(sys.version)" >> "%LOG%" 2>&1
exit /b %errorlevel%
