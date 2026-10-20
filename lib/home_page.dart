import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_warung_page.dart';
import 'warung_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller untuk kolom pencarian
  final TextEditingController _searchController = TextEditingController();

  // Index aktif untuk Bottom Navigation Bar
  int _currentNavIndex = 0;

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _secondaryGreen = Color(0xFF1F4836);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _accentOrange = Color(0xFFDE8A36);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);

  // Data daftar warung favorit minggu ini
  final List<WarungModel> _warungFavoritList = [
    const WarungModel(
      name: 'Nasi Buk Hj. Supina',
      rating: 4.9,
      address: 'Pasar Oro Oro Dowo',
      reviewsCount: 128,
      distance: '75m Jarak',
      openingHours: 'Buka 06.00–15.00',
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
    ),
    const WarungModel(
      name: 'Sego Liwet Bakar Kemangi',
      rating: 4.8,
      address: 'Pasar Oro-Oro Dowo',
      reviewsCount: 94,
      distance: '75m Jarak',
      openingHours: '07.00 - 15.00',
      priceRange: 'Rp 15k - 30k',
      category: 'Makanan Berat',
      heroImageUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
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
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              // 1. TOP BAR & PENCARIAN (Krem / Off-White)
              // ==========================================
              Container(
                color: _bodyBackground,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Column(
                  children: [
                    // Baris Logo Brand & Tombol Aksi
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
                            const SizedBox(width: 8),
                            Text(
                              'Pasar Oro-Oro\nDowo',
                              style: GoogleFonts.playfairDisplay(
                                color: _textColorDark,
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                height: 1.15,
                              ),
                            ),
                          ],
                        ),

                        // 3 Ikon Aksi (Notifikasi, Tas/Keranjang, Profil)
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

                    const SizedBox(height: 12),

                    // Lokasi Pengiriman (Dikirim ke Jl. Veteran, Malang)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFFE11D48),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Dikirim ke ',
                                style: GoogleFonts.plusJakartaSans(
                                  color: _textColorMuted,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Jl. Veteran, Malang',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _textColorDark,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(text: ' ▾'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Input Pencarian
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _borderColor),
                      ),
                      child: TextField(
                        controller: _searchController,
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
                          hintText: 'Cari nasi liwet, sate, kue lumpur...',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.5,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==========================================
              // 2. HERO BANNER HIJAU GELAP
              // ==========================================
              Container(
                color: _primaryGreen,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge: Dimasak Fresh · Pasar Buka 05.00–17.00
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0x14FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0x2EFFFFFF),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.soup_kitchen_rounded,
                            color: Color(0xFF86EFAC),
                            size: 13,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Dimasak Fresh · Pasar Buka 05.00–17.00',
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFFCDE2D6),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Headline
                    RichText(
                      text: TextSpan(
                        text: 'Satu Aplikasi, ',
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                        children: [
                          TextSpan(
                            text: 'Ragam Kuliner\n',
                            style: TextStyle(color: _accentOrange),
                          ),
                          TextSpan(
                            text: 'Legendaris',
                            style: TextStyle(color: _accentOrange),
                          ),
                          const TextSpan(text: ' Pasar'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle Banner
                    Text(
                      'Pesan langsung dari warung legendaris pasar — dimasak fresh begitu pesanan masuk, diantar hangat ke rumahmu.',
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFFBCCEC4),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tombol 1: Pesan Kuliner Sekarang
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentOrange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Pesan Kuliner Sekarang',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF1E232A),
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Tombol 2: Jelajahi Peta Warung Kuliner
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WarungListPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _secondaryGreen,
                          side: const BorderSide(
                            color: Color(0x33FFFFFF),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '🗺️ Jelajahi Peta Warung Kuliner',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Kolase Foto Kuliner Pasar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        height: 155,
                        color: const Color(0xFF0F261C),
                        child: Stack(
                          children: [
                            // 4 Grid Gambar
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=300&q=80',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=300&q=80',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=300&q=80',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=300&q=80',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Overlay Gradasi Hitam Transparan
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x1A000000),
                                    Color(0xB3000000),
                                  ],
                                ),
                              ),
                            ),

                            // Badge Oranye Kanan Atas: 40+ Warung Aktif
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _accentOrange,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '40+ Warung Aktif',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Teks Kiri Bawah
                            Positioned(
                              left: 12,
                              bottom: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ragam Kuliner Pasar',
                                    style: GoogleFonts.playfairDisplay(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Dari 40+ warung legendaris',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white70,
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==========================================
              // 3. BAGIAN: PILIH KULINER FAVORITMU
              // ==========================================
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pilih kuliner favoritmu',
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Pilih kategori, kami arahkan ke warung dengan menu siap masak hari ini.',
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorMuted,
                        fontSize: 11.5,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Grid Kategori (2x2)
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.lunch_dining_rounded,
                            iconColor: const Color(0xFFD97706),
                            iconBgColor: const Color(0xFFFEF3C7),
                            title: 'Makanan Berat',
                            subtitle: '16 warung',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.outdoor_grill_rounded,
                            iconColor: const Color(0xFFB45309),
                            iconBgColor: const Color(0xFFFED7AA),
                            title: 'Sate & Bakar',
                            subtitle: '8 warung',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.cake_rounded,
                            iconColor: const Color(0xFF16A34A),
                            iconBgColor: const Color(0xFFDCFCE7),
                            title: 'Jajanan Manis',
                            subtitle: '16 warung',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.coffee_rounded,
                            iconColor: const Color(0xFF9A3412),
                            iconBgColor: const Color(0xFFFFEDD5),
                            title: 'Kopi & Minuman',
                            subtitle: '7 warung',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ==========================================
              // 4. BAGIAN: WARUNG KULINER FAVORIT MINGGU INI
              // ==========================================
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warung kuliner favorit minggu ini',
                      style: GoogleFonts.playfairDisplay(
                        color: _textColorDark,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Dipilih dari rating dan kecepatan penyajian.',
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorMuted,
                        fontSize: 11.5,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // =========================================================================
                    // KHUSUS BAGIAN INI:
                    // Daftar kartu warung kuliner favorit dibungkus dengan widget InkWell.
                    // Di dalam callback onTap-nya terdapat Navigator.push yang mengarahkan
                    // pengguna ke DetailWarungPage beserta data warung terkait.
                    // =========================================================================
                    ListView.separated(
                      itemCount: _warungFavoritList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final warung = _warungFavoritList[index];

                        // <<<<<<<<<< INKWELL PEMBUNGKUS KARTU WARUNG >>>>>>>>>>
                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            // ----------------------------------------------------
                            // NAVIGATOR.PUSH MENUJU DETAIL WARUNG PAGE DI SINI:
                            // ----------------------------------------------------
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailWarungPage(
                                    warung: warung,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _borderColor),
                              ),
                              child: Row(
                                children: [
                                  // Foto Warung
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: 72,
                                      height: 72,
                                      child: Image.network(
                                        warung.heroImageUrl,
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

                                  // Detail Teks Warung
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Nama Warung
                                        Text(
                                          warung.name,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: _textColorDark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        // Rating & Waktu Operasional / Estimasi
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFD97706),
                                              size: 16,
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              warung.rating.toString(),
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFFD97706),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              warung.openingHours,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: _textColorMuted,
                                                fontSize: 11.5,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        // Kategori Tag
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3F1E9),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            warung.category,
                                            style: GoogleFonts.plusJakartaSans(
                                              color: _textColorDark,
                                              fontSize: 10.5,
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
                        );
                      },
                    ),
                  ],
                ),
              ),

              // ==========================================
              // 5. FOOTER COPYRIGHT (Hijau Gelap)
              // ==========================================
              Container(
                color: const Color(0xFF0F261C),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      // 6. BOTTOM NAVIGATION BAR
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
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WarungListPage(),
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

  // Helper Widget: Kartu Kategori Kuliner
  Widget _buildCategoryCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: _textColorDark,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              color: _textColorMuted,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}

