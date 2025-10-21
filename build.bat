@echo off
rem build.bat acepta como parámetro la ruta completa SIN extensión
rem Ejemplo: build.bat "C:\...\001_HelloWorld\hello"

if "%~1"=="" (
  echo Uso: build.bat "ruta\al\archivo_sin_extension"
  echo Ejemplo: build.bat "C:\... \001_HelloWorld\hello"
  pause
  exit /b 1
)

rem Parametro puede ser: C:\path\to\001_HelloWorld\hello
set FILEBASE=%~1
set ASM_PATH=%FILEBASE%.asm
set OBJ_PATH=%FILEBASE%.obj
set EXE_PATH=%FILEBASE%.exe
set WORKDIR=%~dp1

echo Ensamblando: "%ASM_PATH%"

rem Forzamos que ml escriba el .obj exactamente donde queremos (/Fo)
"C:\masm32\bin\ml" /c /coff /Fo"%OBJ_PATH%" "%ASM_PATH%"
if errorlevel 1 (
  echo.
  echo ERROR: fallo en ensamblado.
  pause
  exit /b 1
)

echo Linkeando: "%OBJ_PATH%"
"C:\masm32\bin\link" /subsystem:console /OUT:"%EXE_PATH%" "%OBJ_PATH%"
if errorlevel 1 (
  echo.
  echo ERROR: fallo en linkeo.
  pause
  exit /b 1
)

echo Ejecutando en la misma terminal: "%EXE_PATH%"
rem Ejecutar en la misma consola para que la salida quede visible
call "%EXE_PATH%"
echo --- Programa finalizado (exit code: %errorlevel%) ---
pause
