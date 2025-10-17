@echo off
REM Quick launcher for publish-profiles.ps1
REM Usage: publish-profiles.bat "Your commit message"

if "%~1"=="" (
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0publish-profiles.ps1"
) else (
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0publish-profiles.ps1" -Message "%~1"
)

