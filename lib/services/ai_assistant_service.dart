import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/detail_warung_page.dart';
import '../viewmodels/cart_manager.dart';

/// ============================================================================
/// MODEL & LOGIKA PENCARIAN CERDAS AI (SMART NATURAL LANGUAGE SEARCH)
/// ============================================================================

/// Hasil analisis filter pencarian cerdas berbasis AI
class AiSearchResult {
  final List<WarungModel> warungs;
  final String aiBadgeText;
  final String aiExplanation;

  AiSearchResult({
    required this.warungs,
    required this.aiBadgeText,
    required this.aiExplanation,
  });
}

/// Helper Layanan AI untuk melakukan inferensi bahasa alami (NLP Simulation)
class AiSearchHelper {
  /// Chip saran cepat bawaan Asisten AI
  static const List<String> aiSuggestionChips = [
    '✨ Sarapan Legendaris',
    '✨ Di Bawah 15rb',
    '✨ Cemilan Manis Sore',
    '✨ Kopi & Hangout',
    '✨ Pedas Gurih Mantap',
  ];

  /// Logika Penyaringan Pintar berbasis AI
  /// Menganalisis kata kunci pengguna, mencocokkan intensi (budget, waktu, rasa)
  static AiSearchResult filterWarungs({
    required String query,
    required List<WarungModel> allWarungs,
  }) {
    final cleanQuery = query.replaceAll('✨', '').toLowerCase().trim();

    if (cleanQuery.isEmpty) {
      return AiSearchResult(
        warungs: allWarungs,
        aiBadgeText: 'Semua Warung Aktif',
        aiExplanation:
            'Menampilkan seluruh 40+ warung kuliner aktif di Pasar Oro-Oro Dowo.',
      );
    }

    // 1. INTENSI: Menu Hemat / Di Bawah 15rb / Murah
    // TODO: [AI Model/API Connection] Integrasi ke Gemini API: gemini-1.5-flash untuk intent parsing
    if (cleanQuery.contains('15') ||
        cleanQuery.contains('murah') ||
        cleanQuery.contains('hemat') ||
        cleanQuery.contains('terjangkau')) {
      final matched = allWarungs.where((w) {
        return w.menus.any((m) => m.price <= 15000);
      }).toList();

      return AiSearchResult(
        warungs: matched.isNotEmpty ? matched : allWarungs,
        aiBadgeText: 'Rekomendasi Hemat AI (< Rp15.000)',
        aiExplanation:
            'AI menyaring ${matched.length} warung yang menyediakan pilihan menu lezat di bawah Rp15.000.',
      );
    }

    // 2. INTENSI: Sarapan Legendaris / Pagi Hari
    if (cleanQuery.contains('sarapan') ||
        cleanQuery.contains('pagi') ||
        cleanQuery.contains('legendaris')) {
      final matched = allWarungs.where((w) {
        final hours = w.openingHours.toLowerCase();
        return hours.contains('06.') ||
            hours.contains('07.') ||
            w.name.contains('Buk') ||
            w.name.contains('Liwet');
      }).toList();

      return AiSearchResult(
        warungs: matched.isNotEmpty ? matched : allWarungs,
        aiBadgeText: 'Rekomendasi Sarapan Legendaris AI',
        aiExplanation:
            'AI memilih warung sarapan legendaris yang siap menghangatkan pagimu sejak pukul 06.00.',
      );
    }

    // 3. INTENSI: Cemilan Manis Sore / Jajanan Pasar Tradisional
    if (cleanQuery.contains('manis') ||
        cleanQuery.contains('cemil') ||
        cleanQuery.contains('kue') ||
        cleanQuery.contains('sore') ||
        cleanQuery.contains('klepon')) {
      final matched = allWarungs.where((w) {
        return w.category == 'Jajanan Manis' ||
            w.menus.any((m) =>
                m.name.toLowerCase().contains('klepon') ||
                m.name.toLowerCase().contains('teh') ||
                m.name.toLowerCase().contains('manis'));
      }).toList();

      return AiSearchResult(
        warungs: matched.isNotEmpty ? matched : allWarungs,
        aiBadgeText: 'Rekomendasi Cemilan Manis AI',
        aiExplanation:
            'AI menemukan kuliner manis tradisional cocok untuk teman ngeteh santai sore hari.',
      );
    }

    // 4. INTENSI: Kopi & Hangout / Nongkrong / Minuman Segar
    if (cleanQuery.contains('kopi') ||
        cleanQuery.contains('hangout') ||
        cleanQuery.contains('nongkrong') ||
        cleanQuery.contains('minum') ||
        cleanQuery.contains('segar')) {
      final matched = allWarungs.where((w) {
        return w.category == 'Kopi & Minuman' ||
            w.menus.any((m) =>
                m.name.toLowerCase().contains('kopi') ||
                m.name.toLowerCase().contains('teh') ||
                m.name.toLowerCase().contains('es'));
      }).toList();

      return AiSearchResult(
        warungs: matched.isNotEmpty ? matched : allWarungs,
        aiBadgeText: 'Rekomendasi Kopi & Nongkrong AI',
        aiExplanation:
            'AI merekomendasikan spot ngopi dan minuman dingin pelepas dahaga terbaik di pasar.',
      );
    }

    // 5. INTENSI: Pedas Gurih Mantap / Makanan Berat
    if (cleanQuery.contains('pedas') ||
        cleanQuery.contains('gurih') ||
        cleanQuery.contains('mantap') ||
        cleanQuery.contains('sate') ||
        cleanQuery.contains('bakar')) {
      final matched = allWarungs.where((w) {
        return w.category == 'Makanan Berat' ||
            w.category == 'Sate & Bakar' ||
            w.menus.any((m) =>
                m.name.toLowerCase().contains('bakar') ||
                m.name.toLowerCase().contains('sambal') ||
                m.name.toLowerCase().contains('sate'));
      }).toList();

      return AiSearchResult(
        warungs: matched.isNotEmpty ? matched : allWarungs,
        aiBadgeText: 'Rekomendasi Pedas & Gurih Mantap AI',
        aiExplanation:
            'AI mengelompokkan menu lauk bakar dan racikan sambal khas Jawa Timur yang mengenyangkan.',
      );
    }

    // 6. Pencarian Fleksibel / Keyword Search (Warung, Menu, Deskripsi)
    final matched = allWarungs.where((w) {
      final matchName = w.name.toLowerCase().contains(cleanQuery);
      final matchCat = w.category.toLowerCase().contains(cleanQuery);
      final matchMenu = w.menus.any((m) =>
          m.name.toLowerCase().contains(cleanQuery) ||
          m.description.toLowerCase().contains(cleanQuery));
      return matchName || matchCat || matchMenu;
    }).toList();

    return AiSearchResult(
      warungs: matched,
      aiBadgeText: 'Hasil Pencarian AI: "$query"',
      aiExplanation: matched.isNotEmpty
          ? 'AI mendeteksi ${matched.length} warung yang cocok dengan preferensimu.'
          : 'AI belum menemukan warung yang cocok persis. Coba kata kunci lain atau pilih saran cepat di atas.',
    );
  }
}

/// ============================================================================
/// WIDGET MODAL ASISTEN AI KULINER: "BINGUNG MAU MAKAN APA?"
/// ============================================================================

void showAiCulinaryAssistantModal(
  BuildContext context, {
  VoidCallback? onOpenCart,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _AiCulinaryAssistantDialog(onOpenCart: onOpenCart),
  );
}

class _AiCulinaryAssistantDialog extends StatefulWidget {
  final VoidCallback? onOpenCart;
  const _AiCulinaryAssistantDialog({this.onOpenCart});

  @override
  State<_AiCulinaryAssistantDialog> createState() =>
      _AiCulinaryAssistantDialogState();
}

class _AiCulinaryAssistantDialogState
    extends State<_AiCulinaryAssistantDialog> {
  // Skema warna khas Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _accentOrange = Color(0xFFDE8A36);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);

  // Filter yang dipilih pengguna
  String _selectedBudget = '< Rp20.000';
  final List<String> _budgetOptions = [
    '< Rp15.000',
    '< Rp20.000',
    'Rp20.000 - Rp30.000',
    'Bebas',
  ];

  String _selectedTaste = 'Gurih & Kenyang';
  final List<String> _tasteOptions = [
    'Gurih & Kenyang',
    'Manis & Legit',
    'Segar & Dingin',
    'Pedas Rempah',
  ];

  // Status simulasi inferensi AI
  bool _isLoading = false;
  bool _hasResult = false;
  List<Map<String, dynamic>> _recommendations = [];

  // Format mata uang Rupiah
  String _formatCurrency(int amount) {
    final formatted = amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return 'Rp$formatted';
  }

  // Simulasi pemrosesan rekomendasi berbasis AI
  void _getAiRecommendations() {
    setState(() {
      _isLoading = true;
      _hasResult = false;
    });

    // TODO: [API Connection] Panggil LLM Backend / Gemini API Interaction
    // Future<AiResponse> res = ApiService.getAiRecommendation(budget: _selectedBudget, taste: _selectedTaste);
    Future.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;

      List<Map<String, dynamic>> results = [];

      if (_selectedTaste == 'Gurih & Kenyang') {
        results = [
          {
            'name': 'Sego Liwet Bakar Ayam',
            'warung': 'Sego Liwet Bakar Kemangi',
            'price': 15000,
            'image':
                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Nasi liwet gurih berbalut daun pisang dengan suwiran ayam rempah. Pas dengan budgetmu!',
          },
          {
            'name': 'Nasi Pecel Komplit',
            'warung': 'Nasi Buk Hj. Supina',
            'price': 18000,
            'image':
                'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Sayuran segar kaya serat disiram bumbu kacang medok khas Jawa Timur plus rempeyek renyah.',
          },
        ];
      } else if (_selectedTaste == 'Manis & Legit') {
        results = [
          {
            'name': 'Klepon Pandan Gula Jawa',
            'warung': 'Klepon-Ku',
            'price': 12000,
            'image':
                'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Kue klepon kenyal dengan ledakan gula merah cair murni dan taburan kelapa parut gurih.',
          },
          {
            'name': 'Lupis Ketan Kelapa',
            'warung': 'Toko Kue Mbok Sum',
            'price': 15000,
            'image':
                'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Ketan pulen wangi daun pandan dengan siraman saus kinca aren kental legendaris.',
          },
        ];
      } else if (_selectedTaste == 'Segar & Dingin') {
        results = [
          {
            'name': 'Es Dawet Gula Aren',
            'warung': 'Dawet Ayu Bu Tini',
            'price': 8000,
            'image':
                'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Cendol kenyal dengan santan segar dan gula aren asli, sangat melegakan dahaga.',
          },
          {
            'name': 'Es Jeruk Peras Segar',
            'warung': 'Es Jeruk Pak Slamet',
            'price': 7000,
            'image':
                'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Jeruk peras murni tanpa pengawet yang kaya vitamin C dengan es batu kristal higienis.',
          },
        ];
      } else {
        // Pedas Rempah
        results = [
          {
            'name': 'Sego Liwet Bakar Tuna Pedas',
            'warung': 'Sego Liwet Bakar Kemangi',
            'price': 15000,
            'image':
                'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Tuna suwir pedas cabai rawit merah dan aroma daun kemangi yang membakar selera.',
          },
          {
            'name': 'Sate Mari Kerjo Bumbu Pedas',
            'warung': 'Sate Mari Kerjo (Marjo)',
            'price': 22000,
            'image':
                'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=400&q=80',
            'aiReason':
                'Daging empuk dipanggang arang batok kelapa dengan olesan bumbu rempah pedas mantap.',
          },
        ];
      }

      setState(() {
        _isLoading = false;
        _hasResult = true;
        _recommendations = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 14,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar Atas
            Center(
              child: Container(
                width: 42,
                height: 4.5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Asisten AI
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF16392A), Color(0xFF2E6F53)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF86EFAC),
                    size: 24,
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
                            'Asisten AI Kuliner',
                            style: GoogleFonts.playfairDisplay(
                              color: _textColorDark,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Smart AI',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF15803D),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Bingung mau makan apa? Ceritakan seleramu ke AI!',
                        style: GoogleFonts.plusJakartaSans(
                          color: _textColorMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: _textColorMuted),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 18),
            const Divider(color: _borderColor, height: 1),
            const SizedBox(height: 16),

            // Bagian 1: Pilihan Budget
            Text(
              '1. Berapa anggaran (budget) makanmu?',
              style: GoogleFonts.plusJakartaSans(
                color: _textColorDark,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _budgetOptions.map((budget) {
                final isSelected = _selectedBudget == budget;
                return ChoiceChip(
                  label: Text(budget),
                  selected: isSelected,
                  selectedColor: _primaryGreen,
                  backgroundColor: const Color(0xFFF9FAFB),
                  labelStyle: GoogleFonts.plusJakartaSans(
                    color: isSelected ? Colors.white : _textColorDark,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                  side: BorderSide(
                    color: isSelected ? _primaryGreen : _borderColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedBudget = budget;
                      });
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Bagian 2: Preferensi Rasa
            Text(
              '2. Ingin rasa kuliner yang seperti apa?',
              style: GoogleFonts.plusJakartaSans(
                color: _textColorDark,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tasteOptions.map((taste) {
                final isSelected = _selectedTaste == taste;
                return ChoiceChip(
                  label: Text(taste),
                  selected: isSelected,
                  selectedColor: _primaryGreen,
                  backgroundColor: const Color(0xFFF9FAFB),
                  labelStyle: GoogleFonts.plusJakartaSans(
                    color: isSelected ? Colors.white : _textColorDark,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                  side: BorderSide(
                    color: isSelected ? _primaryGreen : _borderColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedTaste = taste;
                      });
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Tombol Picu Rekomendasi AI
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _getAiRecommendations,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                label: Text(
                  _isLoading
                      ? 'AI Sedang Menganalisis Menu...'
                      : '✨ Dapatkan Rekomendasi AI',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Tampilan Hasil Rekomendasi AI
            if (_hasResult) ...[
              const SizedBox(height: 22),
              Row(
                children: [
                  const Icon(Icons.stars_rounded, color: _accentOrange, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'Pilihan Terbaik Menurut Asisten AI:',
                    style: GoogleFonts.plusJakartaSans(
                      color: _textColorDark,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ..._recommendations.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F8F3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 65,
                          height: 65,
                          child: Image.network(
                            item['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.fastfood,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name']!,
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorDark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['warung']!,
                              style: GoogleFonts.plusJakartaSans(
                                color: _textColorMuted,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['aiReason']!,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF374151),
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatCurrency(item['price'] as int),
                                  style: GoogleFonts.plusJakartaSans(
                                    color: _primaryGreen,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Tambahkan menu rekomendasi AI ke keranjang
                                    CartManager.instance.addItem(
                                      name: item['name'] as String,
                                      price: item['price'] as int,
                                      imageUrl: item['image'] as String,
                                      warungName: item['warung'] as String,
                                      quantity: 1,
                                    );

                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${item['name']} berhasil ditambahkan ke keranjang!'),
                                        backgroundColor: _primaryGreen,
                                        action: SnackBarAction(
                                          label: 'Lihat Keranjang',
                                          textColor: const Color(0xFF86EFAC),
                                          onPressed: () {
                                            if (widget.onOpenCart != null) {
                                              widget.onOpenCart!();
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _accentOrange,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    '+ Langsung Pesan',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
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
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}

