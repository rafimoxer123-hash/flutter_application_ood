import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_warung_page.dart';
import 'warung_list_page.dart';
import 'shopping_cart_page.dart';
import 'notifikasi_page.dart';
import 'akun_page.dart';
import 'kategori_kuliner_page.dart';
import '../viewmodels/order_manager.dart';
import '../models/warung_data.dart';
import '../services/ai_assistant_service.dart';
import 'address_modal.dart';
import 'main_tab_controller.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller untuk kolom pencarian cerdas AI
  final TextEditingController _searchController = TextEditingController();

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _secondaryGreen = Color(0xFF1F4836);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _accentOrange = Color(0xFFDE8A36);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);

  // Sumber data daftar warung kuliner
  final List<WarungModel> _allWarungs = WarungData.allWarungs;

  @override
  void initState() {
    super.initState();
    // Inisialisasi tab awal dari properti widget jika disediakan
    if (widget.initialIndex >= 0 && widget.initialIndex <= 3) {
      MainTabController.currentTab.value = widget.initialIndex;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Hasil filter inferensi AI pencarian
  AiSearchResult get _currentAiResult {
    final query = _searchController.text.trim();
    return AiSearchHelper.filterWarungs(
      query: query,
      allWarungs: _allWarungs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: MainTabController.currentTab,
      builder: (context, currentNavIndex, _) {
        return Scaffold(
          backgroundColor: _bodyBackground,
          // ==========================================
          // 1. SISTEM NAVIGASI UTAMA (IndexedStack)
          // Menyimpan status halaman & scroll saat berpindah tab
          // ==========================================
          body: IndexedStack(
            index: currentNavIndex,
            children: [
              _buildBerandaView(),
              const WarungListPage(isEmbedded: true),
              const ShoppingCartPage(isEmbedded: true),
              const AkunPage(isEmbedded: true),
            ],
          ),

          // ==========================================
          // 2. FLOATING ACTION BUTTON (ASISTEN AI)
          // Tampil pada tab Beranda untuk kemudahan akses
          // ==========================================
          floatingActionButton: currentNavIndex == 0
              ? FloatingActionButton.extended(
                  onPressed: () {
                    showAiCulinaryAssistantModal(
                      context,
                      onOpenCart: () => MainTabController.switchTab(2),
                    );
                  },
                  backgroundColor: _primaryGreen,
                  elevation: 4,
                  icon: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF86EFAC),
                    size: 20,
                  ),
                  label: Text(
                    'Tanya Asisten AI',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : null,

          // ==========================================
          // 3. BOTTOM NAVIGATION BAR TUNGGAL PERSISTEN
          // ==========================================
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: _borderColor, width: 1),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: currentNavIndex,
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
      },
    );
  }

  // ===========================================================================
  // TAMPILAN VIEW TAB BERANDA (INDEX 0)
  // ===========================================================================
  Widget _buildBerandaView() {
    final aiResult = _currentAiResult;
    final isSearching = _searchController.text.trim().isNotEmpty;
    final warungList = isSearching ? aiResult.warungs : _allWarungs.take(3).toList();

    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==========================================
            // HEADER TOP BAR & ALAMAT
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
                            // Berpindah ke Tab Keranjang
                            onTap: () {
                              MainTabController.switchTab(2);
                            },
                          ),
                          const SizedBox(width: 8),
                          _buildTopCircleButton(
                            icon: Icons.person_outline_rounded,
                            iconColor: const Color(0xFF2563EB),
                            // Berpindah ke Tab Akun
                            onTap: () {
                              MainTabController.switchTab(3);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Header Lokasi Pengiriman Interaktif (Ubah Alamat)
                  InkWell(
                    onTap: () => showDeliveryAddressModal(context),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
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
                  ),

                  const SizedBox(height: 10),

                  // ==========================================
                  // FITUR A: SEARCH BAR PENCARIAN CERDAS AI
                  // ==========================================
                  Container(
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
                          Icons.auto_awesome,
                          color: Color(0xFF10B981),
                          size: 19,
                        ),
                        hintText: 'Tanya AI: cari nasi liwet, sate, menu murah...',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
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

                  const SizedBox(height: 10),

                  // Chip Saran Cepat AI
                  SizedBox(
                    height: 32,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AiSearchHelper.aiSuggestionChips.length,
                      itemBuilder: (context, index) {
                        final chipText = AiSearchHelper.aiSuggestionChips[index];
                        final isSelected = _searchController.text == chipText;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _searchController.clear();
                                } else {
                                  _searchController.text = chipText;
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? _primaryGreen
                                    : const Color(0xFFF0FDF4),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? _primaryGreen
                                      : const Color(0xFFBBF7D0),
                                ),
                              ),
                              child: Text(
                                chipText,
                                style: GoogleFonts.plusJakartaSans(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF166534),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
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
            // KARTU STATUS PESANAN AKTIF (ORDER TRACKING)
            // Terupdate otomatis setelah transaksi divalidasi
            // ==========================================
            AnimatedBuilder(
              animation: OrderManager.instance,
              builder: (context, _) {
                if (OrderManager.instance.activeOrders.isEmpty) {
                  return const SizedBox.shrink();
                }

                final latestOrder = OrderManager.instance.activeOrders.first;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE8F5E9), Color(0xFFD1E7DD)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFA3CFBB)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: _primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.moped_rounded,
                            color: Color(0xFF86EFAC),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Pesanan Aktif Sedang Diantar!',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: _primaryGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 1.5),
                                    decoration: BoxDecoration(
                                      color: _primaryGreen,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Live',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${latestOrder.warungName} · Estimasi ${latestOrder.estimatedTime}',
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFF14532D),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            MainTabController.switchTab(3); // Arahkan ke Akun
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: _primaryGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Lacak',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // ==========================================
            // FITUR B: BANNER INTERAKTIF ASISTEN AI
            // "Bingung Mau Makan Apa Hari Ini?"
            // ==========================================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF16392A), Color(0xFF225740)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome_rounded,
                                color: Color(0xFF86EFAC),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Bingung Mau Makan Apa?',
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ceritakan budget dan seleramu, biar Asisten AI Oro-Oro Dowo yang carikan!',
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFFCDE2D6),
                              fontSize: 11.5,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              showAiCulinaryAssistantModal(
                                context,
                                onOpenCart: () => MainTabController.switchTab(2),
                              );
                            },
                            icon: const Icon(
                              Icons.smart_toy_outlined,
                              size: 15,
                              color: Color(0xFF1E232A),
                            ),
                            label: Text(
                              '✨ Tanya Asisten AI',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF1E232A),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF86EFAC),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0x1AFFFFFF),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0x33FFFFFF)),
                      ),
                      child: const Icon(
                        Icons.restaurant_menu_rounded,
                        color: Color(0xFF86EFAC),
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // TAMPILAN HASIL PENCARIAN CERDAS AI (JIKA USER MENCARI SESUATU)
            if (isSearching) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome,
                              color: Color(0xFF10B981), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            aiResult.aiBadgeText,
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        aiResult.aiExplanation,
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorMuted,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // ==========================================
            // HERO BANNER HIJAU GELAP
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
                      // Berpindah ke Tab Warung (Index 1)
                      onPressed: () {
                        MainTabController.switchTab(1);
                      },
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
                      // Berpindah ke Tab Warung (Index 1)
                      onPressed: () {
                        MainTabController.switchTab(1);
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
                ],
              ),
            ),

            // ==========================================
            // BAGIAN: PILIH KULINER FAVORITMU (KATEGORI)
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KategoriKulinerPage(
                                  initialCategory: 'Makanan Berat',
                                ),
                              ),
                            );
                          },
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KategoriKulinerPage(
                                  initialCategory: 'Sate & Bakar',
                                ),
                              ),
                            );
                          },
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KategoriKulinerPage(
                                  initialCategory: 'Jajanan Manis',
                                ),
                              ),
                            );
                          },
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KategoriKulinerPage(
                                  initialCategory: 'Kopi & Minuman',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ==========================================
            // BAGIAN: WARUNG KULINER FAVORIT
            // ==========================================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isSearching
                            ? 'Hasil Rekomendasi'
                            : 'Warung kuliner favorit minggu ini',
                        style: GoogleFonts.playfairDisplay(
                          color: _textColorDark,
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          MainTabController.switchTab(1);
                        },
                        child: Text(
                          'Lihat semua',
                          style: GoogleFonts.plusJakartaSans(
                            color: _primaryGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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

                  // Daftar kartu warung
                  ListView.separated(
                    itemCount: warungList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final warung = warungList[index];

                      return Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        warung.name,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: _textColorDark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
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
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFFD97706),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            warung.openingHours,
                                            style: GoogleFonts.plusJakartaSans(
                                              color: _textColorMuted,
                                              fontSize: 11.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
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
            // FOOTER COPYRIGHT (Hijau Gelap)
            // ==========================================
            Container(
              color: const Color(0xFF0F261C),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
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
        ),
      ),
    );
  }
}
