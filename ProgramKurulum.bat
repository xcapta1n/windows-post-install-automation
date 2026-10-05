@echo off
title Program Kurulum Scripti (Secimli)
color 0A

:: Yonetici Haklari Kontrolu ve Oto-Yukseltme
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Yonetici haklari aliniyor, lutfen bekleyin...
    powershell -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

echo ====================================================
echo    Adim Adim Secimli Program Kurulum Scripti
echo ====================================================
echo.

:: ==========================================
:: 0. WINGET KONTROLU VE YENIDEN BASLATMA
:: ==========================================
echo [0/5] Winget kontrol ediliyor...
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo Winget bulunamadi! Microsoft App Installer altyapisi yukleniyor...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe" >nul 2>&1
    
    echo.
    echo ===================================================================
    echo  [!] Winget sisteme entegre edildi. 
    echo  [!] Servislerin ve PATH yollarinin oturmasi icin sistem YENIDEN BASLATILACAK!
    echo  [!] Yeniden baslatma sonrasinda scripti tekrar calistirin.
    echo ===================================================================
    echo.
    echo Bilgisayar 10 saniye icinde yeniden baslatiliyor...
    shutdown /r /t 10 /f /c "Winget kurulumu tamamlandi. Sistem yeniden baslatiliyor..."
    pause
    exit /b
) else (
    echo Winget zaten kurulu ve aktif, kurulumlara geciliyor.
)
echo.

:: ==========================================
:: 1. INTERNET, ILETISIM VE MEDYA
:: ==========================================
echo --- 1. INTERNET, ILETISIM VE MEDYA ---
call :InstallApp "Brave Browser" "Brave.Brave" ""
call :InstallApp "Discord" "Discord.Discord" ""
call :InstallWebExe "Spotify" "https://download.scdn.co/SpotifySetup.exe" "SpotifySetup.exe"
call :InstallApp "Microsoft Filmler ve TV" "9WZDNCRFJ3P2" "--source msstore"
call :InstallApp "Microsoft Fotograflar" "9WZDNCRFJBH4" "--source msstore"
call :InstallApp "Windows Hesap Makinesi" "9wzdncrfhvn5" "--source msstore"
call :InstallApp "Speedtest" "9nblggh4z1jc" "--source msstore"

:: ==========================================
:: 2. OYUN BASLATICILARI (LAUNCHER)
:: ==========================================
echo --- 2. OYUN BASLATICILARI (LAUNCHER) ---
call :InstallApp "Steam" "Valve.Steam" ""
call :InstallApp "Epic Games Launcher" "EpicGames.EpicGamesLauncher" ""
call :InstallWebExe "FiveM - GTA V Multiplayer" "https://runtime.fivem.net/client/FiveM.exe" "FiveM.exe"

:: ==========================================
:: 3. SISTEM, ARSIV VE PERFORMANS ARACLARI
:: ==========================================
echo --- 3. SISTEM, ARSIV VE PERFORMANS ARACLARI ---
call :InstallApp "7-Zip" "7zip.7zip" ""
call :InstallApp "Revo Uninstaller" "RevoUninstaller.RevoUninstaller" ""
call :InstallApp "TreeSize Free" "JAMSoftware.TreeSize.Free" ""
call :InstallApp "PDFgear" "PDFgear.PDFgear" ""
call :InstallWebZip "MSI Afterburner" "https://download.msi.com/uti_exe/vga/MSIAfterburnerSetup.zip" "MSIAfterburnerSetup.zip"
call :InstallApp "Process Lasso" "BitSum.ProcessLasso" ""

:: ==========================================
:: 4. ESSENTIAL (HAYAT KURTARAN) ARACLAR
:: ==========================================
echo --- 4. ESSENTIAL (HAYAT KURTARAN) ARACLAR ---
call :InstallApp "Everything" "voidtools.Everything" ""
call :InstallApp "Notepad++" "Notepad++.Notepad++" ""

:: ==========================================
:: 5. OYUN KUTUPHANELERI VE RUNTIME (EKSIKSIZ)
:: ==========================================
echo --- 5. OYUN KUTUPHANELERI VE RUNTIME (EKSIKSIZ) ---
call :InstallApp "Microsoft DirectX" "Microsoft.DirectX" ""
call :InstallApp "Visual C++ 2015+ x64" "Microsoft.VCRedist.2015+.x64" ""
call :InstallApp "Visual C++ 2015+ x86" "Microsoft.VCRedist.2015+.x86" ""

echo.
echo ====================================================
echo    TUM PROGRAMLARIN KURULUMU TAMAMLANDI!
echo ====================================================
echo.
pause
exit /b

:: ==========================================
:: WINGET KURULUM FONKSIYONU
:: ==========================================
:InstallApp
setlocal
set "appName=%~1"
set "appId=%~2"
set "extraArgs=%~3"

choice /C YN /M "%appName% kurulsun mu?"
if errorlevel 2 (
    echo [-] %appName% atlandi.
    echo.
    endlocal
    exit /b
)
if errorlevel 1 (
    echo [+] %appName% kuruluyor, lutfen bekleyin...
    winget install --id "%appId%" -e %extraArgs% --accept-package-agreements --accept-source-agreements
    color 0A
    echo [OK] Kurulum bitti.
    echo.
    endlocal
    exit /b
)

:: ==========================================
:: DIREKT WEB'DEN EXE KURULUM FONKSIYONU
:: ==========================================
:InstallWebExe
setlocal
set "appName=%~1"
set "url=%~2"
set "exeName=%~3"

choice /C YN /M "%appName% kurulsun mu?"
if errorlevel 2 (
    echo [-] %appName% atlandi.
    echo.
    endlocal
    exit /b
)
if errorlevel 1 (
    echo [+] %appName% internetten indiriliyor, lutfen bekleyin...
    curl -L -o "%TEMP%\%exeName%" "%url%" >nul 2>&1
    
    if /I "%exeName%"=="SpotifySetup.exe" (
        explorer.exe "%TEMP%\%exeName%"
    ) else (
        start "" "%TEMP%\%exeName%"
    )
    
    color 0A
    echo [OK] %appName% kurulum penceresi acildi - Lutfen kurulumu tamamlayin.
    echo.
    endlocal
    exit /b
)
:: ==========================================
:: DIREKT WEB'DEN ZIP KURULUM FONKSIYONU
:: ==========================================
:InstallWebZip
setlocal
set "appName=%~1"
set "url=%~2"
set "zipName=%~3"

choice /C YN /M "%appName% kurulsun mu?"
if errorlevel 2 (
    echo [-] %appName% atlandi.
    echo.
    endlocal
    exit /b
)
if errorlevel 1 (
    echo [+] %appName% indiriliyor...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '$env:TEMP\%zipName%')" >nul 2>&1
    
    echo [+] Zip dosyasi cikariliyor...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Path '$env:TEMP\%zipName%' -DestinationPath '$env:TEMP\setup_extracted' -Force" >nul 2>&1
    
    echo [+] Kurulum baslatiliyor...
    for /r "%TEMP%\setup_extracted" %%f in (*.exe) do (
        start /wait "" "%%f" /S
    )
    
    :: Temizlik
    rmdir /s /q "%TEMP%\setup_extracted" >nul 2>&1
    del /q "%TEMP\%zipName%" >nul 2>&1
    
    color 0A
    echo [OK] %appName% kurulumu tamamlandi.
    echo.
    endlocal
    exit /b
)