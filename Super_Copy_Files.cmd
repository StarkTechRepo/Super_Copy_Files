@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
color 30
title https://github.com/OtaconEvil

REM Detectar si se ejecuta como administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM Si no se está ejecutando como administrador, reiniciar solicitando privilegios elevados
if '%errorlevel%' NEQ '0' (
    echo Por favor, ejecuta este archivo como administrador.
    pause
    exit /B
)


REM Obtener la ruta del directorio actual
set "dir=%~dp0"
set "outputFile=%dir%lista_archivos.txt"

:menu
REM Limpiar pantalla
cls

REM Mostrar el título y las opciones al usuario
echo.
echo ========================================
echo            Menú de Opciones
echo ========================================
echo.
echo 1. Copiar lista de nombres de archivos sin extensiones.
echo 2. Copiar lista de nombres de archivos con extensiones.
echo 3. Copiar lista de rutas y subcarpetas con extensiones.
echo 4. Salir
echo.
set /p opcion=Ingrese el número de opción deseada: 

REM Validar la opción ingresada por el usuario
if %opcion%==1 (
    REM Opción 1 Copiar lista de nombres de archivos sin extensiones
    (for %%F in ("%dir%*") do (
        set "filename=%%~nF"
        echo !filename!
    )) > "%outputFile%"
    echo.
    echo Lista de nombres de archivos sin extensiones guardada en %outputFile%
    pause
    goto continuar
) else if %opcion%==2 (
    REM Opción 2 Copiar lista de nombres de archivos con extensiones
    dir /b "%dir%" > %outputFile%
    echo.
    echo Lista de nombres de archivos con extensiones guardada en %outputFile%
    pause
    goto continuar
) else if %opcion%==3 (
    REM Opción 3 Copiar lista de rutas y subcarpetas con extensiones
    dir /b /s "%dir%" > %outputFile%
    echo.
    echo Lista de rutas y subcarpetas con extensiones guardada en %outputFile%
    pause
    goto continuar
) else if %opcion%==4 (
    REM Opción 4 Salir
    echo.
    echo Saliendo...
    timeout 2 >nul
    exit /b 0
) else (
    echo.
    echo Opción inválida. Por favor, seleccione una opción válida.
    timeout 2 >nul
    goto menu
)

:continuar
REM Preguntar si desea continuar usando el código
echo.
set /p continuar=Desea continuar? (s/n): 
if /i "%continuar%"=="s" goto menu
echo.
echo Saliendo...
timeout 2 >nul

