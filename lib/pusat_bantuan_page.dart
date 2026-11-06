import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'warung_list_page.dart';
import 'shopping_cart_page.dart';
import 'akun_page.dart';

class PusatBantuanPage extends StatefulWidget {
  const PusatBantuanPage({super.key});

  @override
  State<PusatBantuanPage> createState() => _PusatBantuanPageState();
}

class _PusatBantuanPageState extends State<PusatBantuanPage> {
  // Index aktif tab Akun / Pusat Bantuan (Index 3)
  final int _currentNavIndex = 3;

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);
  static const Color _accentOrange = Color(0xFFDE8A36);

  // Status accordion pertanyaan populer
  int? _expandedFaqIndex = 0; // Default buka item pertama (Cara pemesanan)

  final List<Map<String, String>> _faqs = [
    {
      'question': 'Cara pemesanan',
      'answer':
          'Pilih warung dan menu favoritmu, masukkan ke keranjang, lalu lanjutkan pembayaran. Warung akan menyiapkan pesananmu.',
    },
    {
      'question': 'Estimasi pengiriman',
      'answer':
          'Estimasi waktu pengantaran kuliner berkisar 25–35 menit setelah pesanan dikonfirmasi oleh warung.',
    },
    {
      'question': 'Metode pembayaran',
      'answer':
          'Kami menerima berbagai metode pembayaran: QRIS (GoPay, OVO, ShopeePay, Dana), Virtual Account BCA, Mandiri, BRI, serta Bayar di Tempat (COD).',
    },
    {
      'question': 'Pesanan tidak sesuai',
      'answer':
          'Bila pesanan tidak sesuai, segera hubungi Customer Service kami dalam kurun waktu 1x24 jam beserta bukti foto pesanan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyBackground,
      appBar: AppBar(
        backgroundColor: _primaryGreen,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          // Tombol kembali ke halaman sebelumnya
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AkunPage()),
              );
            }
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Pusat Bantuan',
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // 1. HEADER TEKS PERTANYAAN & SUBJUDUL
              // ==========================================
              Text(
                'Ada yang bisa kami bantu?',
                style: GoogleFonts.playfairDisplay(
                  color: _textColorDark,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Kami siap menemani pesanan kuliner kamu.',
                style: GoogleFonts.plusJakartaSans(
                  color: _textColorMuted,
                  fontSize: 12.5,
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================
              // 2. SEARCH BAR PENCARIAN KENDALA
              // ==========================================
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _borderColor),
                ),
                child: TextField(
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: _textColorDark,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    hintText: 'Cari kendala atau pertanyaan kamu...',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.5,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================
              // 3. KARTU KONTAK CS (WHATSAPP & EMAIL)
              // ==========================================
              _buildContactCard(
                icon: Icons.chat_bubble_outline_rounded,
                iconColor: const Color(0xFF16A34A),
                iconBgColor: const Color(0xFFDCFCE7),
                title: 'Hubungi CS via WhatsApp',
                subtitle: 'Respons cepat · 05.00–17.00 WIB',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Membuka layanan WhatsApp CS Pasar Oro-Oro Dowo...'),
                      backgroundColor: _primaryGreen,
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),

              _buildContactCard(
                icon: Icons.mail_outline_rounded,
                iconColor: const Color(0xFFD97706),
                iconBgColor: const Color(0xFFFEF3C7),
                title: 'Email Bantuan',
                subtitle: 'Ceritakan kendala kamu lewat email',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Menghubungkan ke bantuan@pasarororodowo.id...'),
                      backgroundColor: _primaryGreen,
                    ),
                  );
                },
              ),

              const SizedBox(height: 22),

              // ==========================================
              // 4. ACCORDION: PERTANYAAN POPULER
              // ==========================================
              Text(
                'Pertanyaan Populer',
                style: GoogleFonts.playfairDisplay(
                  color: _textColorDark,
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  children: List.generate(_faqs.length, (index) {
                    final item = _faqs[index];
                    final isExpanded = _expandedFaqIndex == index;
                    final isLast = index == _faqs.length - 1;

                    return Column(
                      children: [
                        InkWell(
                          // Klik untuk membuka atau menutup FAQ item
                          onTap: () {
                            setState(() {
                              _expandedFaqIndex = isExpanded ? null : index;
                            });
                          },
                          borderRadius: BorderRadius.vertical(
                            top: index == 0 ? const Radius.circular(14) : Radius.zero,
                            bottom: isLast && !isExpanded
                                ? const Radius.circular(14)
                                : Radius.zero,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['question']!,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _textColorDark,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: _textColorMuted,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                            child: Text(
                              item['answer']!,
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorMuted,
                                fontSize: 12,
                                height: 1.45,
                              ),
                            ),
                          ),
                        if (!isLast)
                          const Divider(
                            color: _borderColor,
                            height: 1,
                            thickness: 1,
                          ),
                      ],
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // 5. BANNER MASIH BUTUH BANTUAN?
              // ==========================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _primaryGreen,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Masih butuh bantuan?',
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tim pasar siap membantu kamu.',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      // Membuka fitur live chat
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Menghubungkan ke Live Chat Pasar...'),
                            backgroundColor: _accentOrange,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentOrange,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Buka Live Chat',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF1E232A),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ==========================================
      // 6. BOTTOM NAVIGATION BAR
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
          // Perpindahan halaman antar BottomNavigationBar tab
          onTap: (index) {
            if (index == _currentNavIndex) return;

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
              icon: Icon(Icons.person),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Kartu opsi kontak bantuan (WA / Email)
  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorDark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9CA3AF),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

