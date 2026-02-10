## 🔟 Menambahkan Permission Android (Wajib)

Agar **notifikasi bisa bergetar** dan **tetap aktif setelah perangkat di-restart**, tambahkan permission berikut ke file **AndroidManifest.xml**.

📁 Lokasi file:

```
android/app/src/main/AndroidManifest.xml
```

📌 Tambahkan **di luar tag `<application>`**, biasanya di bagian atas file:

```xml
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
```

---

### 📖 Penjelasan Permission

#### 🔔 `android.permission.VIBRATE`

* Mengizinkan aplikasi **mengaktifkan getaran**
* Digunakan oleh notifikasi untuk:

  * Feedback getar
  * Notifikasi penting / high priority
* Tanpa ini, notifikasi **tetap muncul tapi tidak bergetar**

---

#### 🔁 `android.permission.RECEIVE_BOOT_COMPLETED`

* Mengizinkan aplikasi **menerima event setelah HP direstart**
* Digunakan untuk:

  * Mengaktifkan ulang **scheduled notification**
  * Reminder / alarm yang sudah dijadwalkan sebelumnya
* Sangat penting untuk aplikasi reminder / task / alarm

---



# 🔔 Flutter Awesome Notifications (Step by Step)

Dokumentasi ini menjelaskan langkah demi langkah cara menggunakan **Awesome Notifications** di Flutter, mulai dari inisialisasi, permission, hingga menampilkan notifikasi dan badge.

---

## 1️⃣ Menambahkan Dependency & Permission

Tambahkan package `awesome_notifications` di file `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
    awesome_notifications: ^0.10.1
```

Lalu jalankan:

```bash
flutter pub get
```
---

### Menambahkan Permission Android (Wajib)

Agar **notifikasi bisa bergetar** dan **tetap aktif setelah perangkat di-restart**, tambahkan permission berikut ke file **AndroidManifest.xml**.

📁 Lokasi file:

```
android/app/src/main/AndroidManifest.xml
```

📌 Tambahkan **di luar tag `<application>`**, biasanya di bagian atas file:

```xml
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
```

---

### 📖 Penjelasan Permission

#### 🔔 `android.permission.VIBRATE`

* Mengizinkan aplikasi **mengaktifkan getaran**
* Digunakan oleh notifikasi untuk:

  * Feedback getar
  * Notifikasi penting / high priority
* Tanpa ini, notifikasi **tetap muncul tapi tidak bergetar**

---

#### 🔁 `android.permission.RECEIVE_BOOT_COMPLETED`

* Mengizinkan aplikasi **menerima event setelah HP direstart**
* Digunakan untuk:

  * Mengaktifkan ulang **scheduled notification**
  * Reminder / alarm yang sudah dijadwalkan sebelumnya
* Sangat penting untuk aplikasi reminder / task / alarm

---

## 2️⃣ Inisialisasi Awesome Notifications

Inisialisasi dilakukan di dalam fungsi `main()` **sebelum** `runApp()` dipanggil.

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
    null, // menggunakan icon default aplikasi
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.deepPurple,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: 'important_channel',
        channelName: 'Important Notifications',
        channelDescription: 'Notification channel for important tests',
        defaultColor: Colors.deepPurple,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
      ),
    ],
    debug: true,
  );

  runApp(const MyApp());
}
```

### Penjelasan:

* **channelKey** → identitas channel notifikasi
* **importance** → menentukan prioritas notifikasi
* **debug: true** → membantu debugging saat development

---

## 3️⃣ Membuat Root App dan Navigator Global

Navigator global digunakan agar aplikasi bisa berpindah halaman saat notifikasi ditekan.

```dart
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}
```

---

## 4️⃣ Request Permission Notifikasi

Permission harus diminta secara manual (Android 13+ dan iOS).

```dart
@override
void initState() {
  super.initState();

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}
```

### Kenapa ini penting?

Tanpa permission:

* Notifikasi **tidak akan muncul**
* Badge **tidak akan tampil**

---

## 5️⃣ Konfigurasi Routing Aplikasi

Digunakan untuk navigasi saat notifikasi ditekan.

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  navigatorKey: MyApp.navigatorKey,
  initialRoute: '/',
  routes: {
    '/': (_) => const HomePage(),
    '/notification-page': (_) => const NotificationPage(),
  },
);
```

---

## 6️⃣ Menampilkan Notifikasi Biasa

Contoh notifikasi sederhana menggunakan channel `basic_channel`.

```dart
ElevatedButton(
  onPressed: () {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Hello World!',
        body: 'This is my first notification!',
        badge: 5,
      ),
    );
  },
  child: const Text('Show Notification'),
),
```

### Catatan:

* **id** harus unik
* **badge** menentukan angka badge pada icon aplikasi

---

## 7️⃣ Menampilkan Notifikasi Penting

Notifikasi penting menggunakan channel dengan `importance: Max`.

```dart
ElevatedButton(
  onPressed: () {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'important_channel',
        title: 'Hello World!',
        body: 'This is important notification!',
      ),
    );
  },
  child: const Text('Show Important Notification'),
),
```

---

## 8️⃣ Halaman Tujuan Setelah Notifikasi Ditekan

```dart
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Page')),
      body: const Center(
        child: Text('Opened from notification'),
      ),
    );
  }
}
```

---

## 9️⃣ Menangani Klik pada Notifikasi

Saat notifikasi ditekan, aplikasi akan berpindah halaman.

```dart
class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    MyApp.navigatorKey.currentState
        ?.pushNamed('/notification-page');
  }
}
```

### Kenapa pakai `@pragma("vm:entry-point")`?

Agar method tetap bisa dipanggil walaupun app sedang di background atau terminated.
