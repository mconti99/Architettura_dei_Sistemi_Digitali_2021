@echo off

rem  Vivado (TM)
rem  route_design_reports.bat: a Vivado-generated Script
rem  Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.


set HD_SDIR=%~dp0
cd /d "%HD_SDIR%"
cscript /nologo /E:JScript "%HD_SDIR%\route_design_reports.js" %*
