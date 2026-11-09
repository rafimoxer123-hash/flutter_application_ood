import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'warung_list_page.dart';
import 'shopping_cart_page.dart';
import 'akun_page.dart';
import 'validasi_transaksi_page.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  // Index aktif tab (default 0 / Beranda)
  final int _currentNavIndex = 0;

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);
  static const Color _accentOrange = Color(0xFFDE8A36);

  // Filter kategori notifikasi aktif
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    'Semua',
    'Pesanan & Driver',
    'Promo & Voucher',
    'Info Sistem',
  ];

  // Status unread untuk notifikasi
  int _unreadCount = 2;
  bool _driverUnread = true;
  bool _voucherUnread = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyBackground,
      appBar: AppBar(
        backgroundColor: _primaryGreen,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 90,
        leading: InkWell(
          // Tombol kembali ke halaman sebelumnya
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios_new, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  'Kembali',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        title: Text(
          'Notifikasi',
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // 1. BARIS INFORMASI BELUM DIBACA & TANDAI DIBACA
              // ==========================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_unreadCount belum dibaca',
                      style: GoogleFonts.plusJakartaSans(
                        color: _accentOrange,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    // Tandai semua notifikasi sudah dibaca
                    onTap: () {
                      setState(() {
                        _unreadCount = 0;
                        _driverUnread = false;
                        _voucherUnread = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Semua notifikasi ditandai sudah dibaca.'),
                          backgroundColor: _primaryGreen,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Text(
                      'Tandai Semua Dibaca',
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorDark,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ==========================================
              // 2. CHIP FILTER KATEGORI NOTIFIKASI
              // ==========================================
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        // Pilih filter kategori notifikasi
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? _primaryGreen : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? _primaryGreen : _borderColor,
                            ),
                          ),
                          child: Text(
                            category,
                            style: GoogleFonts.plusJakartaSans(
                              color: isSelected ? Colors.white : _textColorDark,
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================
              // 3. DAFTAR KARTU NOTIFIKASI
              // ==========================================

              // Notifikasi 1: Driver Mengantar Pesanan
              _buildNotificationCard(
                icon: Icons.delivery_dining_rounded,
                iconColor: const Color(0xFF16A34A),
                iconBgColor: const Color(0xFFDCFCE7),
                title: 'Driver Sedang Mengantar Pesananmu!',
                body:
                    'Budi (Driver) sedang menuju ke alamatmu (Jl. Veteran). Estimasi tiba: 12 menit.',
                time: '5 mnt lalu',
                hasUnreadDot: _driverUnread,
                actionButtonText: 'Lacak Driver ›',
                actionButtonBg: const Color(0xFFE8F5E9),
                actionButtonColor: const Color(0xFF16A34A),
                onActionTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Membuka pelacakan posisi Driver Budi...'),
                      backgroundColor: _primaryGreen,
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Notifikasi 2: Voucher Diskon 30%
              _buildNotificationCard(
                icon: Icons.confirmation_number_outlined,
                iconColor: const Color(0xFFD97706),
                iconBgColor: const Color(0xFFFEF3C7),
                title: 'Voucher Diskon 30% Spesial Kuliner!',
                body:
                    'Gunakan kode ORODOWO30 untuk diskon hingga Rp15.000 di warung Jajanan Manis favoritmu.',
                time: '2 jam lalu',
                hasUnreadDot: _voucherUnread,
                actionButtonText: 'Klaim Voucher ›',
                actionButtonBg: const Color(0xFFFFF7ED),
                actionButtonColor: const Color(0xFFD97706),
                onActionTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Voucher ORODOWO30 berhasil diklaim ke akunmu!'),
                      backgroundColor: _accentOrange,
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Notifikasi 3: Pesanan Selesai
              _buildNotificationCard(
                icon: Icons.check_circle_outline_rounded,
                iconColor: const Color(0xFF16A34A),
                iconBgColor: const Color(0xFFE2E8F0),
                title: 'Pesanan #OOD-20260929-041 Selesai',
                body:
                    'Makanan dari Sego Liwet Bakar Kemangi telah diterima. Beri ulasan untuk warung ini!',
                time: 'Kemarin, 12.30 WIB',
                hasUnreadDot: false,
                onCardTap: () {
                  // Navigasi ke rincian pesanan validasi transaksi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ValidasiTransaksiPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Notifikasi 4: Promo Gratis Ongkir
              _buildNotificationCard(
                icon: Icons.card_giftcard_rounded,
                iconColor: const Color(0xFF78716C),
                iconBgColor: const Color(0xFFF1F5F9),
                title: 'Promo Gratis Ongkir Spesial Minggu Ini',
                body:
                    'Nikmati gratis ongkir se-Malang Raya dengan minimal transaksi Rp30.000.',
                time: '2 hari lalu',
                hasUnreadDot: false,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ==========================================
      // 4. BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: _borderColor, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          // Perpindahan antar tab di BottomNavigationBar
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WarungListPage()),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingCartPage()),
              );
            } else if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AkunPage()),
              );
            }
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
              icon: Icon(Icons.person_outline),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Kartu Notifikasi
  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String body,
    required String time,
    required bool hasUnreadDot,
    String? actionButtonText,
    Color? actionButtonBg,
    Color? actionButtonColor,
    VoidCallback? onActionTap,
    VoidCallback? onCardTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onCardTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorDark,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (hasUnreadDot)
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(left: 6),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD97706),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          body,
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 11.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 46),
                    child: Text(
                      time,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11,
                      ),
                    ),
                  ),
                  if (actionButtonText != null)
                    InkWell(
                      onTap: onActionTap,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: actionButtonBg ?? const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          actionButtonText,
                          style: GoogleFonts.plusJakartaSans(
                            color: actionButtonColor ?? _primaryGreen,
                            fontSize: 11,
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
      ),
    );
  }
}
