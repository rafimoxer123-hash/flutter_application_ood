import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'warung_list_page.dart';
import 'shopping_cart_page.dart';
import 'pusat_bantuan_page.dart';
import 'notifikasi_page.dart';
import 'detail_warung_page.dart';
import 'validasi_transaksi_page.dart';
import 'login_page.dart';
import '../viewmodels/order_manager.dart';
import 'address_modal.dart';
import 'main_tab_controller.dart';

class AkunPage extends StatefulWidget {
  final bool isEmbedded;
  const AkunPage({super.key, this.isEmbedded = false});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  // Tab aktif pada Bottom Navigation Bar (Index 3: Akun)
  final int _currentNavIndex = 3;

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);
  static const Color _bannerBgColor = Color(0xFFF5EFE3);
  static const Color _accentOrange = Color(0xFFDE8A36);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: OrderManager.instance,
      builder: (context, _) {
        final activeCount = OrderManager.instance.activeOrdersCount;
        final historyCount = OrderManager.instance.historyCount;
        final favCount = OrderManager.instance.favoriteCount;

        return Scaffold(
          backgroundColor: _bodyBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ==========================================
              // 1. TOP BAR (Brand Logo & 3 Ikon Aksi)
              // ==========================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo + Nama Pasar
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Transform.rotate(
                          angle: -0.2,
                          child: const Icon(
                            Icons.eco_rounded,
                            color: Color(0xFF86EFAC),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Pasar Oro-Oro Dowo',
                        style: GoogleFonts.playfairDisplay(
                          color: _textColorDark,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // 3 Tombol Aksi (Notifikasi, Keranjang, Profil)
                  Row(
                    children: [
                      _buildTopCircleButton(
                        icon: Icons.notifications_active_outlined,
                        iconColor: const Color(0xFFD97706),
                        // Navigasi ke Halaman Notifikasi
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotifikasiPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                        _buildTopCircleButton(
                          icon: Icons.shopping_basket_outlined,
                          iconColor: const Color(0xFF78716C),
                          // Berpindah ke Halaman Keranjang
                          onTap: () {
                            MainTabController.switchTab(2);
                          },
                        ),
                      const SizedBox(width: 8),
                      // Ikon Profil yang sedang aktif
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF86EFAC),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ==========================================
              // 2. KARTU PROFIL PENGGUNA (Lionel Messi)
              // ==========================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Avatar Lingkaran LM
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: _primaryGreen,
                          child: Text(
                            'LM',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Nama & Nomor HP
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lionel Messi',
                                style: GoogleFonts.playfairDisplay(
                                  color: _textColorDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '+62 812 3456 7890',
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorMuted,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tombol Edit Profil
                        ElevatedButton(
                          // Aksi edit profil
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Membuka formulir Edit Profil...'),
                                backgroundColor: _primaryGreen,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryGreen,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Edit Profil',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 3 Badge Statistik Pesanan (Pesanan aktif, Riwayat, Favorit)
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatBadge(
                            title: 'Pesanan aktif',
                            value: '$activeCount',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildStatBadge(
                            title: 'Riwayat',
                            value: '$historyCount',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildStatBadge(
                            title: 'Favorit',
                            value: '$favCount',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================
              // 3. KARTU PESANAN SAYA
              // ==========================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesanan Saya',
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Baris 1: Pesanan aktif
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pesanan aktif',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$activeCount pesanan sedang diproses',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorMuted,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          // Lihat detail pesanan aktif
                          onTap: () {
                            if (OrderManager.instance.activeOrders.isNotEmpty) {
                              _showActiveOrdersSheet(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Tidak ada pesanan yang sedang diproses.'),
                                  backgroundColor: _primaryGreen,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _bannerBgColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Lihat semua',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Baris 2: Riwayat pesanan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Riwayat pesanan',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Lihat semua transaksi',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorMuted,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          // Lihat riwayat transaksi
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Membuka riwayat 18 transaksi selesai...'),
                                backgroundColor: _primaryGreen,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _bannerBgColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Lihat',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================
              // 4. KARTU ALAMAT TERSIMPAN
              // ==========================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Tersimpan',
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Ikon Pin Lokasi
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: _bannerBgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Color(0xFFDC2626),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Alamat Utama
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alamat utama',
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorDark,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Jl. Veteran No. 12, Malang',
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorMuted,
                                  fontSize: 11.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tombol Ubah Alamat
                        InkWell(
                          // Aksi ubah alamat via modal bottom sheet
                          onTap: () {
                            showDeliveryAddressModal(context);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _bannerBgColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Ubah',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================
              // 5. KARTU WARUNG FAVORIT
              // ==========================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warung Favorit',
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Warung 1: Nasi Buk Hj. Supina
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              // Navigasi ke DetailWarungPage Nasi Buk Hj. Supina
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailWarungPage(
                                      warung: const WarungModel(
                                        name: 'Nasi Buk Hj. Supina',
                                        rating: 4.9,
                                        address: 'Pasar Oro-Oro Dowo',
                                        reviewsCount: 128,
                                        distance: 'Kuliner · No. 03',
                                        openingHours: 'Buka 06.00–15.00',
                                        priceRange: 'Rp 5.000–25.000',
                                        category: 'Makanan Berat',
                                        heroImageUrl:
                                            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
                                        menus: [
                                          WarungMenuItem(
                                            name: 'Nasi Ayam Kampung',
                                            description:
                                                'Nasi, ayam goreng, urap & sambal',
                                            price: 25000,
                                            imageUrl:
                                                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 75,
                                      width: double.infinity,
                                      child: Image.network(
                                        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=400&q=80',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.restaurant),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Nasi Buk Hj. Supina',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _textColorDark,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Makanan Berat',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _textColorMuted,
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Warung 2: Sego Liwet Bakar
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              // Navigasi ke DetailWarungPage Sego Liwet Bakar
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailWarungPage(
                                      warung: const WarungModel(
                                        name: 'Sego Liwet Bakar Kemangi',
                                        rating: 4.8,
                                        address: 'Pasar Oro-Oro Dowo',
                                        reviewsCount: 94,
                                        distance: 'Kuliner · No. 08',
                                        openingHours: '07.00 - 15.00',
                                        priceRange: 'Rp 15k - 30k',
                                        category: 'Makanan Berat',
                                        heroImageUrl:
                                            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=600&q=80',
                                        menus: [
                                          WarungMenuItem(
                                            name: 'Sego Liwet Bakar Ayam',
                                            description:
                                                'Nasi liwet, ayam suwir, kemangi, bumbu rempah',
                                            price: 25000,
                                            imageUrl:
                                                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 75,
                                      width: double.infinity,
                                      child: Image.network(
                                        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.restaurant),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Sego Liwet Bakar',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _textColorDark,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Makanan Berat',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _textColorMuted,
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // =========================================================================
              // 6. KARTU BANTUAN -> NAVIGASI KE PUSAT BANTUAN PAGE
              // =========================================================================
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  // -----------------------------------------------------------------
                  // KHUSUS BAGIAN INI:
                  // Menghubungkan kartu 'Bantuan' ke PusatBantuanPage
                  // -----------------------------------------------------------------
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PusatBantuanPage(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        // Ikon Bantuan Kuning/Oranye
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.support_agent_rounded,
                            color: Color(0xFFD97706),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Judul & Keterangan
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bantuan',
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorDark,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'FAQ, bantuan pesanan, dan kontak dukungan',
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorMuted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Panah Kanan
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF9CA3AF),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // 7. TOMBOL KELUAR (LOGOUT)
              // ==========================================
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  // Keluar akun dan kembali ke halaman Login
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: _borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Keluar',
                    style: GoogleFonts.plusJakartaSans(
                      color: _accentOrange,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

      // ==========================================
      // 8. BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: widget.isEmbedded
          ? null
          : Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: _borderColor, width: 1),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentNavIndex,
                onTap: (index) {
                  MainTabController.switchTab(index);
                },
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: _primaryGreen,
                unselectedItemColor: const Color(0xFF9CA3AF),
                selectedLabelStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.storefront_outlined),
                    label: 'Warung',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket_outlined),
                    label: 'Keranjang',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Akun',
                  ),
                ],
              ),
            ),
    );
      },
    );
  }

  // Modal Bottom Sheet untuk melihat daftar pesanan aktif
  void _showActiveOrdersSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final orders = OrderManager.instance.activeOrders;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daftar Pesanan Aktif',
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close, color: _textColorMuted, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...orders.map((o) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F8F3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              o.orderId,
                              style: GoogleFonts.plusJakartaSans(
                                color: _primaryGreen,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                o.status,
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFF15803D),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          o.warungName,
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorDark,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          o.itemsSummary,
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 11.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estimasi: ${o.estimatedTime}',
                              style: GoogleFonts.plusJakartaSans(
                                color: _accentOrange,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Rp${o.totalPayment.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper Widget: Kartu Statistik Kecil (Pesanan aktif, Riwayat, Favorit)
  Widget _buildStatBadge({
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: _bannerBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: _textColorMuted,
              fontSize: 10.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: _textColorDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Tombol Bulat Top Bar
  Widget _buildTopCircleButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: _borderColor),
        ),
        child: Icon(icon, color: iconColor, size: 17),
      ),
    );
  }
}

