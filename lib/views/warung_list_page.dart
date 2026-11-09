import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_warung_page.dart';
import 'shopping_cart_page.dart';
import 'home_page.dart';
import 'notifikasi_page.dart';
import 'akun_page.dart';
import '../models/warung_data.dart';
import '../services/ai_assistant_service.dart';
import 'address_modal.dart';
import 'main_tab_controller.dart';

class WarungListPage extends StatefulWidget {
  final bool isEmbedded;
  const WarungListPage({super.key, this.isEmbedded = false});

  @override
  State<WarungListPage> createState() => _WarungListPageState();
}

class _WarungListPageState extends State<WarungListPage> {
  // Controller untuk kolom pencarian nama warung atau menu
  final TextEditingController _searchController = TextEditingController();

  // Tab aktif pada Bottom Navigation Bar (Index 1: Warung)
  final int _currentNavIndex = 1;

  // Kategori filter yang sedang aktif
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    'Semua',
    'Makanan Berat',
    'Sate & Bakar',
    'Jajanan Manis',
    'Kopi & Minuman',
  ];

  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);
  static const Color _accentOrange = Color(0xFFDE8A36);

  // Sumber data daftar warung kuliner terpusat
  final List<WarungModel> _allWarungs = WarungData.allWarungs;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Logika filter gabungan Kategori Tab dan AI Search
  AiSearchResult get _currentAiResult {
    final query = _searchController.text.trim();

    // Jika ada input search teks / chip AI yang aktif
    if (query.isNotEmpty) {
      return AiSearchHelper.filterWarungs(
        query: query,
        allWarungs: _allWarungs,
      );
    }

    // Jika filter kategori aktif
    if (_selectedCategory != 'Semua') {
      final categoryFiltered = _allWarungs
          .where((w) =>
              w.category.toLowerCase() == _selectedCategory.toLowerCase())
          .toList();
      return AiSearchResult(
        warungs: categoryFiltered,
        aiBadgeText: 'Kategori: $_selectedCategory',
        aiExplanation:
            'Menampilkan warung dalam kategori $_selectedCategory di Pasar Oro-Oro Dowo.',
      );
    }

    return AiSearchResult(
      warungs: _allWarungs,
      aiBadgeText: 'Semua Warung Aktif',
      aiExplanation: '40+ warung kuliner aktif dan siap melayani pesanan hari ini.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final aiResult = _currentAiResult;
    final warungList = aiResult.warungs;

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
                        // Berpindah ke Halaman Keranjang
                        onTap: () {
                          MainTabController.switchTab(2);
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildTopCircleButton(
                        icon: Icons.person_outline_rounded,
                        iconColor: const Color(0xFF2563EB),
                        // Berpindah ke Halaman Akun
                        onTap: () {
                          MainTabController.switchTab(3);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Header Alamat Pengiriman Interaktif
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () => showDeliveryAddressModal(context),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Color(0xFFE11D48), size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Dikirim ke ',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorMuted,
                              fontSize: 11.5,
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
            ),

            const SizedBox(height: 10),

            // ==========================================
            // 2. FITUR AI: SEARCH BAR PENCARIAN CERDAS
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
                      Icons.auto_awesome,
                      color: Color(0xFF10B981),
                      size: 18,
                    ),
                    hintText: "Pencarian Cerdas AI: cari sarapan, menu murah...",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12,
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

            const SizedBox(height: 10),

            // Chip Saran Cepat AI
            SizedBox(
              height: 32,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

            const SizedBox(height: 12),

            // ==========================================
            // 3. HEADER JUDUL & KATEGORI FILTER
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
                        'Peta Warung Kuliner',
                        style: GoogleFonts.playfairDisplay(
                          color: _textColorDark,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${warungList.length} warung',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF15803D),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
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

            const SizedBox(height: 10),

            // Kategori Chips (Semua, Makanan Berat, Sate & Bakar, Jajanan Manis, Kopi)
            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: _primaryGreen,
                      backgroundColor: Colors.white,
                      labelStyle: GoogleFonts.plusJakartaSans(
                        color: isSelected ? Colors.white : _textColorDark,
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                      side: BorderSide(
                        color: isSelected ? _primaryGreen : _borderColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = cat;
                            _searchController.clear();
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ==========================================
            // 4. DAFTAR KARTU WARUNG
            // ==========================================
            Expanded(
              child: warungList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.storefront_outlined,
                              size: 48, color: Colors.grey),
                          const SizedBox(height: 12),
                          Text(
                            'Tidak ada warung yang cocok dengan kriteria',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _selectedCategory = 'Semua';
                              });
                            },
                            child: const Text('Reset Pencarian'),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                      itemCount: warungList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final warung = warungList[index];
                        return _buildWarungCard(warung);
                      },
                    ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
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
                currentIndex: _currentNavIndex,
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
  }

  // Widget Kartu Warung Kuliner
  Widget _buildWarungCard(WarungModel warung) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailWarungPage(warung: warung),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _borderColor),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: SizedBox(
                  width: 105,
                  height: 98,
                  child: Image.network(
                    warung.heroImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.restaurant, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        warung.name,
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorDark,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFBBF24),
                            size: 16,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${warung.rating}',
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorDark,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            warung.distance,
                            style: GoogleFonts.plusJakartaSans(
                              color: _textColorMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          warung.category,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF4B5563),
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF9CA3AF),
                  size: 14,
                ),
              ),
            ],
          ),
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
