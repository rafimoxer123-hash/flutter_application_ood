import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';
import 'views/warung_list_page.dart';
import 'views/detail_warung_page.dart';
import 'views/detail_produk_page.dart';
import 'views/shopping_cart_page.dart';
import 'views/pilih_pembayaran_page.dart';
import 'views/validasi_transaksi_page.dart';
import 'views/notifikasi_page.dart';
import 'views/pusat_bantuan_page.dart';
import 'views/akun_page.dart';
import 'views/kategori_kuliner_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Mengatur warna status bar sistem agar serasi dengan header hijau gelap
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pasar Oro-Oro Dowo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F8F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16392A),
          primary: const Color(0xFF16392A),
        ),
      ),
      // Rute awal dimulai dari LoginPage
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(initialIndex: 0),
        '/warung': (context) => const HomePage(initialIndex: 1),
        '/cart': (context) => const HomePage(initialIndex: 2),
        '/akun': (context) => const HomePage(initialIndex: 3),
        '/detail-warung': (context) => const DetailWarungPage(),
        '/detail-produk': (context) => const DetailProdukPage(),
        '/pilih-pembayaran': (context) => const PilihPembayaranPage(),
        '/validasi-transaksi': (context) => const ValidasiTransaksiPage(),
        '/notifikasi': (context) => const NotifikasiPage(),
        '/pusat-bantuan': (context) => const PusatBantuanPage(),
        '/kategori-kuliner': (context) => const KategoriKulinerPage(),
      },
    );
  }
}
