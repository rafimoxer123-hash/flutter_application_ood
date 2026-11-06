import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_warung_page.dart';
import 'shopping_cart_page.dart';
import 'home_page.dart';
import 'notifikasi_page.dart';
import 'akun_page.dart';

class WarungListPage extends StatefulWidget {
  const WarungListPage({super.key});

  @override
  State<WarungListPage> createState() => _WarungListPageState();
}

class _WarungListPageState extends State<WarungListPage> {
  // Controller untuk kolom pencarian nama warung atau menu
  final TextEditingController _searchController = TextEditingController();

  // Tab aktif pada Bottom Navigation Bar (Index 1: Warung)
  int _currentNavIndex = 1;

  // Kategori filter yang sedang aktif
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    'Semua',
    'Makanan Berat',
    'Sate & Bakar',
    'Jajanan Manis',
  ];

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);

  // Sumber data daftar warung kuliner
  final List<WarungModel> _allWarungs = [
    const WarungModel(
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
    ),
    const WarungModel(
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
          description: 'Nasi liwet, ayam suwir, kemangi, bumbu rempah',
          price: 25000,
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Sego Liwet Bakar Tuna',
          description: 'Nasi liwet, tuna suwir pedas, kemangi',
          price: 25000,
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
    ),
    const WarungModel(
      name: 'Sate Mari Kerjo (Marjo)',
      rating: 5.0,
      address: 'Pasar Oro-Oro Dowo',
      reviewsCount: 88,
      distance: 'Kuliner · No. 15',
      openingHours: '08.00 - 16.00',
      priceRange: 'Rp 15.000–35.000',
      category: 'Sate & Bakar',
      heroImageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=600&q=80',
      menus: [
        WarungMenuItem(
          name: 'Sate Ayam Bumbu Kacang',
          description: '10 tusuk sate ayam lembut & lontong',
          price: 20000,
          imageUrl:
              'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Sate Kambing Muda',
          description: '10 tusuk sate kambing empuk sambal kecap',
          price: 32000,
          imageUrl:
              'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),
    const WarungModel(
      name: 'Klepon-Ku',
      rating: 4.8,
      address: 'Pasar Oro-Oro Dowo',
      reviewsCount: 110,
      distance: 'Kuliner · No. 19',
      openingHours: '06.00 - 13.00',
      priceRange: 'Rp 5.000–15.000',
      category: 'Jajanan Manis',
      heroImageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=600&q=80',
      menus: [
        WarungMenuItem(
          name: 'Klepon Gula Merah Asli',
          description: 'Klepon isi gula jawa lumer dengan parutan kelapa gurih',
          price: 10000,
          imageUrl:
              'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Lupis Ketan Kelapa',
          description: 'Lupis ketan legit disiram kinca gula aren',
          price: 10000,
          imageUrl:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter daftar warung berdasarkan kategori dan pencarian kata kunci
  List<WarungModel> get _filteredWarungs {
    final query = _searchController.text.trim().toLowerCase();
    return _allWarungs.where((warung) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          warung.category.toLowerCase() == _selectedCategory.toLowerCase();

      final matchesQuery = query.isEmpty ||
          warung.name.toLowerCase().contains(query) ||
          warung.category.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final warungList = _filteredWarungs;

    return Scaffold(
      backgroundColor: _bodyBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==========================================
            // 1. TOP BAR (Logo Brand & 3 Tombol Aksi)
            // ==========================================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Row(
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
                        // Navigasi ke Halaman Keranjang Belanja
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

            // ==========================================
            // 2. KOLOM PENCARIAN (TextField)
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _borderColor),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.plusJakartaSans(
                    color: _textColorDark,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    hintText: 'Cari nama warung atau menu...',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.5,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // 3. HEADER JUDUL & KATEGORI FILTER
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peta Warung Kuliner',
                    style: GoogleFonts.playfairDisplay(
                      color: _textColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '40+ warung kuliner aktif hari ini.',
                    style: GoogleFonts.plusJakartaSans(
                      color: _textColorMuted,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Chip Filter Kategori (Wrap agar sesuai layout baris)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((category) {
                      final isSelected = _selectedCategory == category;
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? _primaryGreen : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isSelected ? _primaryGreen : _borderColor,
                              ),
                            ),
                            child: Text(
                              category,
                              style: GoogleFonts.plusJakartaSans(
                                color: isSelected
                                    ? Colors.white
                                    : _textColorDark,
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ==========================================
            // 4. DAFTAR WARUNG MENGGUNAKAN ListView.builder
            // ==========================================
            Expanded(
              child: warungList.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada warung yang sesuai.',
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorMuted,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: warungList.length,
                      itemBuilder: (context, index) {
                        final warung = warungList[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              onTap: () {
                                // Navigasi dinamis ke DetailWarungPage untuk semua warung
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailWarungPage(
                                      warung: warung,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                height: 96,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: _borderColor),
                                ),
                                child: Row(
                                  children: [
                                    // Foto Kuliner di Sisi Kiri
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                      ),
                                      child: SizedBox(
                                        width: 100,
                                        height: double.infinity,
                                        child: Image.network(
                                          warung.heroImageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              Container(
                                            color: Colors.grey.shade200,
                                            child: const Icon(
                                              Icons.restaurant,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    // Detail Warung (Nama, Rating, Lokasi No, Kategori Tag)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Nama Warung
                                            Text(
                                              warung.name,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: _textColorDark,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            const SizedBox(height: 4),

                                            // Rating & Nomor Kios
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xFFD97706),
                                                  size: 15,
                                                ),
                                                const SizedBox(width: 3),
                                                Text(
                                                  warung.rating.toString(),
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color:
                                                        const Color(0xFFD97706),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  warung.distance,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: _textColorMuted,
                                                    fontSize: 11.5,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 6),

                                            // Badge Kategori Kuliner
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF3F0E6),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                warung.category,
                                                style: GoogleFonts
                                                    .plusJakartaSans(
                                                  color: _primaryGreen,
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ==========================================
      // 5. BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: _borderColor, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: (index) {
            setState(() {
              _currentNavIndex = index;
            });

            // Navigasi ke Beranda jika tab Beranda (index 0) ditekan
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else if (index == 2) {
              // Navigasi ke Keranjang (index 2)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartPage(),
                ),
              );
            } else if (index == 3) {
              // Navigasi ke Halaman Akun / Profil (index 3)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AkunPage(),
                ),
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
              icon: Icon(Icons.storefront_rounded),
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

