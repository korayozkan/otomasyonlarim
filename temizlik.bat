@echo off
chcp 65001 > nul
title Windows Otomatik Sistem Temizleyici

:: Yönetici Yetkisi Kontrolü
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ============================================================
    echo  UYARI: Bu scriptin tam temizlik yapabilmesi için
    echo  YÖNETİCİ OLARAK çalıştırılması gerekmektedir!
    echo ============================================================
    echo.
    echo Lütfen dosyaya sağ tıklayıp "Yönetici olarak çalıştır" deyin.
    echo.
    pause
    exit /b
)

echo.
echo ============================================================
echo   WINDOWS TEMİZLİK BATIŞI BAŞLATILIYOR...
echo ============================================================
echo.

:: 1. Kullanıcı Temp Klasörü Temizliği
echo [1/6] Kullanıcı Geçici (Temp) Dosyaları Temizleniyor...
del /q /f /s "%temp%\*" >nul 2>&1
for /d %%x in ("%temp%\*") do rmdir /s /q "%%x" >nul 2>&1

:: 2. Windows Sistem Temp Klasörü Temizliği
echo [2/6] Sistem Temp Dosyaları Temizleniyor...
del /q /f /s "%systemroot%\Temp\*" >nul 2>&1
for /d %%x in ("%systemroot%\Temp\*") do rmdir /s /q "%%x" >nul 2>&1

:: 3. Prefetch Klasörü Temizliği (Ön Yükleme Verileri)
echo [3/6] Prefetch Önbelleği Temizleniyor...
del /q /f /s "%systemroot%\Prefetch\*" >nul 2>&1

:: 4. Windows Update İndirme Önbelleği Temizliği
echo [4/6] Windows Update İndirme Önbelleği Temizleniyor...
net stop wuauserv >nul 2>&1
del /q /f /s "%systemroot%\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1

:: 5. Sistem Log Dosyaları Temizliği
echo [5/6] Sistem Log Dosyaları Temizleniyor...
del /q /f /s "%systemroot%\*.log" >nul 2>&1

:: 6. Geri Dönüşüm Kutusu Temizliği
echo [6/6] Geri Dönüşüm Kutusu Boşaltılıyor...
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1

echo.
echo ============================================================
echo   TEMİZLİK BAŞARIYLA TAMAMLANDI!
echo ============================================================
echo.
timeout /t 5
exit