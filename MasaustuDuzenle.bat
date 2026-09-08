@echo off
chcp 65001 > nul
title Masaüstü Otomatik Düzenleyici

echo.
echo ============================================================
echo   MASAÜSTÜ DÜZENLEME İŞLEMİ BAŞLATILIYOR...
echo ============================================================
echo.

set "DESKTOP=%USERPROFILE%\Desktop"

:: Hedef Klasörleri Oluştur
if not exist "%DESKTOP%\Görseller" mkdir "%DESKTOP%\Görseller"
if not exist "%DESKTOP%\Belgeler" mkdir "%DESKTOP%\Belgeler"
if not exist "%DESKTOP%\Arşivler" mkdir "%DESKTOP%\Arşivler"
if not exist "%DESKTOP%\Kurulumlar" mkdir "%DESKTOP%\Kurulumlar"
if not exist "%DESKTOP%\Kodlar ve Scriptler" mkdir "%DESKTOP%\Kodlar ve Scriptler"
if not exist "%DESKTOP%\Medya" mkdir "%DESKTOP%\Medya"
if not exist "%DESKTOP%\Diğer" mkdir "%DESKTOP%\Diğer"

cd /d "%DESKTOP%"

:: 1. GÖRSELLER (.jpg, .jpeg, .png, .gif, .bmp, .webp, .svg, .ico)
echo [1/6] Görseller taşınıyor...
for %%e in (jpg jpeg png gif bmp webp svg ico) do (
    for %%f in (*.%%e) do (
        if exist "%%f" move "%%f" "%DESKTOP%\Görseller\" >nul 2>&1
    )
)

:: 2. BELGELER (.pdf, .docx, .doc, .txt, .xlsx, .pptx, .csv)
echo [2/6] Belgeler taşınıyor...
for %%e in (pdf docx doc txt xlsx pptx csv) do (
    for %%f in (*.%%e) do (
        if exist "%%f" move "%%f" "%DESKTOP%\Belgeler\" >nul 2>&1
    )
)

:: 3. ARŞİVLER (.zip, .rar, .7z, .tar, .gz)
echo [3/6] Arşiv dosyaları taşınıyor...
for %%e in (zip rar 7z tar gz) do (
    for %%f in (*.%%e) do (
        if exist "%%f" move "%%f" "%DESKTOP%\Arşivler\" >nul 2>&1
    )
)

:: 4. KURULUMLAR (.exe, .msi, .iso)
echo [4/6] Kurulum dosyaları taşınıyor...
for %%e in (msi iso) do (
    for %%f in (*.%%e) do (
        if exist "%%f" move "%%f" "%DESKTOP%\Kurulumlar\" >nul 2>&1
    )
)
:: .exe dosyalarını taşırken bu .bat dosyasının veya kısayolların etkilenmemesi için
for %%f in (*.exe) do (
    if exist "%%f" move "%%f" "%DESKTOP%\Kurulumlar\" >nul 2>&1
)

:: 5. KODLAR VE SCRİPTLER (.html, .css, .js, .json, .py, .cpp, .cs, .c, .sh)
echo [5/6] Kod ve Script dosyaları taşınıyor...
for %%e in (html css js json py cpp cs c sh) do (
    for %%f in (*.%%e) do (
        if exist "%%f" move "%%f" "%DESKTOP%\Kodlar ve Scriptler\" >nul 2>&1
    )
)

:: 6. MEDYA (.mp3, .wav, .mp4, .mkv, .avi, .mov)
echo [6/6] Medya dosyaları taşınıyor...
for %%e in (mp3 wav mp4 mkv avi mov) do (
    for %%f in (*.%%e) do (
        if exist "%%f" move "%%f" "%DESKTOP%\Medya\" >nul 2>&1
    )
)

:: Boş kalan kategorileri temizle (İçinde dosya yoksa siler)
for %%d in ("Görseller" "Belgeler" "Arşivler" "Kurulumlar" "Kodlar ve Scriptler" "Medya" "Diğer") do (
    rmdir "%DESKTOP%\%%~d" >nul 2>&1
)

echo.
echo ============================================================
echo   MASAÜSTÜ BAŞARIYLA DÜZENLENDİ!
echo ============================================================
echo.
timeout /t 3
exit