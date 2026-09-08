@echo off
chcp 65001 > nul
title Eski Dosya Arşivleyici (30+ Gün)

echo.
echo ============================================================
echo   ESKİ DOSYA ARŞİVLEME İŞLEMİ BAŞLATILIYOR...
echo ============================================================
echo.

:: Hedef Klasör ve Arşivlenecek Gün Sayısı
set "TARGET_DIR=%USERPROFILE%\Desktop"
set "DAYS=30"

:: Bugünün Tarihi ile Arşiv Klasörü Adı Oluştur (Örn: Arsiv_2026-09-08)
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set "dt=%%i"
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "ARCHIVE_DIR=%TARGET_DIR%\Arsiv_%YYYY%-%MM%-%DD%"

echo Target Directory: %TARGET_DIR%
echo Gün Sınırı: %DAYS% günden eski dosyalar
echo.

:: PowerShell yardımıyla 30 günden eski dosyaları güvenle tespit edip taşıma
powershell -Command ^
    "$target = '%TARGET_DIR%';" ^
    "$archive = '%ARCHIVE_DIR%';" ^
    "$days = %DAYS%;" ^
    "$limit = (Get-Date).AddDays(-$days);" ^
    "$files = Get-ChildItem -Path $target -File | Where-Object { $_.LastWriteTime -lt $limit -and $_.Name -notlike '*.bat' };" ^
    "if ($files.Count -gt 0) { " ^
    "   if (!(Test-Path $archive)) { New-Item -ItemType Directory -Path $archive | Out-Null }; " ^
    "   foreach ($f in $files) { " ^
    "       Move-Item -Path $f.FullName -Destination $archive -Force; " ^
    "       Write-Host "✔ Taşındı: $($f.Name)" -ForegroundColor Green; " ^
    "   } " ^
    "} else { " ^
    "   Write-Host 'Arşivlenecek eski dosya bulunamadı.' -ForegroundColor Yellow; " ^
    "}"

echo.
echo ============================================================
echo   ARŞİVLEME BAŞARIYLA TAMAMLANDI!
echo ============================================================
echo.
timeout /t 4
exit