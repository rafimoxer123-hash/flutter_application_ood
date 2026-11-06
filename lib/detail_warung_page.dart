import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shopping_cart_page.dart';
import 'detail_produk_page.dart';
import 'cart_manager.dart';

/// Model data untuk Menu Makanan/Minuman
class WarungMenuItem {
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  const WarungMenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

/// Model data untuk Warung Kuliner
class WarungModel {
  final String name;
  final double rating;
  final String address;
  final int reviewsCount;
  final String distance;
  final String openingHours;
  final String priceRange;
  final String category;
  final String heroImageUrl;
  final List<WarungMenuItem> menus;

  const WarungModel({
    required this.name,
    required this.rating,
    required this.address,
    required this.reviewsCount,
    required this.distance,
    required this.openingHours,
    required this.priceRange,
    required this.category,
    required this.heroImageUrl,
    required this.menus,
  });
}

class DetailWarungPage extends StatefulWidget {
  final WarungModel? warung;

  const DetailWarungPage({super.key, this.warung});

  @override
  State<DetailWarungPage> createState() => _DetailWarungPageState();
}

class _DetailWarungPageState extends State<DetailWarungPage> {
  // Filter kategori menu yang sedang dipilih
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'Semua Menu',
    'Makanan Utama',
    'Lauk',
    'Minuman',
    'Camilan',
  ];

  // Skema warna sesuai desain Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE2E0D8);

  late final WarungModel _warungData;

  @override
  void initState() {
    super.initState();
    // Default data jika tidak dikirim dari HomePage
    _warungData = widget.warung ??
        const WarungModel(
          name: 'Nasi Buk Hj. Supina',
          rating: 4.8,
          address: 'Pasar Oro Oro Dowo',
          reviewsCount: 128,
          distance: '75m Jarak',
          openingHours: '06.00-14.00',
          priceRange: 'Rp 5.000–25.000',
          category: 'Makanan Berat',
          heroImageUrl:
              'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=800&q=80',
          menus: [
            WarungMenuItem(
              name: 'Nasi Ayam Kampung',
              description: 'Nasi, ayam goreng, urap & sambal',
              price: 25000,
              imageUrl:
                  'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
            ),
            WarungMenuItem(
              name: 'Nasi Pecel',
              description: 'Sayur segar, bumbu kacang & peyek',
              price: 18000,
              imageUrl:
                  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=400&q=80',
            ),
            WarungMenuItem(
              name: 'Es Teh Manis',
              description: 'Teh melati, gula asli & es batu',
              price: 5000,
              imageUrl:
                  'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=400&q=80',
            ),
          ],
        );
  }

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyBackground,
      appBar: AppBar(
        backgroundColor: _bodyBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _textColorDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Warung & Menu',
          style: GoogleFonts.plusJakartaSans(
            color: _textColorDark,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded, color: _textColorDark),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: _textColorDark),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // 1. BANNER FOTO WARUNG & STATUS BUKA
              // ==========================================
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        _warungData.heroImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.restaurant, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 14),
                          const SizedBox(width: 5),
                          Text(
                            'BUKA SEKARANG',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ==========================================
              // 2. KARTU INFORMASI WARUNG
              // ==========================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x05000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            _warungData.name,
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFD97706), size: 16),
                              const SizedBox(width: 4),
                              Text(
                                _warungData.rating.toString(),
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFF92400E),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Lokasi & ulasan
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 15, color: _textColorMuted),
                        const SizedBox(width: 4),
                        Text(
                          '${_warungData.address} • ${_warungData.reviewsCount > 0 ? '${_warungData.reviewsCount} ulasan' : _warungData.distance}',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Jam buka & range harga
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 15, color: _textColorMuted),
                        const SizedBox(width: 4),
                        Text(
                          '${_warungData.openingHours}  •  ${_warungData.priceRange}',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================
              // 3. FILTER KATEGORI MENU (CHIPS)
              // ==========================================
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(_categories.length, (index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: isSelected ? _primaryGreen : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? _primaryGreen : _borderColor,
                            ),
                          ),
                          child: Text(
                            _categories[index],
                            style: GoogleFonts.plusJakartaSans(
                              color: isSelected ? Colors.white : _textColorDark,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // 4. DAFTAR MENU PILIHAN
              // ==========================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu pilihan',
                    style: GoogleFonts.plusJakartaSans(
                      color: _textColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_warungData.menus.length} menu tersedia',
                    style: GoogleFonts.plusJakartaSans(
                      color: _textColorMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Item Kartu Menu
              ListView.separated(
                itemCount: _warungData.menus.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final menu = _warungData.menus[index];
                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      // Respons klik kartu menu makanan
                      onTap: () {
                        if (_warungData.name.contains('Sego Liwet')) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailProdukPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${menu.name} · ${_formatCurrency(menu.price)}'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _borderColor),
                        ),
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Foto Menu
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 72,
                            height: 72,
                            child: Image.network(
                              menu.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.fastfood, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Informasi Nama & Deskripsi
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.name,
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                menu.description,
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorMuted,
                                  fontSize: 11.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              // Harga
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _primaryGreen,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  _formatCurrency(menu.price),
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tombol Tambah ke Keranjang (+)
                        InkWell(
                          onTap: () {
                            CartManager.instance.addItem(
                              name: menu.name,
                              price: menu.price,
                              portion: '1 porsi',
                              imageUrl: menu.imageUrl,
                              warungName: _warungData.name,
                              quantity: 1,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${menu.name} ditambahkan ke keranjang'),
                                action: SnackBarAction(
                                  label: 'Lihat',
                                  textColor: const Color(0xFFDE8A36),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ShoppingCartPage(),
                                      ),
                                    );
                                  },
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: _primaryGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

