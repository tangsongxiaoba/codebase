@echo off
set XILINX=C:\Xilinx\14.7\ISE_DS\ISE
%XILINX%\bin\nt64\fuse -nodebug -prj mips.prj -o mips.exe testbench > mips.log
mips.exe -nolog -tclbatch mips.tcl > testbench.out
del fuse.log
del fuse.xmsgs
del fuseRelaunch.cmd
del isim.wdb
del mips.exe
rmdir /s /q isim
pause