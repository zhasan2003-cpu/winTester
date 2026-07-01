@echo off
chcp 65001 >nul
set OUT=%USERPROFILE%\Desktop\PC_DIAGNOSTIC.txt

echo PC DIAGNOSTIC > "%OUT%"
echo Date: %date% %time% >> "%OUT%"
echo. >> "%OUT%"

echo === SYSTEM === >> "%OUT%"
systeminfo >> "%OUT%"

echo. >> "%OUT%"
echo === DISK SMART STATUS === >> "%OUT%"
wmic diskdrive get model,status,size,serialnumber >> "%OUT%"

echo. >> "%OUT%"
echo === DISK PARTITIONS === >> "%OUT%"
wmic logicaldisk get caption,filesystem,freespace,size,volumename >> "%OUT%"

echo. >> "%OUT%"
echo === TOP PROCESSES BY CPU === >> "%OUT%"
wmic path Win32_PerfFormattedData_PerfProc_Process get Name,PercentProcessorTime,WorkingSetPrivate | sort /R >> "%OUT%"

echo. >> "%OUT%"
echo === RUNNING TASKS === >> "%OUT%"
tasklist /v >> "%OUT%"

echo. >> "%OUT%"
echo === SERVICES === >> "%OUT%"
sc query type= service state= all >> "%OUT%"

echo. >> "%OUT%"
echo === STARTUP === >> "%OUT%"
wmic startup get caption,command,location >> "%OUT%"

echo. >> "%OUT%"
echo === RECENT DISK ERRORS === >> "%OUT%"
wevtutil qe System /q:"*[System[(Level=2 or Level=3) and (Provider[@Name='disk'] or Provider[@Name='Ntfs'] or Provider[@Name='storahci'] or Provider[@Name='atapi'])]]" /c:30 /f:text >> "%OUT%"

echo. >> "%OUT%"
echo === MEMORY === >> "%OUT%"
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize >> "%OUT%"

echo. >> "%OUT%"
echo Готово. Файл создан на рабочем столе: PC_DIAGNOSTIC.txt
pause
