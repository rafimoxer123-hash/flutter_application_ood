import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'shopping_cart_page.dart';
import 'notifikasi_page.dart';
import 'akun_page.dart';
import 'cart_manager.dart';

class ValidasiTransaksiPage extends StatefulWidget {
  final String? orderNumber;
  final String? estimatedTime;
  final String? deliveryAddress;
  final int? totalPayment;

  const ValidasiTransaksiPage({
    super.key,
    this.orderNumber = '#OOD-20260929-041',
    this.estimatedTime = '25–35 menit',
    this.deliveryAddress = 'Jl. Veteran, Malang',
    this.totalPayment = 38000,
  });

  @override
  State<ValidasiTransaksiPage> createState() => _ValidasiTransaksiPageState();
}

class _ValidasiTransaksiPageState extends State<ValidasiTransaksiPage> {
  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);
  static const Color _footerBgColor = Color(0xFF0F261C);

  // Akses data dengan fallback aman (mencegah null assertion crash)
  String get _orderNumber => widget.orderNumber ?? '#OOD-20260929-041';
  String get _estimatedTime => widget.estimatedTime ?? '25–35 menit';
  String get _deliveryAddress => widget.deliveryAddress ?? 'Jl. Veteran, Malang';
  int get _totalPayment => widget.totalPayment ?? 38000;

  // Format mata uang Rupiah tanpa spasi (Rp38.000)
  String _formatCurrency(int amount) {
    final formatted = amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return 'Rp$formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ==========================================
              // 1. TOP BAR (Logo Brand & 3 Tombol Aksi)
              // ==========================================
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo + Nama Pasar
                    Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: _primaryGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Transform.rotate(
                            angle: -0.2,
                            child: const Icon(
                              Icons.eco_rounded,
                              color: Color(0xFF86EFAC),
                              size: 19,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Pasar Oro-Oro Dowo',
                          style: GoogleFonts.playfairDisplay(
                            color: _textColorDark,
                            fontSize: 14.5,
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
                          // Navigasi ke Halaman Keranjang
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShoppingCartPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildTopCircleButton(
                          icon: Icons.person_outline_rounded,
                          iconColor: const Color(0xFF2563EB),
                          // Navigasi ke Halaman Akun / Profil
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AkunPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ==========================================
              // 2. ICON CENTANG SUKSES
              // ==========================================
              Center(
                child: Container(
                  width: 66,
                  height: 66,
                  decoration: const BoxDecoration(
                    color: _primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================
              // 3. PESAN STATUS: PESANAN DIKONFIRMASI
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Pesanan dikonfirmasi',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Warung mulai memasak pesananmu. Kami kabari begitu\nmakanan siap diantar hangat.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF4B5563),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ==========================================
              // 4. KARTU RINCIAN DATA TRANSAKSI
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Column(
                    children: [
                      // Baris 1: Nomor Pesanan
                      _buildDetailRow(
                        label: 'Nomor pesanan',
                        value: _orderNumber,
                        isBold: true,
                      ),

                      // Pembatas garis putus-putus
                      _buildDashedLine(),

                      // Baris 2: Estimasi Tiba
                      _buildDetailRow(
                        label: 'Estimasi tiba',
                        value: _estimatedTime,
                        isBold: true,
                      ),

                      _buildDashedLine(),

                      // Baris 3: Alamat Pengiriman
                      _buildDetailRow(
                        label: 'Alamat',
                        value: _deliveryAddress,
                        isBold: true,
                      ),

                      _buildDashedLine(),

                      // Baris 4: Total Bayar
                      _buildDetailRow(
                        label: 'Total bayar',
                        value: _formatCurrency(_totalPayment),
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ==========================================
              // 5. TOMBOL KEMBALI KE BERANDA (pushAndRemoveUntil)
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    // -----------------------------------------------------------------
                    // KHUSUS BAGIAN INI:
                    // Navigator.pushAndRemoveUntil digunakan agar aplikasi langsung
                    // kembali ke HomePage dan menghapus seluruh tumpukan halaman sebelumnya
                    // (seperti DetailProdukPage dan ShoppingCartPage).
                    // -----------------------------------------------------------------
                    onPressed: () {
                      // Kosongkan keranjang belanja setelah pesanan tervalidasi
                      CartManager.instance.clearCart();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false, // Hapus semua rute sebelumnya
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Kembali ke Beranda',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // ==========================================
              // 6. FOOTER COPYRIGHT (Hijau Gelap Paling Bawah)
              // ==========================================
              // ... (Widget tombol "Kembali ke Beranda" Anda di atasnya) ...
        
            ], // Tutup list children milik Column
          ),
        ),
      ),
      
      // ==========================================
      // FOOTER COPYRIGHT (Dipindahkan ke bottomNavigationBar)
      // ==========================================
      bottomNavigationBar: Container(
        width: double.infinity,
        color: _footerBgColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© Pasar Oro-Oro Dowo',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white60,
                fontSize: 11,
              ),
            ),
            Text(
              'Malang',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white60,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Helper Widget: Baris Rincian Data
  Widget _buildDetailRow({
    required String label,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: _textColorMuted,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.plusJakartaSans(
              color: _textColorDark,
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Helper Widget: Garis Putus-putus (Dashed Line)
  Widget _buildDashedLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.maxWidth.isFinite && constraints.maxWidth > 0
              ? constraints.maxWidth
              : 300.0;
          const dashWidth = 4.0;
          const dashSpace = 3.0;
          final count =
              (boxWidth / (dashWidth + dashSpace)).floor().clamp(1, 100);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(count, (_) {
              return const SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFE5E2D9)),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  // Helper Widget: Tombol Bulat di Atas
  Widget _buildTopCircleButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: _borderColor),
        ),
        child: Icon(icon, color: iconColor, size: 16),
      ),
    );
  }
}
