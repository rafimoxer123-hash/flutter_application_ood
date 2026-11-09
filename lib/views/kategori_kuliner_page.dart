import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'warung_list_page.dart';
import 'shopping_cart_page.dart';
import 'akun_page.dart';
import 'notifikasi_page.dart';
import 'detail_warung_page.dart';
import '../viewmodels/cart_manager.dart';
import 'address_modal.dart';
import 'main_tab_controller.dart';

class KategoriKulinerPage extends StatefulWidget {
  final String initialCategory;

  const KategoriKulinerPage({
    super.key,
    this.initialCategory = 'Jajanan Manis',
  });

  @override
  State<KategoriKulinerPage> createState() => _KategoriKulinerPageState();
}

class _KategoriKulinerPageState extends State<KategoriKulinerPage> {
  // Tab aktif pada Bottom Navigation Bar
  final int _currentNavIndex = 1;

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);

  // Kategori terpilih
  late String _selectedCategory;
  final List<String> _categories = [
    'Makanan Berat',
    'Sate & Bakar',
    'Jajanan Manis',
    'Kopi & Minuman',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  // Data dinamis berdasarkan kategori
  Map<String, dynamic> _getCategoryData(String category) {
    switch (category) {
      case 'Kopi & Minuman':
        return {
          'title': 'Kopi & Minuman',
          'icon': Icons.coffee_rounded,
          'count': '7 warung',
          'description': 'Kopi seduh, minuman segar, dan wedang.',
          'searchHint': 'Cari kopi, es dawet, atau warung...',
          'subFilters': ['Semua menu', 'Dingin', 'Hangat', 'Harga ▾'],
          'favTitle': 'Minuman favorit',
          'favSubtitle': 'Teman sarapan dan pelengkap makan siang.',
          'favorites': [
            {
              'name': 'Es Kopi Susu',
              'place': 'Kopi Pasar Pak Budi',
              'desc': 'Gelas · gula aren',
              'price': 12000,
              'tag': 'Terlaris',
              'image':
                  'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Es Dawet Gula Aren',
              'place': 'Dawet Ayu Bu Tini',
              'desc': 'Gelas · santan segar',
              'price': 8000,
              'tag': 'Favorit',
              'image':
                  'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'warungTitle': 'Warung kopi & minuman',
          'warungSubtitle': '4 dari 7 warung · menu tersedia hari ini',
          'warungs': [
            {
              'name': 'Kopi Pasar Pak Budi',
              'rating': 4.9,
              'time': 'Siap 5–10 menit',
              'menu': 'Es kopi susu · Rp12.000',
              'tag': 'Kopi seduh segar',
              'image':
                  'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Dawet Ayu Bu Tini',
              'rating': 4.8,
              'time': 'Siap 5–10 menit',
              'menu': 'Es dawet gula aren · Rp8.000',
              'tag': 'Gula aren asli',
              'image':
                  'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Es Jeruk Pak Slamet',
              'rating': 4.7,
              'time': 'Siap 5–10 menit',
              'menu': 'Es jeruk peras · Rp7.000',
              'tag': 'Jeruk peras segar',
              'image':
                  'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Wedang Rempah Bu Lastri',
              'rating': 4.8,
              'time': 'Siap 5–10 menit',
              'menu': 'Wedang jahe · Rp8.000',
              'tag': 'Hangat & berempah',
              'image':
                  'https://images.unsplash.com/photo-1544787219-7f47ccb76574?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'moreText': 'Lihat 3 warung lainnya →',
          'bottomNotice':
              '☕ Pilih tingkat gula dan es saat menambahkan minuman.',
        };
      case 'Makanan Berat':
        return {
          'title': 'Makanan Berat',
          'icon': Icons.lunch_dining_rounded,
          'count': '16 warung',
          'description':
              'Aneka nasi ramesan, olahan daging, dan makanan kenyang pasar.',
          'searchHint': 'Cari nasi rames, pecel, rawon, atau warung...',
          'subFilters': ['Semua menu', 'Buka sekarang', 'Harga ▾'],
          'favTitle': 'Menu terlaris',
          'favSubtitle': 'Sajian porsi mantap khas pedagang pasar.',
          'favorites': [
            {
              'name': 'Nasi Ayam Kampung',
              'place': 'Nasi Buk Hj. Supina',
              'desc': 'Porsi · lalapan & sambal',
              'price': 25000,
              'tag': 'Terlaris',
              'image':
                  'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Sego Liwet Bakar Ayam',
              'place': 'Sego Liwet Bakar Kemangi',
              'desc': 'Porsi · daun pisang',
              'price': 25000,
              'tag': 'Favorit',
              'image':
                  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'warungTitle': 'Warung makanan berat',
          'warungSubtitle': 'Pilihan warung legendaris Pasar Oro-Oro Dowo',
          'warungs': [
            {
              'name': 'Nasi Buk Hj. Supina',
              'rating': 4.9,
              'time': 'Siap 10–15 menit',
              'menu': 'Nasi campur buk · Rp25.000',
              'tag': 'Legendaris Malang',
              'image':
                  'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Sego Liwet Bakar Kemangi',
              'rating': 4.8,
              'time': 'Siap 10–15 menit',
              'menu': 'Sego liwet bakar · Rp25.000',
              'tag': 'Bakar rempah',
              'image':
                  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'moreText': 'Lihat 14 warung lainnya →',
          'bottomNotice':
              '🍲 Makanan disajikan hangat langsung saat pesanan dibuat.',
        };
      case 'Sate & Bakar':
        return {
          'title': 'Sate & Bakar',
          'icon': Icons.outdoor_grill_rounded,
          'count': '8 warung',
          'description': 'Sate ayam, kambing, dan aneka bakaran rempah.',
          'searchHint': 'Cari sate ayam, kambing, bakar bumbu...',
          'subFilters': ['Semua menu', 'Buka sekarang', 'Harga ▾'],
          'favTitle': 'Bakaran favorit',
          'favSubtitle': 'Aroma bakaran arang khas bumbu kacang.',
          'favorites': [
            {
              'name': 'Sate Ayam Bumbu Kacang',
              'place': 'Sate Mari Kerjo (Marjo)',
              'desc': '10 tusuk + lontong',
              'price': 20000,
              'tag': 'Terlaris',
              'image':
                  'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Sate Kambing Muda',
              'place': 'Sate Mari Kerjo (Marjo)',
              'desc': '10 tusuk + sambal kecap',
              'price': 32000,
              'tag': 'Favorit',
              'image':
                  'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'warungTitle': 'Warung sate & bakar',
          'warungSubtitle': 'Pilihan sate dan bakaran terfavorit',
          'warungs': [
            {
              'name': 'Sate Mari Kerjo (Marjo)',
              'rating': 5.0,
              'time': 'Siap 15–20 menit',
              'menu': 'Sate ayam & kambing · Rp20.000',
              'tag': 'Bumbu kacang kental',
              'image':
                  'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'moreText': 'Lihat 7 warung lainnya →',
          'bottomNotice': '🔥 Dibakar dengan arang batok kelapa pilihan.',
        };
      case 'Jajanan Manis':
      default:
        return {
          'title': 'Jajanan Manis',
          'icon': Icons.cake_rounded,
          'count': '16 warung',
          'description':
              'Aneka kue basah, jajanan pasar tradisional, dan camilan manis.',
          'searchHint': 'Cari klepon, lupis, kue basah, atau warung...',
          'subFilters': ['Semua menu', 'Buka sekarang', 'Harga ▾'],
          'favTitle': 'Menu favorit',
          'favSubtitle': 'Manis legit, cocok untuk camilan sore.',
          'favorites': [
            {
              'name': 'Klepon Pandan',
              'place': 'Jajanan Pasar Bu Ka',
              'desc': '10 pcs isi gula merah',
              'price': 12000,
              'tag': 'Terlaris',
              'image':
                  'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Lupis Ketan Kelapa',
              'place': 'Toko Kue Mbok Sum',
              'desc': 'Porsi saus gula merah',
              'price': 15000,
              'tag': 'Favorit',
              'image':
                  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'warungTitle': 'Warung jajanan manis',
          'warungSubtitle': '8 dari 16 warung · menu tersedia hari ini',
          'warungs': [
            {
              'name': 'Jajanan Pasar Bu Ka',
              'rating': 4.9,
              'time': 'Siap 10–15 menit',
              'menu': 'Klepon, lupis, cenil · Rp12.000',
              'tag': 'Kue tradisional',
              'image':
                  'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80',
            },
            {
              'name': 'Toko Kue Mbok Sum',
              'rating': 4.8,
              'time': 'Siap 10–15 menit',
              'menu': 'Aneka kue basah & nagasari · Rp10.000',
              'tag': 'Resep legendaris',
              'image':
                  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=400&q=80',
            },
          ],
          'moreText': 'Lihat 8 warung lainnya →',
          'bottomNotice':
              '🍃 Jajanan dibuat segar setiap hari. Waktu siap tiap warung berbeda.',
        };
    }
  }

  // Format harga Rupiah
  String _formatCurrency(int amount) {
    final formatted = amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return 'Rp$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final catData = _getCategoryData(_selectedCategory);
    final List favorites = catData['favorites'] as List;
    final List warungs = catData['warungs'] as List;

    return Scaffold(
      backgroundColor: _bodyBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ==========================================
              // 1. TOP BAR (Brand Logo & 3 Ikon Aksi)
              // ==========================================
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo
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

                    // 3 Tombol Top Bar
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
                            MainTabController.switchTab(2);
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildTopCircleButton(
                          icon: Icons.person_outline_rounded,
                          iconColor: const Color(0xFF2563EB),
                          // Navigasi ke Halaman Akun / Profil
                          onTap: () {
                            MainTabController.switchTab(3);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ==========================================
              // 2. BARIS ALAMAT PENGIRIMAN
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () => showDeliveryAddressModal(context),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Color(0xFFDC2626),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Dikirim ke ',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 11.5,
                          ),
                        ),
                        Text(
                          'Jl. Veteran, Malang ▾',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorDark,
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ==========================================
              // 3. HEADER HIJAU GELAP KATEGORI KULINER
              // ==========================================
              Container(
                color: _primaryGreen,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tautan Balik ke Beranda
                    InkWell(
                      // Navigasi kembali ke Beranda
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios_new,
                            size: 11,
                            color: Color(0xFFBACBC2),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Beranda / Kategori kuliner',
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFFBACBC2),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Judul & Ikon Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          catData['title'],
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0x33FFFFFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            catData['icon'] as IconData,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Keterangan Jumlah Warung
                    RichText(
                      text: TextSpan(
                        text: '${catData['count']} · ',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF86EFAC),
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: catData['description'],
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ==========================================
              // 4. CHIP PILIHAN 4 KATEGORI UTAMA
              // ==========================================
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        // Ganti kategori kuliner
                        onTap: () {
                          setState(() {
                            _selectedCategory = cat;
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
                            cat,
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

              const SizedBox(height: 12),

              // ==========================================
              // 5. SEARCH BAR PENCARIAN MENU / KULINER
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _borderColor),
                  ),
                  child: TextField(
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      color: _textColorDark,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF9CA3AF),
                        size: 19,
                      ),
                      hintText: catData['searchHint'],
                      hintStyle: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 11),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ==========================================
              // 6. FILTER TAMBAHAN (Semua Menu, Buka, Harga)
              // ==========================================
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: (catData['subFilters'] as List<String>)
                      .map((filter) {
                    final isFirst = filter == catData['subFilters'][0];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isFirst
                              ? const Color(0xFFF3EFE6)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _borderColor),
                        ),
                        child: Text(
                          filter,
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorDark,
                            fontSize: 11.5,
                            fontWeight:
                                isFirst ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================
              // 7. SECTION: MENU FAVORIT
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      catData['favTitle'],
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      catData['favSubtitle'],
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorMuted,
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Grid 2 Menu Favorit
                    Row(
                      children: List.generate(favorites.length, (index) {
                        final fav = favorites[index];
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index == 0 ? 8.0 : 0.0,
                              left: index == 1 ? 8.0 : 0.0,
                            ),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                // Aksi saat kartu menu favorit ditekan
                                onTap: () {
                                  _showAddedSnackBar(fav);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: _borderColor),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Foto dengan Badge Terlaris / Favorit
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                              top: Radius.circular(11),
                                            ),
                                            child: SizedBox(
                                              height: 100,
                                              width: double.infinity,
                                              child: Image.network(
                                                fav['image'],
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
                                          Positioned(
                                            top: 6,
                                            left: 6,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                fav['tag'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: _primaryGreen,
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              fav['name'],
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: _textColorDark,
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${fav['place']} · ${fav['desc']}',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: _textColorMuted,
                                                fontSize: 10,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  _formatCurrency(fav['price']),
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: _textColorDark,
                                                    fontSize: 12.5,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                                // Tombol Tambah (+)
                                                InkWell(
                                                  // Tambah menu favorit ke keranjang
                                                  onTap: () {
                                                    _showAddedSnackBar(fav);
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: Container(
                                                    width: 26,
                                                    height: 26,
                                                    decoration: BoxDecoration(
                                                      color: _primaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // 8. SECTION: DAFTAR WARUNG
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          catData['warungTitle'],
                          style: GoogleFonts.playfairDisplay(
                            color: _textColorDark,
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Terpopuler ▾',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      catData['warungSubtitle'],
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorMuted,
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Daftar Warung Terkait
                    ...List.generate(warungs.length, (index) {
                      final item = warungs[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            // Navigasi ke DetailWarungPage saat warung diklik
                            onTap: () {
                              _navigateToDetailWarung(item['name']);
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _borderColor),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      width: 68,
                                      height: 68,
                                      child: Image.network(
                                        item['image'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
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
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: GoogleFonts.plusJakartaSans(
                                            color: _textColorDark,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star_rounded,
                                              size: 14,
                                              color: Color(0xFFD97706),
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              item['rating'].toString(),
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: _textColorDark,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ' · ${item['time']}',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: _textColorMuted,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          item['menu'],
                                          style: GoogleFonts.plusJakartaSans(
                                            color: _textColorMuted,
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 7,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFEF3C7),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            item['tag'],
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF92400E),
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.w600,
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
                    }),

                    const SizedBox(height: 4),

                    // Tombol Lihat Warung Lainnya
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: OutlinedButton(
                        // Navigasi ke WarungListPage
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WarungListPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: _borderColor),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          catData['moreText'],
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorDark,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ==========================================
              // 9. BANNER NOTIFIKASI BAWAH
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5EFE3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    catData['bottomNotice'],
                    style: GoogleFonts.plusJakartaSans(
                      color: _textColorDark,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // 10. FOOTER PASAR
              // ==========================================
              Container(
                color: const Color(0xFF0F261C),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            ],
          ),
        ),
      ),

      // ==========================================
      // 11. BOTTOM NAVIGATION BAR
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
            MainTabController.switchTab(index);
            Navigator.pop(context);
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

  // Notifikasi tambah ke keranjang
  void _showAddedSnackBar(Map<String, dynamic> fav) {
    CartManager.instance.addItem(
      name: fav['name'] as String,
      price: fav['price'] as int,
      portion: (fav['desc'] ?? '1 porsi') as String,
      imageUrl: (fav['image'] ?? '') as String,
      warungName: (fav['place'] ?? 'Warung Kuliner') as String,
      quantity: 1,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${fav['name']} ditambahkan ke keranjang'),
        action: SnackBarAction(
          label: 'Lihat',
          textColor: const Color(0xFFDE8A36),
          // Navigasi ke halaman keranjang
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
  }

  // Navigasi ke detail warung sesuai warung yang dipilih
  void _navigateToDetailWarung(String warungName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailWarungPage(
          warung: WarungModel(
            name: warungName,
            rating: 4.8,
            address: 'Pasar Oro-Oro Dowo',
            reviewsCount: 88,
            distance: 'Kuliner Pasar',
            openingHours: '06.00–16.00',
            priceRange: 'Rp 8.000–30.000',
            category: _selectedCategory,
            heroImageUrl:
                'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
            menus: const [
              WarungMenuItem(
                name: 'Menu Spesial',
                description: 'Pilihan menu khas warung pasar',
                price: 15000,
                imageUrl:
                    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
              ),
            ],
          ),
        ),
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
