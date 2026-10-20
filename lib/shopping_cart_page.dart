import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'validasi_transaksi_page.dart';

/// Model item pesanan di dalam keranjang
class CartOrderItem {
  final String name;
  final String portion;
  final int price;
  final int quantity;
  final String imageUrl;

  const CartOrderItem({
    required this.name,
    required this.portion,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

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
  String _selectedPaymentMethod = 'QRIS';

  // Biaya ongkos kirim
  final int _deliveryFee = 8000;

  // Daftar item pesanan dari warung Sego Liwet Bakar Kemangi
  final List<CartOrderItem> _orderItems = const [
    CartOrderItem(
      name: 'Sego Liwet Bakar Ayam',
      portion: 'Porsi · daun pisang',
      price: 15000,
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
    ),
    CartOrderItem(
      name: 'Sego Liwet Bakar Tuna',
      portion: 'Porsi · daun pisang',
      price: 15000,
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  // Hitung subtotal seluruh menu
  int get _subtotal {
    return _orderItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  // Hitung total bayar (Subtotal + Ongkos Kirim)
  int get _totalPayment {
    return _subtotal + _deliveryFee;
  }

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
                          onTap: () {},
                        ),
                        const SizedBox(width: 8),
                        _buildTopCircleButton(
                          icon: Icons.shopping_basket_outlined,
                          iconColor: const Color(0xFF78716C),
                          onTap: () {},
                        ),
                        const SizedBox(width: 8),
                        _buildTopCircleButton(
                          icon: Icons.person_outline_rounded,
                          iconColor: const Color(0xFF2563EB),
                          onTap: () {},
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
                // 4. DAFTAR PESANAN PER WARUNG
                // ==========================================
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Column(
                    children: [
                      // Header Warung: Sego Liwet Bakar Kemangi | Rp30.000
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
                              'Sego Liwet Bakar Kemangi',
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

                                // Kuantitas (x1) & Harga (Rp15.000)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'x${item.quantity}',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: _textColorMuted,
                                        fontSize: 12,
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
                        onTap: () {
                          // Dialog pilih metode pembayaran
                          _showPaymentMethodBottomSheet(context);
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ValidasiTransaksiPage(
                                  totalPayment: _totalPayment,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentOrange,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Konfirmasi Pesanan',
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF1E232A),
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
    );
  }


  // Bottom Sheet untuk Memilih Metode Pembayaran
  void _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final methods = ['QRIS', 'Tunai / COD', 'Transfer Bank BCA', 'GoPay'];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Pilih Metode Pembayaran',
                  style: GoogleFonts.playfairDisplay(
                    color: _textColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...methods.map((method) {
                return ListTile(
                  title: Text(
                    method,
                    style: GoogleFonts.plusJakartaSans(
                      color: _textColorDark,
                      fontSize: 13.5,
                      fontWeight: _selectedPaymentMethod == method
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: _selectedPaymentMethod == method
                      ? const Icon(Icons.check, color: _primaryGreen)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedPaymentMethod = method;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
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

