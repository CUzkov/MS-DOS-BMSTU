@echo off

@keyb ru 866

set var1 = %1
set var2 = %2

:menu
if (%var2%) == () cls
echo 1. PATH
echo 2. Добавить в PATH
echo 3. Версия MS DOC
echo 4. Справка
echo 5. Выход
be ask "Выберете пункт (1,2,3,4,5) " '12345' default=6 timeout=100

if ERRORLEVEL 6 goto menu
if ERRORLEVEL 5 goto fin
if ERRORLEVEL 4 goto 4
if ERRORLEVEL 3 goto 3
if ERRORLEVEL 2 goto 2
if ERRORLEVEL 1 goto 1
goto fin

:1
@cls
@path
pause
goto menu

:2 
@cls
@set path=%path%;%3

goto menu

:3
@cls
@ver
pause
goto menu

:4
CALL %1  
pause
goto menu

:fin
cls