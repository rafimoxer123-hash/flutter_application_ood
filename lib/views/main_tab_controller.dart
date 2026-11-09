import 'package:flutter/foundation.dart';

/// Pengendali Tab Utama Aplikasi untuk Navigasi Antar Tab (Beranda, Warung, Keranjang, Akun)
/// Menggunakan ValueNotifier agar dapat diakses dari halaman/widget manapun secara global
class MainTabController {
  static final ValueNotifier<int> currentTab = ValueNotifier<int>(0);

  /// Berpindah tab secara instan tanpa mereset status halaman (IndexedStack)
  static void switchTab(int index) {
    if (index >= 0 && index <= 3) {
      currentTab.value = index;
    }
  }
}

