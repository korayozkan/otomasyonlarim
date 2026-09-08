@echo off
chcp 65001 > nul
title Boş Klasör Temizleyici

echo.
echo ============================================================
echo   BOŞ KLASÖR TEMİZLEME İŞLEMİ BAŞLATILIYOR...
echo ============================================================
echo.

:: Temizlenecek Ana Dizin (Varsayılan: Masaüstü)
set "TARGET_DIR=%USERPROFILE%\Desktop"

echo Taranan Dizin: %TARGET_DIR%
echo.

:: PowerShell ile derinlemesine boş klasör taraması ve temizliği
powershell -Command ^
    "$target = '%TARGET_DIR%';" ^
    "function Remove-EmptyFolders($path) { " ^
    "   $dirs = Get-ChildItem -Path $path -Directory; " ^
    "   foreach ($d in $dirs) { " ^
    "       Remove-EmptyFolders($d.FullName); " ^
    "       $items = Get-ChildItem -Path $d.FullName; " ^
    "       if ($items.Count -eq 0) { " ^
    "           Remove-Item -Path $d.FullName -Force; " ^
    "           Write-Host "✔ Silindi (Boş Klasör): $($d.Name)" -ForegroundColor Red; " ^
    "       } " ^
    "   } " ^
    "}; " ^
    "Remove-EmptyFolders($target);"

echo.
echo ============================================================
echo   TEMİZLİK BAŞARIYLA TAMAMLANDI!
echo ============================================================
echo.
timeout /t 4
exit