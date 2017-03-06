@ECHO OFF
:SETWINDOWSIZE
mode con: cols=112  lines=48
:INITIALIZE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
REG QUERY HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step"
IF %errorlevel% == 0 GOTO HAPPYEASTER 
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "1" /f

:HAPPYEASTER
CLS
ECHO Loading please wait...  Press (i) key for System Information and Other Options.
choice /c eix /t 6 /d x >nul
if %errorlevel% == 1 GOTO RUNEGG
if %errorlevel% == 2 GOTO OPTIONS
GOTO VERSIONCHECK

:RUNEGG
C:\AV3.3\ETC\DOSBoxPortable.exe -noconsole
GOTO VERSIONCHECK

:OPTIONS
CLS
ECHO.
ECHO System Information and Other Options:
ECHO. 
ECHO ==========================================================
ECHO SYSTEM INFORMATION
ECHO ==========================================================
ECHO.
ECHO (P) Retrieve Product Key(s)
ECHO (F) Full Backup of System
ECHO.
ECHO ==========================================================
ECHO OTHER OPTIONS
ECHO ==========================================================
ECHO Selecting Option 1-9 will tell the program to restart 
ECHO and resume from that step. 
ECHO.
ECHO (1) Check HD
ECHO (2) Revo     
ECHO (3) Junk File Cleanup
ECHO (4) CCleaner
ECHO (5) SpyBot
ECHO (6) ADW Cleaner
ECHO (7) Disk Cleanup [Win 8/8.1/2012/10] - ComboFix [Win 2000/NT/XP/2003/VISTA/7/2008]
ECHO (8) Malwarebytes
ECHO (9) Eset Security Scan
ECHO.
ECHO ==========================================================
ECHO.
ECHO (X) Leave this Menu
ECHO.
ECHO ==========================================================
ECHO.
ECHO (0) Reset AutoClean and exit program.
ECHO.
ECHO ==========================================================
ECHO.
ECHO.
CHOICE /C 1234567890XPF /N /M "Enter a Selection or press any other key to exit:"
IF %errorlevel% == 1 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "1" /f
IF %errorlevel% == 2 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
IF %errorlevel% == 3 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
IF %errorlevel% == 4 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
IF %errorlevel% == 5 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
IF %errorlevel% == 6 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
IF %errorlevel% == 7 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
IF %errorlevel% == 8 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
IF %errorlevel% == 9 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
IF %errorlevel% == 10 GOTO COMPLETE
IF %errorlevel% == 11 GOTO INITIALIZE
IF %errorlevel% == 12 GOTO GETKEY
IF %errorlevel% == 13 GOTO BACKUP
ECHO.
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set option=%%B

    if %option% == 1 ECHO You selected Check HD, the program will resume at Step 1 of 9
    if %option% == 2 ECHO You selected Revo, the program will resume at Step 2 of 9
    if %option% == 3 ECHO You selected Junk File Cleanup, the program will resume at Step 3 of 9
    if %option% == 4 ECHO You selected CCleaner, the program will resume at Step 4 of 9
    if %option% == 5 ECHO You selected SpyBot, the program will resume at Step 5 of 9
    if %option% == 6 ECHO You selected ADW Cleaner, the program will resume at Step 6 of 9
    if %option% == 7 ECHO You selected Disk Cleanup / ComboFix, the program will resume at Step 7 of 9
    if %option% == 8 ECHO You selected Malwarebytes, the program will resume at Step 8 of 9
    if %option% == 9 ECHO You selected Eset Security Scan, the program will resume at Step 9 of 9
ECHO.
PAUSE
GOTO INITIALIZE

:GETKEY
CLS
INFO\GetKey.exe /s raw.txt
FINDSTR /i /c:"Micro" /c:"Comp" /c:"Owne" /c:"PID:" /c:"Key:" INFO\raw.txt >INFO\keyinfo.txt
CLS
ECHO.
ECHO ==========================================================
ECHO. System Information
ECHO ==========================================================
ECHO.
ECHO.
TYPE INFO\keyinfo.txt
ECHO.
ECHO.
ECHO ==========================================================
ECHO.
ECHO.
CHOICE /M "Would you like to save a copy of this information on the Desktop?"
IF %errorlevel% == 1 COPY INFO\keyinfo.txt %USERPROFILE%\Desktop\
IF %errorlevel% == 2 GOTO OPTIONS
PAUSE
GOTO INITIALIZE

:VERSIONCHECK
CLS
ECHO Determining Windows version...
ver | find "2003" > nul
if %ERRORLEVEL% == 0 goto ver_2003

ver | find "XP" > nul
if %ERRORLEVEL% == 0 goto ver_xp

ver | find "2000" > nul
if %ERRORLEVEL% == 0 goto ver_2000

ver | find "NT" > nul
if %ERRORLEVEL% == 0 goto ver_nt

if not exist %SystemRoot%\system32\systeminfo.exe goto warn

FOR /F "delims=: tokens=2" %%i IN ('systeminfo 2^>NUL ^| find "OS Name"') DO set vers=%%i

echo %vers% | find "Windows 10" > nul
if %ERRORLEVEL% == 0 goto ver_10

echo %vers% | find "Windows 8" > nul
if %ERRORLEVEL% == 0 goto ver_8

echo %vers% | find "Windows 7" > nul
if %ERRORLEVEL% == 0 goto ver_7

echo %vers% | find "Windows Server 2008" > nul
if %ERRORLEVEL% == 0 goto ver_2008

echo %vers% | find "Windows Server 2012" > nul
if %ERRORLEVEL% == 0 goto ver_2012

echo %vers% | find "Windows Vista" > nul
if %ERRORLEVEL% == 0 goto ver_vista

goto warn

:ver_10
REM Run Windows 10 specific commands here.
REM _______________________________________________________________________________
REM                                    | 10 |
REM _______________________________________________________________________________
echo Windows 10 Identified 
:RUNSTEP10
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows 10
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set staging10=%%B

    if %staging10% == 1 (GOTO 10STEP1)
    if %staging10% == 2 (GOTO 10STEP2)
    if %staging10% == 3 (GOTO 10STEP3)
    if %staging10% == 4 (GOTO 10STEP4)
    if %staging10% == 5 (GOTO 10STEP5)
    if %staging10% == 6 (GOTO 10STEP6)
    if %staging10% == 7 (GOTO 10STEP7)
    if %staging10% == 8 (GOTO 10STEP8)
    if %staging10% == 9 (GOTO 10STEP9)
    if %staging10% == 10 (GOTO COMPLETE)
    if %staging10% == 11 (GOTO COMPLETE)

:10STEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:10loopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto 10loopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOG10
IF %errorlevel% == 2 GOTO DONTVIEW10
:VIEWLOG10
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEW10
GOTO RUNSTEP10

:10STEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:10loopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto 10loopRE
GOTO RUNSTEP10

:10STEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 10STEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 10STEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 10STEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 10STEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 10STEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:10STEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEP10

:10STEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:10loopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto 10loopCC
:10loopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto 10loopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEP10

:10STEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:10loopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto 10loopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:10loopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto 10loopSBU
GOTO RUNSTEP10

:10STEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:10loopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto 10loopAD
SHUTDOWN /R
GOTO RUNSTEP10

:10STEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Disk Cleanup..........Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
cleanmgr.exe
:10loopDC
tasklist /fi "imagename eq cleanmgr.exe" |find ":" > nul
if errorlevel 1 goto 10loopDC
GOTO RUNSTEP10

:10STEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Disk Cleanup..........Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEP10

:10STEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Disk Cleanup..........Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:10loopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto 10loopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEP10

:ver_2012
REM Run Windows Server 2012 specific commands here.
REM _______________________________________________________________________________
REM                                    | Server 2012 |
REM _______________________________________________________________________________
echo Windows Server 2012 Identified 
:RUNSTEP2012
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows Server 2012
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set staging2012=%%B

    if %staging2012% == 1 (GOTO 2012STEP1)
    if %staging2012% == 2 (GOTO 2012STEP2)
    if %staging2012% == 3 (GOTO 2012STEP3)
    if %staging2012% == 4 (GOTO 2012STEP4)
    if %staging2012% == 5 (GOTO 2012STEP5)
    if %staging2012% == 6 (GOTO 2012STEP6)
    if %staging2012% == 7 (GOTO 2012STEP7)
    if %staging2012% == 8 (GOTO 2012STEP8)
    if %staging2012% == 9 (GOTO 2012STEP9)
    if %staging2012% == 10 (GOTO COMPLETE)
    if %staging2012% == 11 (GOTO COMPLETE)

:2012STEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:2012loopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto 2012loopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOG2012
IF %errorlevel% == 2 GOTO DONTVIEW2012
:VIEWLOG2012
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEW2012
GOTO RUNSTEP2012

:2012STEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:2012loopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto 2012loopRE
GOTO RUNSTEP2012

:2012STEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2012STEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2012STEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2012STEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2012STEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2012STEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:2012STEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEP2012

:2012STEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:2012loopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto 2012loopCC
:2012loopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto 2012loopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEP2012

:2012STEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:2012loopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto 2012loopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:2012loopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto 2012loopSBU
GOTO RUNSTEP2012

:2012STEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:2012loopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto 2012loopAD
SHUTDOWN /R
GOTO RUNSTEP2012

:2012STEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Disk Cleanup..........Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
cleanmgr.exe
:2012loopDC
tasklist /fi "imagename eq cleanmgr.exe" |find ":" > nul
if errorlevel 1 goto 2012loopDC
GOTO RUNSTEP2012

:2012STEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEP2012

:2012STEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:2012loopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto 2012loopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEP2012

:ver_8
REM Run Windows 8 specific commands here.
REM _______________________________________________________________________________
REM                                    | 8 |
REM _______________________________________________________________________________
echo Windows 8/8.1 Identified 
:RUNSTEP8
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows 8 and 8.1
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set staging8=%%B

    if %staging8% == 1 (GOTO 8STEP1)
    if %staging8% == 2 (GOTO 8STEP2)
    if %staging8% == 3 (GOTO 8STEP3)
    if %staging8% == 4 (GOTO 8STEP4)
    if %staging8% == 5 (GOTO 8STEP5)
    if %staging8% == 6 (GOTO 8STEP6)
    if %staging8% == 7 (GOTO 8STEP7)
    if %staging8% == 8 (GOTO 8STEP8)
    if %staging8% == 9 (GOTO 8STEP9)
    if %staging8% == 10 (GOTO COMPLETE)
    if %staging8% == 11 (GOTO COMPLETE)

:8STEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:8loopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto 8loopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOG8
IF %errorlevel% == 2 GOTO DONTVIEW8
:VIEWLOG8
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEW8
GOTO RUNSTEP8

:8STEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:8loopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto 8loopRE
GOTO RUNSTEP8

:8STEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 8STEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 8STEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 8STEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 8STEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 8STEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:8STEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEP8

:8STEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:8loopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto 8loopCC
:8loopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto 8loopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEP8

:8STEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:8loopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto 8loopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:8loopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto 8loopSBU
GOTO RUNSTEP8

:8STEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:8loopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto 8loopAD
SHUTDOWN /R
GOTO RUNSTEP8

:8STEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEP8

:8STEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEP8

:8STEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:8loopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto 8loopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEP8

:ver_7
REM Run Windows 7 specific commands here.
REM _______________________________________________________________________________
REM                                    | 7 |
REM _______________________________________________________________________________
echo Windows 7 Identified 
:RUNSTEP7
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows 7
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set staging7=%%B

    if %staging7% == 1 (GOTO 7STEP1)
    if %staging7% == 2 (GOTO 7STEP2)
    if %staging7% == 3 (GOTO 7STEP3)
    if %staging7% == 4 (GOTO 7STEP4)
    if %staging7% == 5 (GOTO 7STEP5)
    if %staging7% == 6 (GOTO 7STEP6)
    if %staging7% == 7 (GOTO 7STEP7)
    if %staging7% == 8 (GOTO 7STEP8)
    if %staging7% == 9 (GOTO 7STEP9)
    if %staging7% == 10 (GOTO COMPLETE)
    if %staging7% == 11 (GOTO COMPLETE)

:7STEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:7loopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto 7loopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOG7
IF %errorlevel% == 2 GOTO DONTVIEW7
:VIEWLOG7
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEW7
GOTO RUNSTEP7

:7STEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:7loopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto 7loopRE
GOTO RUNSTEP7

:7STEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 7STEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 7STEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 7STEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 7STEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 7STEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:7STEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEP7

:7STEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:7loopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto 7loopCC
:7loopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto 7loopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEP7

:7STEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:7loopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto 7loopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:7loopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto 7loopSBU
GOTO RUNSTEP7

:7STEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:7loopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto 7loopAD
SHUTDOWN /R
GOTO RUNSTEP7

:7STEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEP7

:7STEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEP7

:7STEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:7loopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto 7loopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEP7

:ver_2008
REM Run Windows Server 2008 specific commands here.
REM _______________________________________________________________________________
REM                               | Server 2008 |
REM _______________________________________________________________________________
echo Windows Server 2008 Identified 
:RUNSTEP2008
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows Server 2008
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set staging2008=%%B

    if %staging2008% == 1 (GOTO 2008STEP1)
    if %staging2008% == 2 (GOTO 2008STEP2)
    if %staging2008% == 3 (GOTO 2008STEP3)
    if %staging2008% == 4 (GOTO 2008STEP4)
    if %staging2008% == 5 (GOTO 2008STEP5)
    if %staging2008% == 6 (GOTO 2008STEP6)
    if %staging2008% == 7 (GOTO 2008STEP7)
    if %staging2008% == 8 (GOTO 2008STEP8)
    if %staging2008% == 9 (GOTO 2008STEP9)
    if %staging2008% == 10 (GOTO COMPLETE)
    if %staging2008% == 11 (GOTO COMPLETE)

:2008STEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:2008loopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto 2008loopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOG2008
IF %errorlevel% == 2 GOTO DONTVIEW2008
:VIEWLOG2008
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEW2008
GOTO RUNSTEP2008

:2008STEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:2008loopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto 2008loopRE
GOTO RUNSTEP2008

:2008STEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2008STEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2008STEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2008STEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2008STEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2008STEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:2008STEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEP2008

:2008STEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:2008loopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto 2008loopCC
:2008loopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto 2008loopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEP2008

:2008STEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:2008loopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto 2008loopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:2008loopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto 2008loopSBU
GOTO RUNSTEP2008

:2008STEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:2008loopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto 2008loopAD
SHUTDOWN /R
GOTO RUNSTEP2008

:2008STEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEP2008

:2008STEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEP2008

:2008STEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:2008loopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto 2008loopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEP2008

:ver_vista
REM Run Windows Vista specific commands here.
REM _______________________________________________________________________________
REM                                   | Vista |
REM _______________________________________________________________________________
echo Windows Vista Identified 
:RUNSTEPVISTA
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows Vista
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set stagingVista=%%B

    if %stagingVista% == 1 (GOTO VISTASTEP1)
    if %stagingVista% == 2 (GOTO VISTASTEP2)
    if %stagingVista% == 3 (GOTO VISTASTEP3)
    if %stagingVista% == 4 (GOTO VISTASTEP4)
    if %stagingVista% == 5 (GOTO VISTASTEP5)
    if %stagingVista% == 6 (GOTO VISTASTEP6)
    if %stagingVista% == 7 (GOTO VISTASTEP7)
    if %stagingVista% == 8 (GOTO VISTASTEP8)
    if %stagingVista% == 9 (GOTO VISTASTEP9)
    if %stagingVista% == 10 (GOTO COMPLETE)
    if %stagingVista% == 11 (GOTO COMPLETE)

:VISTASTEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:VistaloopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto VistaloopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOGVISTA
IF %errorlevel% == 2 GOTO DONTVIEWVISTA
:VIEWLOGVISTA
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEWVISTA
GOTO RUNSTEPVISTA

:VISTASTEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:VistaloopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto VistaloopRE
GOTO RUNSTEPVISTA

:VISTASTEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto VISTASTEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto VISTASTEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto VISTASTEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto VISTASTEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto VISTASTEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:VISTASTEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEPVISTA

:VISTASTEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:VistaloopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto VistaloopCC
:VistaloopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto VistaloopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEPVISTA

:VISTASTEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:VistaloopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto VistaloopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:VistaloopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto VistaloopSBU
GOTO RUNSTEPVISTA

:VISTASTEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:VistaloopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto VistaloopAD
SHUTDOWN /R
GOTO RUNSTEPVISTA

:VISTASTEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEPVISTA

:VISTASTEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEPVISTA

:VISTASTEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:VistaloopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto VistaloopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEPVISTA

:ver_2003
REM Run Windows Server 2003 specific commands here.
REM _______________________________________________________________________________
REM                               | Server 2003 |
REM _______________________________________________________________________________
echo Windows Server 2003 Identified 
:RUNSTEP2003
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows Server 2003
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set staging2003=%%B

    if %staging2003% == 1 (GOTO 2003STEP1)
    if %staging2003% == 2 (GOTO 2003STEP2)
    if %staging2003% == 3 (GOTO 2003STEP3)
    if %staging2003% == 4 (GOTO 2003STEP4)
    if %staging2003% == 5 (GOTO 2003STEP5)
    if %staging2003% == 6 (GOTO 2003STEP6)
    if %staging2003% == 7 (GOTO 2003STEP7)
    if %staging2003% == 8 (GOTO 2003STEP8)
    if %staging2003% == 9 (GOTO 2003STEP9)
    if %staging2003% == 10 (GOTO COMPLETE)
    if %staging2003% == 11 (GOTO COMPLETE)

:2003STEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:2003loopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto 2003loopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOG2003
IF %errorlevel% == 2 GOTO DONTVIEW2003
:VIEWLOG2003
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEW2003
GOTO RUNSTEP2003

:2003STEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:2003loopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto 2003loopRE
GOTO RUNSTEP2003

:2003STEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2003STEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2003STEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2003STEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2003STEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2003STEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:2003STEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEP2003

:2003STEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:2003loopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto 2003loopCC
:2003loopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto 2003loopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEP2003

:2003STEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:2003loopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto 2003loopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:2003loopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto 2003loopSBU
GOTO RUNSTEP2003

:2003STEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:2003loopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto 2003loopAD
SHUTDOWN /R
GOTO RUNSTEP2003

:2003STEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEP2003

:2003STEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEP2003

:2003STEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:2003loopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto 2003loopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEP2003

:ver_xp
REM Run Windows XP specific commands here.
REM _______________________________________________________________________________
REM                                    | XP |
REM _______________________________________________________________________________
echo Windows XP Identified 
:RUNSTEPXP
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows XP
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set stagingXP=%%B

    if %stagingXP% == 1 (GOTO XPSTEP1)
    if %stagingXP% == 2 (GOTO XPSTEP2)
    if %stagingXP% == 3 (GOTO XPSTEP3)
    if %stagingXP% == 4 (GOTO XPSTEP4)
    if %stagingXP% == 5 (GOTO XPSTEP5)
    if %stagingXP% == 6 (GOTO XPSTEP6)
    if %stagingXP% == 7 (GOTO XPSTEP7)
    if %stagingXP% == 8 (GOTO XPSTEP8)
    if %stagingXP% == 9 (GOTO XPSTEP9)
    if %stagingXP% == 10 (GOTO COMPLETE)
    if %stagingXP% == 11 (GOTO COMPLETE)

:XPSTEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:XPloopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto XPloopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOGXP
IF %errorlevel% == 2 GOTO DONTVIEWXP
:VIEWLOGXP
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEWXP
GOTO RUNSTEPXP

:XPSTEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:XPloopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto XPloopRE
GOTO RUNSTEPXP

:XPSTEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto XPSTEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto XPSTEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto XPSTEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto XPSTEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto XPSTEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:XPSTEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEPXP

:XPSTEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:XPloopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto XPloopCC
:XPloopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto XPloopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEPXP

:XPSTEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:XPloopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto XPloopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:XPloopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto XPloopSBU
GOTO RUNSTEPXP

:XPSTEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:XPloopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto XPloopAD
SHUTDOWN /R
GOTO RUNSTEPXP

:XPSTEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEPXP

:XPSTEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEPXP

:XPSTEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:XPloopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto XPloopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEPXP

:ver_2000
REM Run Windows 2000 specific commands here.
REM _______________________________________________________________________________
REM                                    | 2000 |
REM _______________________________________________________________________________
echo Windows 2000 Identified 
:RUNSTEP2000
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows 2000
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set staging2000=%%B

    if %staging2000% == 1 (GOTO 2000STEP1)
    if %staging2000% == 2 (GOTO 2000STEP2)
    if %staging2000% == 3 (GOTO 2000STEP3)
    if %staging2000% == 4 (GOTO 2000STEP4)
    if %staging2000% == 5 (GOTO 2000STEP5)
    if %staging2000% == 6 (GOTO 2000STEP6)
    if %staging2000% == 7 (GOTO 2000STEP7)
    if %staging2000% == 8 (GOTO 2000STEP8)
    if %staging2000% == 9 (GOTO 2000STEP9)
    if %staging2000% == 10 (GOTO COMPLETE)
    if %staging2000% == 11 (GOTO COMPLETE)

:2000STEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:2000loopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto 2000loopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOG2000
IF %errorlevel% == 2 GOTO DONTVIEW2000
:VIEWLOG2000
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEW2000
GOTO RUNSTEP2000

:2000STEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:2000loopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto 2000loopRE
GOTO RUNSTEP2000

:2000STEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2000STEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2000STEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2000STEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto 2000STEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto 2000STEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s act2000rxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:2000STEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEP2000

:2000STEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:2000loopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto 2000loopCC
:2000loopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto 2000loopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEP2000

:2000STEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:2000loopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto 2000loopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:2000loopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto 2000loopSBU
GOTO RUNSTEP2000

:2000STEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:2000loopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto 2000loopAD
SHUTDOWN /R
GOTO RUNSTEP2000

:2000STEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEP2000

:2000STEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEP2000

:2000STEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:2000loopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto 2000loopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEP2000

:ver_nt
REM Run Windows NT specific commands here.
REM _______________________________________________________________________________
REM                                    | NT |
REM _______________________________________________________________________________
echo Windows NT Identified 
:RUNSTEPNT
CLS
ECHO                     .                                     
ECHO                 ;   G                                     
ECHO                 ;KtGG                                     
ECHO              ,;,,ELjj                                     
ECHO               ,fED.jLi,                                   
ECHO                 jG.LfLjf                                  
ECHO                jftDt tLjf                                 
ECHO                   E;  .Lff                                
ECHO                   ;    GjLjGG                             
ECHO                      iD, .;f#GLft;                        
ECHO                      jWLK##########Dt                     
ECHO                      L###############Wj                   
ECHO                    iK##################E,                 
ECHO         tGDDf,    j#####################W,                
ECHO       .Di .tKW;  t#######################K.               
ECHO       L,iGGi.WE .W###############ELK######G               
ECHO       G G  D L#.f###############G  .W##j;W#,              
ECHO       iLiftG j#;K###############,   j#W  L#j              
ECHO        tf.,  j#L###############W    ;#E  j#G              
ECHO         D    f#################K    ,#E  f#G              
ECHO         D    j#G################    i##. D#L              
ECHO        ;f ;i .WKD###############j   D##EL##t              
ECHO        G jjiD L#L###############Wt,L######W               
ECHO        D L. D j#;E########################j,fDDDL;        
ECHO        jt.LLt DK .W######################DjEi   ,Dj       
ECHO         tLi,iDD,  ,K#####################Kf      ;E       
ECHO           ,i;.   ;iL#####################f     .fD;       
ECHO                 GGtfW#W#############WW##L    ,LEi         
ECHO                 W,  .DL;jDW######KGt .WG   ;DEt           
ECHO                 Df    LG    ,,,,      W  tEEt             
ECHO                 tK     GL             LDDL;               
ECHO                  W;     E;                                
ECHO                  LL     jf                                
ECHO                  ,W;    Gj                                
ECHO                   ,GDDEKj                                 
ECHO :
ECHO :
ECHO AV 3.3 Auto-Clean for Windows NT
ECHO :
ECHO :
Set Reg.Key=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean
Set Reg.Val=Step
For /F "Tokens=2*" %%A In ('Reg Query "%Reg.Key%" /v "%Reg.Val%" ^| Find /I "%Reg.Val%"' ) Do Call Set stagingNT=%%B

    if %stagingNT% == 1 (GOTO NTSTEP1)
    if %stagingNT% == 2 (GOTO NTSTEP2)
    if %stagingNT% == 3 (GOTO NTSTEP3)
    if %stagingNT% == 4 (GOTO NTSTEP4)
    if %stagingNT% == 5 (GOTO NTSTEP5)
    if %stagingNT% == 6 (GOTO NTSTEP6)
    if %stagingNT% == 7 (GOTO NTSTEP7)
    if %stagingNT% == 8 (GOTO NTSTEP8)
    if %stagingNT% == 9 (GOTO NTSTEP9)
    if %stagingNT% == 10 (GOTO COMPLETE)
    if %stagingNT% == 11 (GOTO COMPLETE)

:NTSTEP1
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "2" /f
HD\HD.exe /disk:0 /function:health /start /quit /log:HD\Health.txt
HD\HD.exe /disk:0 /function:errorscan /start /quit /log:HD\ErrorSc.txt
:NTloopHD
tasklist /fi "imagename eq HD.exe" |find ":" > nul
if errorlevel 1 goto NTloopHD
ECHO.
CHOICE /M "Would you like to view the log? : "
IF %errorlevel% == 1 GOTO VIEWLOGNT
IF %errorlevel% == 2 GOTO DONTVIEWNT
:VIEWLOGNT
CLS
TYPE HD\ErrorSc.txt
ECHO.
TYPE HD\Health.txt
ECHO.
PAUSE
:DONTVIEWNT
GOTO RUNSTEPNT

:NTSTEP2
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "3" /f
RE\RE.exe
:NTloopRE
tasklist /fi "imagename eq RE.exe" |find ":" > nul
if errorlevel 1 goto NTloopRE
GOTO RUNSTEPNT

:NTSTEP3
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "4" /f
CLS
REM  -----------------------------
REM  ----ALL TEMP FILE CLEANUP----
REM  -----------------------------
REM Insert Temp Cleanup Commands Here
REM -----------------------------
REM ----WINDOWS UPDATE CLEANUP---
REM -----------------------------
echo 1. Stopping Windows Update, BITS, Application Identity, Cryptographic Services and SMS Host Agent services... 
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 
echo 2. Checking if services were stopped successfully... 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto NTSTEP3.5 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto NTSTEP3.5 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto NTSTEP3.5 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto NTSTEP3.5 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto NTSTEP3.5 
 
@echo 3. Deleting AU cache folder and log file...  
del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
@echo 4. Re-registering DLL files... 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actNTrxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 
 
@echo 5. Resetting Winsock and WinHTTP Proxy... 
netsh winsock reset 
netsh winhttp reset proxy 
 
@echo 6. Starting SMS Host Agent, Cryptographic Services, Application Identity, BITS, Windows Update services... 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 
 
@echo 7. Deleting all BITS jobs... 
bitsadmin.exe /reset /allusers 
 
@echo 8. Forcing AU discovery... 
wuauclt /resetauthorization /detectnow 
 
:NTSTEP3.5 
ECHO .
ECHO Windows Update Cache Reset!!!
PAUSE
GOTO RUNSTEPNT

:NTSTEP4
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "5" /f
CC\ccsetup.exe /S
C:\Progra~1\CCleaner\CCleaner.exe
:NTloopCC
tasklist /fi "imagename eq CCleaner.exe" |find ":" > nul
if errorlevel 1 goto NTloopCC
:NTloopCC64
tasklist /fi "imagename eq CCleaner64.exe" |find ":" > nul
if errorlevel 1 goto NTloopCC64
DEL %Public%\Desktop\CCleaner.lnk
GOTO RUNSTEPNT

:NTSTEP5
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "6" /f
SB\SB.exe /verysilent
IF EXIST C:\Progra~1\spybot~1\spybotsd.exe C:\Progra~1\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
IF EXIST C:\Progra~2\spybot~1\spybotsd.exe C:\Progra~2\spybot~1\spybotsd.exe /verbose /autoclose /autocheck /autofix
:NTloopSB
tasklist /fi "imagename eq spybotsd.exe" |find ":" > nul
if errorlevel 1 goto NTloopSB
IF EXIST C:\Progra~1\spybot~1\unins000.exe C:\Progra~1\spybot~1\unins000.exe /verysilent
IF EXIST C:\Progra~2\spybot~1\unins000.exe C:\Progra~2\spybot~1\unins000.exe /verysilent
:NTloopSBU
tasklist /fi "imagename eq unins000.exe" |find ":" > nul
if errorlevel 1 goto NTloopSBU
GOTO RUNSTEPNT

:NTSTEP6
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "7" /f
AD\AD.EXE
:NTloopAD
tasklist /fi "imagename eq AD.exe" |find ":" > nul
if errorlevel 1 goto NTloopAD
SHUTDOWN /R
GOTO RUNSTEPNT

:NTSTEP7
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "8" /f
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "AutoClean" /t REG_SZ /d "C:\AV3.3\AUTOCLEAN.EXE" /f
CF\CF.exe
PAUSE
ECHO Rebooting...
SHUTDOWN /R
GOTO RUNSTEPNT

:NTSTEP8
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "9" /f
MA\MA.exe /verysilent
IF EXIST C:\Progra~1\malwar~1\mbam.exe start C:\Progra~1\malwar~1\mbam.exe
IF EXIST C:\Progra~2\malwar~1\mbam.exe start C:\Progra~2\malwar~1\mbam.exe
GOTO RUNSTEPNT

:NTSTEP9
CD\AV3.3
ECHO Getting Ready to check HD...............Step 1 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Revo..................Step 2 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Junk File Cleanup.....Step 3 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for CCleaner..............Step 4 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Spybot................Step 5 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for ADW Cleaner...........Step 6 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Combofix..............Step 7 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Malwarebytes..........Step 8 of 9
ECHO Press any key to continue . . .
ECHO Getting Ready for Eset Security Scan....Step 9 of 9
PAUSE
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "10" /f
ES\ES.exe
:NTloopES
tasklist /fi "imagename eq ES.exe" |find ":" > nul
if errorlevel 1 goto NTloopES
REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /v "Step" /t REG_SZ /d "11" /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
GOTO RUNSTEPNT

:warn
echo Windows Version Unknown
echo :
echo To prevent system damage the cleaning will halt.
echo : 


:COMPLETE
CLS
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /va /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Autoclean /va /f
ECHO.
ECHO AutoClean Process will now close...
ECHO.
ECHO.
PAUSE
EXIT

:BACKUP
CLS
ECHO Full System Backup Initializing..
ECHO.
ECHO.
ECHO.
FOR /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
SET ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%
SET /P "backupdest=Please enter the destination of the backup.......(e.g. d: -- \\rackstation) : "
SET /P "name=Please Name this Backup.................................(Usually Last Name) : "
ECHO.
ECHO.
ECHO Retrieving and backing up Product Key(s)..
INFO\GetKey.exe /s raw.txt
FINDSTR /i /c:"Micro" /c:"Comp" /c:"Owne" /c:"PID:" /c:"Key:" INFO\raw.txt >INFO\keyinfo.txt
XCOPY INFO\keyinfo.txt %backupdest%\%name%-%ldt%\ /C /Y /Z /Q
ECHO.
ECHO Retrieving and Backing up Outlook PST files (from default locations)
ECHO.
IF EXIST %userprofile%\AppData\Local\Microsoft\Outlook XCOPY %userprofile%\AppData\Local\Microsoft\Outlook\*.pst %backupdest%\%name%-%ldt%\Outlook-PST\ /E /C /H /Y /Z
IF EXIST %userprofile%\Documents\Outloo~1\ XCOPY %userprofile%\Documents\Outloo~1\*.pst %backupdest%\%name%-%ldt%\Outlook-PST\ /E /C /H /Y /Z
ECHO.
ECHO Backing up the Registry..
REG EXPORT hkey_local_machine\software\microsoft\windows INFO\HKLMregbackup_%ldt%.reg /Y
REG EXPORT hkey_current_user\software\microsoft\windows INFO\HKCUregbackup_%ldt%.reg /Y
XCOPY INFO\HKLMregbackup_%ldt%.reg %backupdest%\%name%-%ldt%\ /C /Y /Z /Q
XCOPY INFO\HKCUregbackup_%ldt%.reg %backupdest%\%name%-%ldt%\ /C /Y /Z /Q
ECHO.
ECHO Backing up User Data. This may take a while..
IF EXIST C:\Users XCOPY C:\Users %backupdest%\%name%-%ldt%\Users\ /E /C /H /Y /Z
ECHO Backup Complete..
ECHO.
PAUSE
GOTO OPTIONS