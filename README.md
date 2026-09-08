#  Günlük Otomasyonlarım

Kendi dijital iş akışlarımı ve bilgisayar kullanımımı kolaylaştırmak için geliştirdiğim, tamamen saf Windows Batch (`.bat`) ile çalışan mikro otomasyon koleksiyonu.

---

###  Neden Böyle Bir Şey Yaptım?

Piyasada bu işleri yapan yüzlerce uygulama var. Ancak çoğu:
* Arka planda gereksiz kaynak harcayan karmaşık yapıda,
* Ücretli veya abonelik sistemi gerektiriyor,
* Hiç kullanmayacağım yüzlerce gereksiz özellikle dolu.

Bunun yerine yapay zekayı bir asistan olarak kullanıp, kendi ihtiyacıma özel (terzi usulü) çözümler üretmeyi tercih ettim. 5-10 dakikalık bir geliştirme ile tam olarak istediğim şeyi yapan, reklamsız, şişkinliksiz ve hafif scriptler ortaya çıktı.

---

###  İçerikteki Otomasyonlar

* **Sistem Temizleyici (`temizlik.bat`):** Temp, Prefetch, Log ve Geri Dönüşüm Kutusu gibi sistemde biriken gereksiz dosyaları güvenle siler.
* **Masaüstü Düzenleyici (`MasaustuDuzenle.bat`):** Masaüstündeki karmaşayı önlemek için dosyaları uzantılarına göre (Görseller, Belgeler, Arşivler vb.) otomatik klasörler.
 * **Eski Dosya Arşivleyici (`EskiDosyalarıArsivle.bat`):** 30 günden eski dosyaları tespit ederek tarih damgalı bir arşiv klasörüne taşır.


---

###  Nasıl Kullanılır?

#### Manuel Kullanım
1. Projeyi **ZIP** olarak indirin ve bir klasöre çıkarın.
2. Çalıştırmak istediğiniz `.bat` dosyasına çift tıklayın. (Bazı sistem temizlik betikleri için sağ tıklayıp *Yönetici olarak çalıştır* demeniz gerekebilir.)

#### Otomatik Kullanım (Görev Zamanlayıcısı)
Her defasında elle çalıştırmakla uğraşmamak için bu betikleri Windows üzerinde otomatiğe bağlayabilirsiniz:

1. `Win + R` tuşlarına basın, açılan pencereye `taskschd.msc` yazıp **Enter**'a basarak **Görev Zamanlayıcısı**'nı açın.
2. Sağ taraftaki menüden **Temel Görev Oluştur...** seçeneğine tıklayın.
3. Göreve bir isim verin ve çalıştırmak istediğiniz zaman aralığını seçin *(Örn: Her Pazar saat 12:00)*.
4. Eylem olarak **Program Başlat** seçeneğini işaretleyin ve çalıştırmak istediğiniz `.bat` dosyasını seçip kaydedin.
5. *(İsteğe bağlı)* Görevin sorunsuz çalışması için son ekranda *"En yüksek ayrıcalıklarla çalıştır"* seçeneğini işaretlemeyi unutmayın.
