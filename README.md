# Flutter E-Ticaret Uygulaması

## Proje Hakkında
Bu proje, Flutter çerçevesi kullanılarak geliştirilmiş, yüksek performanslı ve modern bir e-ticaret uygulamasıdır. Durum yönetimi (state management) olarak GetX mimarisi benimsenmiş olup, arka uç (backend) hizmetleri ve veri yönetimi için Firebase altyapısı entegre edilmiştir. Uygulama, kullanıcı deneyimini en üst düzeye çıkarmak amacıyla çeşitli görsel ve işlevsel paketlerle desteklenmektedir.

## Öne Çıkan Özellikler
* **Gelişmiş Durum Yönetimi:** Uygulama içi veri akışı ve bağımlılık enjeksiyonu işlemleri GetX paketi ile reaktif olarak yönetilmektedir.
* **Kapsamlı Kimlik Doğrulama:** Firebase Auth ve Google Sign-In entegrasyonu sayesinde kullanıcılara güvenli ve hızlı giriş imkanı sunulmaktadır.
* **Gerçek Zamanlı Veritabanı:** Ürünler, kullanıcı verileri ve siparişler Cloud Firestore üzerinde güvenle saklanmakta ve anlık olarak güncellenmektedir.
* **Modern Kullanıcı Arayüzü:** * Uygulama açılışında gecikmeleri gizlemek için özel yapılandırılmış Yerel Açılış Ekranı (Native Splash Screen).
  * Kampanyalar ve ürün görselleri için interaktif Kaydırıcı (Carousel Slider) ve sayfa göstergeleri.
  * Veri yüklenme aşamalarında kullanıcıya gösterilen Shimmer iskelet (skeleton) yükleme efektleri.
  * Lottie animasyonları ile desteklenmiş akıcı arayüz geri bildirimleri.
* **Performanslı Medya Yönetimi:** Cihazdan görsel seçme ve ağ üzerindeki görselleri önbelleğe alarak (cache) veri tasarrufu ve performans artışı sağlama.
* **Yerel Veri Depolama:** Kullanıcı tercihleri ve oturum bilgileri Get Storage ile cihaz üzerinde hızlı bir şekilde saklanmaktadır.

## Kullanılan Teknolojiler ve Paketler

### Durum Yönetimi ve Yerel Depolama
* `get: ^4.6.5` - Reaktif durum yönetimi, yönlendirme (routing) ve bağımlılık enjeksiyonu.
* `get_storage: ^2.1.1` - Hafif ve hızlı anahtar-değer (key-value) tabanlı yerel veri depolama.

### Arka Uç (Backend) ve Servisler
* `firebase_core: ^3.13.0` - Firebase servislerinin temel yapılandırması.
* `firebase_auth: ^5.5.3` - E-posta/Şifre tabanlı kullanıcı kimlik doğrulama.
* `google_sign_in: ^6.3.0` - Google hesabı ile güvenli giriş.
* `cloud_firestore: ^5.6.7` - NoSQL tabanlı gerçek zamanlı bulut veritabanı.

### Ağ, Bağlantı ve Yardımcı Araçlar
* `http: ^1.1.0` - REST API isteklerinin yönetimi.
* `connectivity_plus: ^5.0.1` - Cihazın internet bağlantı durumunun kontrolü.
* `url_launcher: ^6.3.1` - Dış bağlantıların (web sitesi, e-posta, telefon) açılması.
* `logger: ^2.0.1` - Geliştirme sürecinde detaylı ve yapılandırılmış konsol loglama.
* `intl: ^0.18.1` - Tarih, saat ve para birimi formatlandırma/yerelleştirme.

### Kullanıcı Arayüzü (UI) ve Görsel Bileşenler
* `flutter_native_splash` - Cihazın yerel özelliklerini kullanan açılış ekranı konfigürasyonu.
* `carousel_slider` - Özelleştirilebilir, kaydırılabilir görsel ve içerik galerisi.
* `smooth_page_indicator` - Kaydırıcılar için animasyonlu sayfa göstergeleri.
* `shimmer` - Veri yükleme esnasında gösterilen animasyonlu yer tutucular.
* `lottie` - Adobe After Effects tabanlı, yüksek kaliteli vektörel animasyonların oynatılması.
* `cached_network_image` - İnternet üzerinden çekilen görsellerin cihaz belleğinde saklanarak hızlı yüklenmesi.
* `image_picker` - Cihaz kamerası veya galerisinden görsel seçimi.
* `readmore` - Uzun metinler için "Daha Fazla Oku / Daha Az Göster" işlevi.
* `flutter_rating_bar` - Ürün değerlendirmeleri için interaktif yıldız derecelendirme çubuğu.

## Kurulum ve Çalıştırma
Projeyi yerel geliştirme ortamınızda çalıştırmak için aşağıdaki adımları izleyiniz:

1. **Depoyu Klonlayın:**
   ```bash
    git clone https://github.com/furkanteber/ecommerceapp.git
   ```

2. **Proje Dizinine Geçiş Yapın:**
   ```bash
   cd <proje_klasoru>
   ```

3. **Gerekli Bağımlılıkları Yükleyin:**
   ```bash
   flutter pub get
   ```

4. **Uygulamayı Çalıştırın:**
   ```bash
   flutter run
   ```
  
