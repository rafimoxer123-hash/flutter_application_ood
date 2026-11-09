import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shopping_cart_page.dart';
import 'notifikasi_page.dart';
import 'akun_page.dart';
import '../viewmodels/cart_manager.dart';

/// Model item produk kuliner untuk halaman Detail Produk
class ProductMenuItem {
  final String id;
  final String name;
  final String portion;
  final int price;
  final String? imageUrl;
  int quantity;

  ProductMenuItem({
    required this.id,
    required this.name,
    required this.portion,
    required this.price,
    this.imageUrl,
    this.quantity = 0,
  });
}

class DetailProdukPage extends StatefulWidget {
  const DetailProdukPage({super.key});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _accentOrange = Color(0xFFDE8A36);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);

  // Daftar menu makanan sesuai dengan tangkapan layar
  final List<ProductMenuItem> _products = [
    ProductMenuItem(
      id: '1',
      name: 'Sego Liwet Bakar Ayam',
      portion: 'Porsi · daun pisang',
      price: 15000,
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=500&q=80',
      quantity: 0,
    ),
    ProductMenuItem(
      id: '2',
      name: 'Sego Liwet Bakar Tuna',
      portion: 'Porsi · daun pisang',
      price: 15000,
      imageUrl:
          'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=500&q=80',
      quantity: 0,
    ),
    ProductMenuItem(
      id: '3',
      name: 'Sego Liwet Bakar Teri',
      portion: 'Porsi · daun pisang',
      price: 15000,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=500&q=80',
      quantity: 0, // Sesuai screenshot (jumlah: 0)
    ),
    ProductMenuItem(
      id: '4',
      name: 'Sego Liwet Bakar Cumi',
      portion: 'Porsi · daun pisang',
      price: 16000,
      imageUrl: null, // Sesuai screenshot (kartu tanpa foto/putih)
      quantity: 0, // Sesuai screenshot (jumlah: 0)
    ),
  ];

  // Menghitung total harga keranjang secara dinamis dari CartManager
  int get _totalPrice => CartManager.instance.subtotal;

  // Menghitung total porsi makanan yang dipilih dari CartManager
  int get _totalItems => CartManager.instance.totalItems;

  // Format mata uang Rupiah tanpa spasi (Rp15.000)
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
            child: Column(
              children: [
                // Konten halaman yang dapat digulirkan (scrollable)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
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

                      const SizedBox(height: 14),

                      // Tombol Navigasi Kembali: "← Peta Warung"
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
                              'Peta Warung',
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
                      // 2. KARTU BANNER WARUNG
                      // ==========================================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 130,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F261C),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Gambar Background Warung
                              Image.network(
                                'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(color: _primaryGreen),
                              ),

                              // Lapisan Gradasi Hitam Transparan agar teks terbaca jelas
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0x66000000),
                                      Color(0xCC000000),
                                    ],
                                  ),
                                ),
                              ),

                              // Teks Informasi Banner Warung
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sego Liwet Bakar Kemangi',
                                      style: GoogleFonts.playfairDisplay(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Color(0xFFFBBF24),
                                          size: 15,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          '4.8 (410 pesanan)',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white,
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Kuliner · No. 08',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Dimasak fresh · siap 10–15 menit',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFFCDE2D6),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ==========================================
                      // 3. JUDUL: MENU TERSEDIA
                      // ==========================================
                      Text(
                        'Menu tersedia',
                        style: GoogleFonts.playfairDisplay(
                          color: _textColorDark,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Dibungkus daun pisang, dibakar begitu pesanan masuk.',
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorMuted,
                          fontSize: 11.5,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ==========================================
                      // 4. GRID TATA LETAK MENU MAKANAN (2 KOLOM)
                      // ==========================================
                      GridView.builder(
                        itemCount: _products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.74,
                        ),
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return _buildProductCard(product);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ==========================================
            // 5. BOTTOM BAR STATIS (Total Harga & Keranjang)
            // ==========================================
            _buildStaticBottomBar(),
          ],
        ),
      ),
    );
      },
    );
  }

  // Widget Kartu Produk dalam Grid
  Widget _buildProductCard(ProductMenuItem product) {
    final currentQty = CartManager.instance.getItemQuantity(product.name);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk (atau ruang putih seragam jika tanpa foto)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 102,
              child: product.imageUrl != null
                  ? Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.fastfood, color: Colors.grey),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                    ),
            ),
          ),

          // Detail Produk & Stepper Jumlah
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorDark,
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.portion,
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorMuted,
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),

                  // Baris Harga & Desain Tombol Jumlah '+' dan '-'
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Harga Produk
                      Text(
                        _formatCurrency(product.price),
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorDark,
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Stepper Jumlah: [-] [qty] [+]
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tombol Kurang (-)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (currentQty > 0) {
                                  CartManager.instance.updateQuantity(product.name, -1);
                                }
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: _primaryGreen,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 6),

                          // Angka Jumlah
                          SizedBox(
                            width: 14,
                            child: Text(
                              currentQty.toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 6),

                          // Tombol Tambah (+)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                CartManager.instance.addItem(
                                  name: product.name,
                                  price: product.price,
                                  portion: product.portion,
                                  imageUrl: product.imageUrl ??
                                      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
                                  warungName: 'Sego Liwet Bakar Kemangi',
                                  quantity: 1,
                                );
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: _primaryGreen,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Bottom Bar Statis di Bagian Bawah Layar
  Widget _buildStaticBottomBar() {
    return Container(
      width: double.infinity,
      color: _primaryGreen,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Total Keranjang & Harga
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total keranjang',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFBACBC2),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatCurrency(_totalPrice),
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Tombol Oranye: Keranjang (Jumlah)
          SizedBox(
            height: 42,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingCartPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentOrange,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Keranjang ($_totalItems)',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF1E232A),
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Tombol Bulat di Baris Atas
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
