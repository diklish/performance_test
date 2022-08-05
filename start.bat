@echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "fullstamp=%YYYY%_%MM%_%DD%_%HH%_%Min%_%Sec%"

set nameJMX=SALEandSERVICE

mkdir %fullstamp%
rem chdir %fullstamp%

C:/NX_Soft/sqlcl/bin/sql SDM/employer@"personalstand.bssdev.rt.ru:30920/orclpdb1"  @C:/NX_Soft/êíä/Perf/scripts/SERCIVE_SALE.sql "C:/NX_Soft/êíä/Perf/" "1000"

C:\NX_Soft\apache-jmeter-5.4.1\bin\jmeter.bat -Dlog_level.jmeter=DEBUG -n -t %nameJMX%.jmx -l %fullstamp%/%nameJMX%.jtl -j %fullstamp%/%nameJMX%.log -e -o %fullstamp%/reports -Jtesttime=900 -Jthreads=15 -Jthreads1=20 -Jthreads2=35 -Jthreads3=25  -Jthreads4=2 -Jthreads4=12 -Jtest_start_up=900 -Jcustomer_Id_param=true 

