import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pilih_pembayaran_page.dart';
import 'home_page.dart';
import 'warung_list_page.dart';
import 'notifikasi_page.dart';
import 'akun_page.dart';
import '../viewmodels/cart_manager.dart';
import 'main_tab_controller.dart';
import 'address_modal.dart';

class ShoppingCartPage extends StatefulWidget {
  final bool isEmbedded;
  const ShoppingCartPage({super.key, this.isEmbedded = false});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _accentOrange = Color(0xFFDE8A36);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);
  static const Color _bannerBgColor = Color(0xFFF5EFE3);

  // Metode pembayaran terpilih
  final String _selectedPaymentMethod = 'QRIS';

  // Biaya ongkos kirim (Rp8.000 jika ada pesanan, Rp0 jika kosong)
  int get _deliveryFee => _orderItems.isEmpty ? 0 : 8000;

  // Daftar item pesanan dari CartManager (awalnya kosong sebelum pengguna memesan)
  List<CartItem> get _orderItems => CartManager.instance.items;

  // Hitung subtotal seluruh menu
  int get _subtotal => CartManager.instance.subtotal;

  // Hitung total bayar (Subtotal + Ongkos Kirim)
  int get _totalPayment => _orderItems.isEmpty ? 0 : _subtotal + _deliveryFee;

  // Format mata uang Rupiah (contoh: Rp30.000 / Rp8.000 / Rp38.000)
  String _formatCurrency(int amount) {
    final formatted = amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return 'Rp$formatted';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartManager.instance,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: _bodyBackground,
          body: SafeArea(
            child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==========================================
                // 1. TOP BAR (Logo Brand & 3 Tombol Aksi)
                // ==========================================
                Row(
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
                          // Sudah di halaman Keranjang
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Anda sedang berada di halaman keranjang.'),
                                duration: Duration(seconds: 1),
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
                            MainTabController.switchTab(3);
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Tombol Navigasi Kembali: "← Lanjut pesan"
                GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        size: 16,
                        color: _primaryGreen,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Lanjut pesan',
                        style: GoogleFonts.plusJakartaSans(
                          color: _primaryGreen,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ==========================================
                // 2. JUDUL: KERANJANG PESANAN
                // ==========================================
                Text(
                  'Keranjang Pesanan',
                  style: GoogleFonts.playfairDisplay(
                    color: _textColorDark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Menu dikelompokkan per warung, diantar dalam satu jadwal.',
                  style: GoogleFonts.plusJakartaSans(
                    color: _textColorMuted,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 14),

                if (_orderItems.isEmpty) ...[
                  // ==========================================
                  // TAMPILAN KERANJANG KOSONG
                  // ==========================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 36, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5EFE3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_basket_outlined,
                            size: 38,
                            color: _primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Keranjang Belanja Masih Kosong',
                          style: GoogleFonts.playfairDisplay(
                            color: _textColorDark,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Kamu belum menambahkan menu kuliner apapun.\nYuk, pesan makanan favoritmu sekarang!',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 12,
                            height: 1.45,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            MainTabController.switchTab(1);
                          },
                          icon: const Icon(
                            Icons.storefront_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Jelajahi Warung Kuliner',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryGreen,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ] else ...[
                  // ==========================================
                  // 3. BANNER INFORMASI ESTIMASI MASAK & TIBA
                  // ==========================================
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: _bannerBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.search_rounded,
                            color: _textColorDark,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Dimasak fresh begitu diterima warung — estimasi tiba ',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 11.5,
                                height: 1.35,
                              ),
                              children: [
                                TextSpan(
                                  text: '25–35 menit.',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                    color: _textColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==========================================
                  // 4. DAFTAR PESANAN PER WARUNG / STATUS KOSONG
                  // ==========================================
                  if (_orderItems.isEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 36, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3F4F6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shopping_basket_outlined,
                              size: 32,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Keranjang Belanja Kosong',
                            style: GoogleFonts.playfairDisplay(
                              color: _textColorDark,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Yuk pilih aneka menu kuliner legendaris khas Pasar Oro-Oro Dowo!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorMuted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton.icon(
                            onPressed: () {
                              MainTabController.switchTab(1);
                            },
                            icon: const Icon(Icons.storefront_rounded,
                                size: 16, color: Colors.white),
                            label: Text(
                              'Jelajahi Menu Warung',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryGreen,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ] else ...[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Column(
                      children: [
                        // Header Warung & Subtotal
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: const BoxDecoration(
                            color: _bannerBgColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                            border: Border(
                              bottom: BorderSide(color: _borderColor),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _orderItems.isNotEmpty
                                    ? _orderItems.first.warungName
                                    : 'Warung Kuliner',
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorDark,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _formatCurrency(_subtotal),
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorDark,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Daftar Item Pesanan dalam Warung
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _orderItems.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: _borderColor,
                            height: 1,
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            final item = _orderItems[index];

                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  // Foto Makanan
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: Image.network(
                                        item.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          color: Colors.grey.shade200,
                                          child: const Icon(
                                            Icons.fastfood,
                                            color: Colors.grey,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // Nama & Porsi
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: _textColorDark,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item.portion,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: _textColorMuted,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Stepper Kuantitas: [-] [qty] [+] & Harga
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            CartManager.instance
                                                .updateQuantity(item.name, -1);
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3F4F6),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: _borderColor),
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            size: 13,
                                            color: _textColorDark,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          '${item.quantity}',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: _textColorDark,
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            CartManager.instance
                                                .updateQuantity(item.name, 1);
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: _primaryGreen,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        _formatCurrency(
                                            item.price * item.quantity),
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
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],

                // ==========================================
                // 5. KARTU PILIHAN PEMBAYARAN & TOTAL CEPAT
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Column(
                    children: [
                      // Baris Pilihan Pembayaran
                      InkWell(
                        // Navigasi ke Halaman Pilih Metode Pembayaran
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PilihPembayaranPage(
                                totalAmount: _totalPayment,
                                initialMethod: _selectedPaymentMethod,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pilihan Pembayaran',
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorMuted,
                                fontSize: 12.5,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  _selectedPaymentMethod,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: _textColorDark,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 18,
                                  color: _textColorMuted,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          color: _borderColor,
                          height: 1,
                          thickness: 1,
                        ),
                      ),

                      // Baris Total Bayar Cepat
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total bayar',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formatCurrency(_totalPayment),
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ==========================================
                // 6. KARTU RINCIAN PEMBAYARAN & TOMBOL KONFIRMASI
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Column(
                    children: [
                      // Subtotal Menu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal menu',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorMuted,
                              fontSize: 12.5,
                            ),
                          ),
                          Text(
                            _formatCurrency(_subtotal),
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Ongkos Kirim
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ongkos kirim',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorMuted,
                              fontSize: 12.5,
                            ),
                          ),
                          Text(
                            _formatCurrency(_deliveryFee),
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(
                          color: _borderColor,
                          height: 1,
                          thickness: 1,
                        ),
                      ),

                      // Total Bayar Akhir
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total bayar',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formatCurrency(_totalPayment),
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Tombol Oranye: Konfirmasi Pesanan
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          // Navigasi ke Halaman Pilih Metode Pembayaran
                          onPressed: () {
                            if (_orderItems.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Keranjang belanja masih kosong, pilih menu kuliner terlebih dahulu.'),
                                  backgroundColor: Color(0xFFD97706),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PilihPembayaranPage(
                                  totalAmount: _totalPayment,
                                  initialMethod: _selectedPaymentMethod,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _orderItems.isEmpty
                                ? const Color(0xFFD1D5DB)
                                : _accentOrange,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Konfirmasi Pesanan',
                            style: GoogleFonts.plusJakartaSans(
                              color: _orderItems.isEmpty
                                  ? const Color(0xFF6B7280)
                                  : const Color(0xFF1E232A),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar untuk ShoppingCartPage
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
                currentIndex: 2, // Index 2: Keranjang Aktif
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
                    icon: Icon(Icons.shopping_basket),
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
      },
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

