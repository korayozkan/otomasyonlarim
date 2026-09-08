@echo off
chcp 65001 > nul
title En Hızlı DNS Otomatik Ayarlayıcı

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] HATA: DNS değiştirebilmek için bu dosyaya SAĞ TIKLAYIP "Yönetici Olarak Çalıştır" demelisiniz!
    echo.
    pause
    exit /b
)

echo.
echo ============================================================
echo   EN HIZLI DNS SUNUCUSU TESPİT EDİLİYOR VE AYARLANIYOR...
echo ============================================================
echo.

:: PowerShell ile ping testleri yapıp en düşüğünü seçme ve uygulama
powershell -Command ^
    "$dnsList = @(" ^
    "   @{ Name='Cloudflare'; Primary='1.1.1.1'; Secondary='1.0.0.1' }," ^
    "   @{ Name='Google';     Primary='8.8.8.8'; Secondary='8.8.4.4' }," ^
    "   @{ Name='Quad9';      Primary='9.9.9.9'; Secondary='149.112.112.112' }," ^
    "   @{ Name='OpenDNS';    Primary='208.67.222.222'; Secondary='208.67.220.220' }," ^
    "   @{ Name='AdGuard';    Primary='94.140.14.14'; Secondary='94.140.15.15' }" ^
    ");" ^
    "$bestDns = $null; $bestPing = 9999;" ^
    "foreach ($d in $dnsList) { " ^
    "   $ping = (Test-Connection -ComputerName $d.Primary -Count 2 -ErrorAction SilentlyContinue | Measure-Object -Property ResponseTime -Average).Average;" ^
    "   if ($ping -and $ping -lt $bestPing) { " ^
    "       $bestPing = [math]::Round($ping, 1); $bestDns = $d; " ^
    "   }" ^
    "   if ($ping) { Write-Host "   $($d.Name) Ping: $ping ms" -ForegroundColor Gray } " ^
    "   else { Write-Host "   $($d.Name) Erişilemedi" -ForegroundColor Red }" ^
    "}; " ^
    "if ($bestDns) { " ^
    "   Write-Host "`n✔ En Hızlı DNS Bulundu: $($bestDns.Name) ($bestPing ms)" -ForegroundColor Green; " ^
    "   $adapter = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.HardwareInterface -eq $true } | Select-Object -First 1;" ^
    "   if ($adapter) { " ^
    "       Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses ($bestDns.Primary, $bestDns.Secondary);" ^
    "       Write-Host "✔ DNS başarıyla $($adapter.Name) bağdaştırıcısına uygulandı!" -ForegroundColor Yellow;" ^
    "   } else { Write-Host '   Aktif ağ bağdaştırıcısı bulunamadı.' -ForegroundColor Red }" ^
    "} else { Write-Host '   Hiçbir DNS sunucusuna ulaşılamadı.' -ForegroundColor Red }"

echo.
echo ============================================================
echo   İŞLEM TAMAMLANDI!
echo ============================================================
echo.
timeout /t 5
exit