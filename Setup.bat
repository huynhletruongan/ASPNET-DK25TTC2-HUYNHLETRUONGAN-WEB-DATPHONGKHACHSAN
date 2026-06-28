@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set "PROJECT_DIR=%~dp0"
set "DOAN_DIR=%PROJECT_DIR%DoAn"
set "WEB_CONFIG=%DOAN_DIR%\Web.config"
set "DB_DIR=%DOAN_DIR%\database"
set "SLN_FILE=%PROJECT_DIR%DoAn.sln"
set "IIS_SITE_NAME=BookKhachSan"
set "IIS_PORT=49851"
set "IIS_APP_POOL=BookKhachSanPool"

set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "CYAN=[96m"
set "NC=[0m"

:menu
cls
echo.
echo  ================================================================
echo    HE THONG QUAN LY KHACH SAN - Setup Wizard
echo    Hotel Booking Management System - An-Huynh
echo  ================================================================
echo.
echo  Chon database provider:
echo  ================================================================
echo   1. SQLite  ^(Khuyen nghi - Khong can cai dat gi them^)
echo   2. SQL Server Express
echo  ================================================================
echo.
set /p CHOICE="Chon (1-2): "

if "!CHOICE!"=="1" goto :run_sqlite
if "!CHOICE!"=="2" goto :run_sqlserver

echo.
echo [%RED]X[%NC%] Lua chon khong hop le.
pause
goto :menu

:run_sqlite
cls
echo.
echo [%CYAN]>>> Cau hinh SQLite (khuyen nghi)[%NC%]
echo.

echo [%TIME%]  Dat provider thanh SQLite...
powershell -Command "$c = [System.IO.File]::ReadAllText('%WEB_CONFIG%'); $c = $c -replace 'DatabaseProvider.*value=\"[^\"]*\"','DatabaseProvider\" value=\"SQLite\"'; [System.IO.File]::WriteAllText('%WEB_CONFIG%', $c)"
echo [%GREEN]OK[%NC%] Provider: SQLite

echo.
echo [%TIME%]  Tao thu muc database...
if not exist "%DB_DIR%" (
    mkdir "%DB_DIR%" 2>nul
    echo [%GREEN]OK[%NC%] Da tao thu muc database
) else (
    echo [%GREEN]OK[%NC%] Thu muc database da ton tai
)

echo.
echo [%TIME%]  Build project...
call :build_proj
if errorlevel 1 (
    echo.
    echo [%RED]X[%NC%] Build that bai! Vui long kiem tra loi trong Visual Studio.
    pause
    goto :menu
)

echo.
call :setup_iis
goto :menu

:run_sqlserver
cls
echo.
echo [%CYAN]>>> Cau hinh SQL Server Express[%NC%]
echo.
echo  Huong dan:
echo  1. Dam bao SQL Server Express da cai dat
echo  2. SQL Server Browser dang chay
echo  3. TCP/IP da duoc enable trong SQL Server Configuration Manager
echo.

set /p SQL_SERVER="Ten server (mac dinh localhost\SQLEXPRESS): "
if "!SQL_SERVER!"=="" set "SQL_SERVER=localhost\SQLEXPRESS"

set /p DB_NAME="Ten database (mac dinh DoAn): "
if "!DB_NAME!"=="" set "DB_NAME=DoAn"

echo.
echo [%TIME%]  Sao luu Web.config...
copy /Y "%WEB_CONFIG%" "%WEB_CONFIG%.bak" >nul 2>&1
echo [%GREEN]OK[%NC%] Da sao luu Web.config

echo.
echo [%TIME%]  Dat provider thanh SqlServer...
powershell -Command "$c = [System.IO.File]::ReadAllText('%WEB_CONFIG%'); $c = $c -replace 'DatabaseProvider.*value=\"[^\"]*\"','DatabaseProvider\" value=\"SqlServer\"'; [System.IO.File]::WriteAllText('%WEB_CONFIG%', $c)"
echo [%GREEN]OK[%NC%] Provider: SqlServer

echo.
echo [%TIME%]  Cap nhat cau hinh Web.config...
powershell -Command "$c = [System.IO.File]::ReadAllText('%WEB_CONFIG%'); $c = $c -replace 'data source=[^;]*;', 'data source=!SQL_SERVER!;'; $c = $c -replace 'initial catalog=[^;]*;', 'initial catalog=!DB_NAME!;'; [System.IO.File]::WriteAllText('%WEB_CONFIG%', $c)"
echo [%GREEN]OK[%NC%] Da cap nhat:
echo     Server: !SQL_SERVER!
echo     Database: !DB_NAME!

echo.
echo [%TIME%]  Kiem tra ket noi SQL Server...
where sqlcmd >nul 2>&1
if errorlevel 1 (
    echo [%YELLOW] ![NC%] sqlcmd khong tim thay.
) else (
    sqlcmd -S "!SQL_SERVER!" -Q "SELECT @@VERSION" -b >nul 2>&1
    if errorlevel 1 (
        echo [%YELLOW] ![NC%] Khong the ket noi SQL Server '!SQL_SERVER!'
    ) else (
        echo [%GREEN]OK[%NC%] Ket noi SQL Server thanh cong!
        echo [%TIME%]  Kiem tra database !DB_NAME!...
        sqlcmd -S "!SQL_SERVER!" -Q "IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = '!DB_NAME!') CREATE DATABASE !DB_NAME!" -b >nul 2>&1
        echo [%GREEN]OK[%NC%] Database !DB_NAME! da san sang

        set "SQL_SCRIPT=%PROJECT_DIR%SQL_DoAn.sql"
        if exist "%SQL_SCRIPT%" (
            echo [%TIME%]  Chay script khoi tao database...
            sqlcmd -S "!SQL_SERVER!" -d "!DB_NAME!" -i "%SQL_SCRIPT%" -b >nul 2>&1
            if errorlevel 1 (
                echo [%YELLOW] ![NC%] Script SQL co loi.
            ) else (
                echo [%GREEN]OK[%NC%] Script SQL da chay xong
            )
        )
    )
)

echo.
echo [%TIME%]  Build project...
call :build_proj
if errorlevel 1 (
    echo.
    echo [%RED]X[%NC%] Build that bai!
    pause
    goto :menu
)

echo.
call :setup_iis
goto :menu

:build_proj
set "MSBUILD=C:\Program Files\Microsoft Visual Studio\18\Insiders\MSBuild\Current\Bin\MSBuild.exe"
if not exist "%MSBUILD%" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
set BUILD_OK=0
if exist "%SLN_FILE%" (
    "%MSBUILD%" "%SLN_FILE%" /p:Configuration=Debug /t:Build /v:minimal >nul 2>&1
    if not errorlevel 1 set BUILD_OK=1
)
if "!BUILD_OK!"=="0" (
    "%MSBUILD%" "%DOAN_DIR%\DoAn.csproj" /p:Configuration=Debug /t:Build /v:minimal >nul 2>&1
    if not errorlevel 1 set BUILD_OK=1
)
if "!BUILD_OK!"=="1" (
    echo [%GREEN]OK[%NC%] Build thanh cong
    exit /b 0
)
exit /b 1

:setup_iis
set "APPCMD=C:\Windows\System32\inetsrv\appcmd.exe"
echo.
echo [%TIME%]  Cau hinh IIS...
echo [%TIME%]  Dang ky ASP.NET voi IIS...
powershell -Command "if (Test-Path 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe') { & 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe' -ir -enable }" >nul 2>&1

echo.
echo [%TIME%]  Tao Application Pool...
"%APPCMD%" add apppool /name:"!IIS_APP_POOL!" /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated 2>nul
echo [%GREEN]OK[%NC%] Application Pool da tao

echo.
echo [%TIME%]  Xoa site cu neu co...
"%APPCMD%" delete site "!IIS_SITE_NAME!" 2>nul

echo.
echo [%TIME%]  Tao Website...
"%APPCMD%" add site /name:"!IIS_SITE_NAME!" /id:99 /physicalPath:"%DOAN_DIR%" /bindings:http/*:!IIS_PORT!: 2>nul
echo [%GREEN]OK[%NC%] Website da tao

echo.
echo [%TIME%]  Gan Application Pool...
"%APPCMD%" set app "!IIS_SITE_NAME!/" /applicationPool:"!IIS_APP_POOL!" 2>nul
echo [%GREEN]OK[%NC%] Gan xong

echo.
echo [%TIME%]  Khoi dong site...
"%APPCMD%" start site "!IIS_SITE_NAME!" 2>nul
echo [%GREEN]OK[%NC%] Site da khoi dong tren port !IIS_PORT!

echo.
echo [%TIME%]  Mo trinh duyet...
start "" "http://localhost:!IIS_PORT!/Login"

echo.
echo [%GREEN]OK[%NC%] Tai khoan mac dinh: admin / 123
echo [%GREEN]OK[%NC%] Hoac truy cap: http://localhost:!IIS_PORT!/Login
echo.
echo ================================================================
echo  [!GREEN]Hoan tat![%NC%] Bam phim bat ky de quay lai menu.
echo ================================================================
pause >nul
exit /b
