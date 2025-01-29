@echo off
setlocal enabledelayedexpansion

rem Prompt user for organization domain name
set /p domain_name="Enter organization domain name (e.g., example): "

rem Prompt user for application name
set /p app_name="Enter application name: "

rem Display information to the user
echo.
echo Organization domain name: %domain_name%
echo Application name: %app_name%
echo.

rem Ask for confirmation
set /p confirm="Do you want to create a Flutter app with the provided information? (y/n): "

rem Check user's confirmation
if /i "%confirm%"=="y" (
    rem Create Flutter app using the provided input
    flutter create --org=com.%domain_name% --project-name %app_name% %app_name%
) else (
    echo Operation canceled. No Flutter app was created.
)

endlocal
