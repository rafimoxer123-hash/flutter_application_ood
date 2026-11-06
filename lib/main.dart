import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'warung_list_page.dart';
import 'detail_warung_page.dart';
import 'detail_produk_page.dart';
import 'shopping_cart_page.dart';
import 'pilih_pembayaran_page.dart';
import 'validasi_transaksi_page.dart';
import 'notifikasi_page.dart';
import 'pusat_bantuan_page.dart';
import 'akun_page.dart';
import 'kategori_kuliner_page.dart';

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
        '/home': (context) => const HomePage(),
        '/warung': (context) => const WarungListPage(),
        '/detail-warung': (context) => const DetailWarungPage(),
        '/detail-produk': (context) => const DetailProdukPage(),
        '/cart': (context) => const ShoppingCartPage(),
        '/pilih-pembayaran': (context) => const PilihPembayaranPage(),
        '/validasi-transaksi': (context) => const ValidasiTransaksiPage(),
        '/notifikasi': (context) => const NotifikasiPage(),
        '/pusat-bantuan': (context) => const PusatBantuanPage(),
        '/akun': (context) => const AkunPage(),
        '/kategori-kuliner': (context) => const KategoriKulinerPage(),
      },
    );
  }
}
