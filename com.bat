@echo start
@echo off
@keyb ru 866

@REM .dir
@set var1 = %1

@cd %1
@copy %1.asm d:\tasm3
@cd/
@cd tasm3 
@echo on
@TASM.EXE /l /zi /c %1.asm
@TLINK.EXE /t /v /l /m %1.obj
@echo off
@copy %1.obj d:\%1
@copy %1.lst d:\%1
@copy %1.com d:\%1
@copy %1.map d:\%1

@del %1.obj
@del %1.lst
@del %1.com
@del %1.map

cd/
