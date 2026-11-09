import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'validasi_transaksi_page.dart';

class PilihPembayaranPage extends StatefulWidget {
  final int? totalAmount;
  final String? initialMethod;

  const PilihPembayaranPage({
    super.key,
    this.totalAmount = 38000,
    this.initialMethod = 'QRIS (GoPay, OVO, ShopeePay, Dana)',
  });

  @override
  State<PilihPembayaranPage> createState() => _PilihPembayaranPageState();
}

class _PilihPembayaranPageState extends State<PilihPembayaranPage> {
  // Skema warna konsisten Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE5E2D9);

  // Akses data dengan fallback aman (mencegah null assertion crash)
  
  // Metode pembayaran yang dipilih
  late String _selectedMethod;

  // Controller untuk kode promo
  final TextEditingController _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.initialMethod ?? 'QRIS (GoPay, OVO, ShopeePay, Dana)';
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  // Format mata uang Rupiah tanpa spasi (Rp38.000)
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
      appBar: AppBar(
        backgroundColor: _primaryGreen,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          // Tombol panah kembali ke halaman sebelumnya
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Pilih Metode Pembayaran',
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // 1. KARTU TOTAL TAGIHAN
              // ==========================================
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Tagihan:',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '2 menu + ongkir',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _formatCurrency(widget.totalAmount ?? 38000),
                      style: GoogleFonts.plusJakartaSans(
                        color: _primaryGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================
              // 2. KELOMPOK: E-WALLET / INSTANT
              // ==========================================
              Text(
                'E-Wallet / Instant',
                style: GoogleFonts.plusJakartaSans(
                  color: _textColorDark,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              _buildPaymentOption(
                title: 'QRIS (GoPay, OVO, ShopeePay, Dana)',
                subtitle: 'Scan QR dengan e-wallet pilihanmu',
                icon: Icons.qr_code_scanner_rounded,
                value: 'QRIS (GoPay, OVO, ShopeePay, Dana)',
              ),
              const SizedBox(height: 10),

              _buildPaymentOption(
                title: 'GoPay Auto-deduct',
                subtitle: 'Bayar langsung dari saldo GoPay',
                icon: Icons.account_balance_wallet_outlined,
                value: 'GoPay Auto-deduct',
              ),

              const SizedBox(height: 18),

              // ==========================================
              // 3. KELOMPOK: TRANSFER BANK (VIRTUAL ACCOUNT)
              // ==========================================
              Text(
                'Transfer Bank (Virtual Account)',
                style: GoogleFonts.plusJakartaSans(
                  color: _textColorDark,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              _buildBankOption(
                bankName: 'BCA',
                title: 'BCA Virtual Account',
                value: 'BCA Virtual Account',
              ),
              const SizedBox(height: 10),

              _buildBankOption(
                bankName: 'Mandiri',
                title: 'Mandiri Virtual Account',
                value: 'Mandiri Virtual Account',
              ),
              const SizedBox(height: 10),

              _buildBankOption(
                bankName: 'BRI',
                title: 'BRI Virtual Account',
                value: 'BRI Virtual Account',
              ),

              const SizedBox(height: 18),

              // ==========================================
              // 4. KELOMPOK: CASH
              // ==========================================
              Text(
                'Cash',
                style: GoogleFonts.plusJakartaSans(
                  color: _textColorDark,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              _buildPaymentOption(
                title: 'Bayar di Tempat (COD)',
                subtitle: 'Bayar tunai saat pesanan tiba',
                icon: Icons.payments_outlined,
                value: 'Bayar di Tempat (COD)',
              ),

              const SizedBox(height: 18),

              // ==========================================
              // 5. KARTU KODE PROMO
              // ==========================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
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
                        const Icon(
                          Icons.confirmation_number_outlined,
                          color: Color(0xFFD97706),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Punya kode promo?',
                          style: GoogleFonts.plusJakartaSans(
                            color: _textColorDark,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _borderColor),
                            ),
                            child: TextField(
                              controller: _promoController,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: _textColorDark,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Makin hemat pakai promo',
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: const Color(0xFF9CA3AF),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          // Aksi menerapkan kode promo
                          onPressed: () {
                            final code = _promoController.text.trim();
                            if (code.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Kode promo "$code" berhasil diterapkan!'),
                                  backgroundColor: _primaryGreen,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryGreen,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Gunakan',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ==========================================
              // 6. TOMBOL AKSI: GUNAKAN METODE INI
              // ==========================================
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  // Navigasi ke ValidasiTransaksiPage setelah memilih metode pembayaran
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ValidasiTransaksiPage(
                          totalPayment: widget.totalAmount,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Gunakan Metode Ini',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Catatan keamanan transaksi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.security_rounded,
                    size: 14,
                    color: Color(0xFF78716C),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Transaksi aman, belanja nyaman.',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF78716C),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget: Kartu opsi pembayaran umum (E-wallet / Cash)
  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final isSelected = _selectedMethod == value;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Callback saat memilih opsi pembayaran
        onTap: () {
          setState(() {
            _selectedMethod = value;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? _primaryGreen : _borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: _primaryGreen, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorDark,
                        fontSize: 12.5,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        color: _textColorMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? _primaryGreen : const Color(0xFFD1D5DB),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: _primaryGreen,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget: Kartu opsi Transfer Bank
  Widget _buildBankOption({
    required String bankName,
    required String title,
    required String value,
  }) {
    final isSelected = _selectedMethod == value;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Callback saat memilih bank virtual account
        onTap: () {
          setState(() {
            _selectedMethod = value;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? _primaryGreen : _borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  bankName,
                  style: GoogleFonts.plusJakartaSans(
                    color: _textColorDark,
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: _textColorDark,
                    fontSize: 12.5,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? _primaryGreen : const Color(0xFFD1D5DB),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: _primaryGreen,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
