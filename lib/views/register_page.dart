import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk setiap kolom input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State untuk visibilitas sandi dan persetujuan syarat & ketentuan
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  // Skema warna sesuai desain Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _accentOrange = Color(0xFFC67C26);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE2E0D8);

  @override
  void dispose() {
    _nameController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ==========================================
                    // 1. HEADER SECTION (Hijau Gelap)
                    // ==========================================
                    Container(
                      width: double.infinity,
                      color: _primaryGreen,
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Bar: Tombol Kembali & Logo Brand
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Tombol Kembali
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: const Color(0x0FFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: const Color(0x33FFFFFF),
                                            width: 1,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Logo & Nama Brand
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Transform.rotate(
                                        angle: -0.25,
                                        child: const Icon(
                                          Icons.eco_rounded,
                                          color: Color(0xFF86EFAC),
                                          size: 19,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Pasar Oro-Oro Dowo',
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.white,
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Aksen Garis Oranye
                              Container(
                                width: 34,
                                height: 3.5,
                                decoration: BoxDecoration(
                                  color: _accentOrange,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Judul Halaman
                              Text(
                                'Buat Akun Baru',
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Subjudul
                              Text(
                                'Daftar untuk menikmati kuliner khas Pasar Oro-Oro Dowo.',
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFFBACBC2),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ==========================================
                    // 2. FORM BODY SECTION (Krem / Off-White)
                    // ==========================================
                    Expanded(
                      child: Container(
                        color: _bodyBackground,
                        child: SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 24,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Kolom 1: Nama Lengkap
                                _buildFieldLabel('Nama Lengkap'),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: _nameController,
                                  hintText: 'Masukkan nama lengkap',
                                  textCapitalization: TextCapitalization.words,
                                ),

                                const SizedBox(height: 16),

                                // Kolom 2: Nomor WhatsApp
                                _buildFieldLabel('Nomor WhatsApp'),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: _whatsappController,
                                  hintText: 'Contoh: 0812 3456 7890',
                                  keyboardType: TextInputType.phone,
                                ),

                                const SizedBox(height: 16),

                                // Kolom 3: Email
                                _buildFieldLabel('Email'),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: _emailController,
                                  hintText: 'nama@email.com',
                                  keyboardType: TextInputType.emailAddress,
                                ),

                                const SizedBox(height: 16),

                                // Kolom 4: Kata Sandi
                                _buildFieldLabel('Kata Sandi'),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: _passwordController,
                                  hintText: 'Buat kata sandi',
                                  obscureText: _obscurePassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xFF6B7280),
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),

                                const SizedBox(height: 6),

                                // Hint / Helper Text Kata Sandi
                                Text(
                                  'Gunakan minimal 8 karakter.',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: _textColorMuted,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Checkbox: Persetujuan Syarat & Ketentuan
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: _agreeToTerms,
                                        activeColor: _primaryGreen,
                                        checkColor: Colors.white,
                                        side: const BorderSide(
                                          color: Color(0xFFD1D5DB),
                                          width: 1.5,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            _agreeToTerms = value ?? false;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _agreeToTerms = !_agreeToTerms;
                                          });
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Saya menyetujui ',
                                            style:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF374151),
                                              fontSize: 12.5,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Syarat & Ketentuan',
                                                style: GoogleFonts
                                                    .plusJakartaSans(
                                                  color: _textColorDark,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 22),

                                // Tombol Utama: Daftar Akun
                                SizedBox(
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (!_agreeToTerms) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Harap setujui Syarat & Ketentuan terlebih dahulu.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                        return;
                                      }

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Pendaftaran berhasil! Mengarahkan ke halaman masuk...'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );

                                      // Navigasi kembali ke LoginPage setelah pendaftaran berhasil
                                      final nav = Navigator.of(context);
                                      Future.delayed(
                                          const Duration(milliseconds: 600), () {
                                        if (mounted) {
                                          if (nav.canPop()) {
                                            nav.pop();
                                          } else {
                                            nav.pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage(),
                                              ),
                                            );
                                          }
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _primaryGreen,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Daftar Akun',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Tautan Balik ke Halaman Masuk / Login
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (Navigator.canPop(context)) {
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ),
                                        );
                                      }
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Sudah punya akun? ',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF4B5563),
                                          fontSize: 13,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Masuk',
                                            style:
                                                GoogleFonts.plusJakartaSans(
                                              color: _textColorDark,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Spacer agar footer berada di bagian paling bawah layar
                                const Spacer(),
                                const SizedBox(height: 32),

                                // Footer Slogan
                                Column(
                                  children: [
                                    Text(
                                      'Dari pasar, untuk kamu.',
                                      style: GoogleFonts.playfairDisplay(
                                        color: _primaryGreen,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Pasar Oro-Oro Dowo · Malang',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: _textColorMuted,
                                        fontSize: 11.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
    );
  }

  // Helper Widget: Label Kolom Input
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        color: _textColorDark,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // Helper Widget: Input Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      style: GoogleFonts.plusJakartaSans(
        color: _textColorDark,
        fontSize: 13.5,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: const Color(0xFF9CA3AF),
          fontSize: 13.5,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _primaryGreen, width: 1.5),
        ),
      ),
    );
  }
}
