import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form key untuk validasi
  final _formKey = GlobalKey<FormState>();

  // Controller untuk setiap kolom input
  final TextEditingController _identifierController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  // State untuk toggle visibilitas kata sandi
  bool _obscurePassword = true;

  // Skema warna sesuai desain Pasar Oro-Oro Dowo
  static const Color _primaryGreen = Color(0xFF16392A);
  static const Color _bodyBackground = Color(0xFFF9F8F3);
  static const Color _accentOrange = Color(0xFFC67C26);
  static const Color _textColorDark = Color(0xFF1E232A);
  static const Color _textColorMuted = Color(0xFF78716C);
  static const Color _borderColor = Color(0xFFE2E0D8);

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validator Nomor HP / Email
  String? _validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor HP atau email wajib diisi';
    }

    final input = value.trim();

    final emailRegex =
        RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

    if (!emailRegex.hasMatch(input) &&
        !phoneRegex.hasMatch(input)) {
      return 'Masukkan email atau nomor HP yang valid';
    }

    return null;
  }

  // Validator Kata Sandi
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi wajib diisi';
    }

    if (value.length < 8) {
      return 'Kata sandi minimal 8 karakter';
    }

    return null;
  }

  // Fungsi Login
  void _login() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
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
                    // 1. HEADER SECTION
                    // ==========================================
                    Container(
                      width: double.infinity,
                      color: _primaryGreen,
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              20, 16, 20, 28),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              // Tombol Kembali dan Logo
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      child: Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color:
                                              const Color(0x0FFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color:
                                                const Color(0x33FFFFFF),
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
                                        style: GoogleFonts
                                            .playfairDisplay(
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
                                  borderRadius:
                                      BorderRadius.circular(2),
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Judul Halaman
                              Text(
                                'Selamat Datang Kembali!',
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
                                'Masuk ke akun Pasar Oro-Oro Dowo kamu.',
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
                    // 2. FORM BODY SECTION
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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  // Kolom Nomor HP / Email
                                  _buildFieldLabel(
                                      'Nomor HP / Email'),
                                  const SizedBox(height: 8),

                                  _buildTextField(
                                    controller:
                                        _identifierController,
                                    hintText:
                                        'Masukkan nomor HP atau email',
                                    keyboardType:
                                        TextInputType.emailAddress,
                                    validator: _validateIdentifier,
                                  ),

                                  const SizedBox(height: 18),

                                  // Kolom Kata Sandi
                                  _buildFieldLabel('Kata Sandi'),
                                  const SizedBox(height: 8),

                                  _buildTextField(
                                    controller: _passwordController,
                                    hintText:
                                        'Masukkan kata sandi',
                                    obscureText: _obscurePassword,
                                    validator: _validatePassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons
                                                .visibility_off_outlined,
                                        color:
                                            const Color(0xFF6B7280),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword =
                                              !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Link Lupa Kata Sandi
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Fitur Lupa Kata Sandi ditekan',
                                            ),
                                            duration:
                                                Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Lupa Kata Sandi?',
                                        style:
                                            GoogleFonts.plusJakartaSans(
                                          color: _accentOrange,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 22),

                                  // Tombol Masuk
                                  SizedBox(
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: _login,
                                      style:
                                          ElevatedButton.styleFrom(
                                        backgroundColor:
                                            _primaryGreen,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'Masuk',
                                        style:
                                            GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 22),

                                  // Pembatas
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Divider(
                                          color: Color(0xFFDEDBD2),
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        child: Text(
                                          'atau masuk dengan',
                                          style: GoogleFonts
                                              .plusJakartaSans(
                                            color: _textColorMuted,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Divider(
                                          color: Color(0xFFDEDBD2),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 22),

                                  // Tautan ke Halaman Daftar
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage(),
                                          ),
                                        );
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Belum punya akun? ',
                                          style: GoogleFonts
                                              .plusJakartaSans(
                                            color:
                                                const Color(0xFF4B5563),
                                            fontSize: 13,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Daftar Sekarang',
                                              style: GoogleFonts
                                                  .plusJakartaSans(
                                                color: _textColorDark,
                                                fontWeight:
                                                    FontWeight.bold,
                                                decoration:
                                                    TextDecoration
                                                        .underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Spacer untuk footer
                                  const Spacer(),
                                  const SizedBox(height: 32),

                                  // Footer Slogan
                                  Column(
                                    children: [
                                      Text(
                                        'Dari pasar, untuk kamu.',
                                        style: GoogleFonts
                                            .playfairDisplay(
                                          color: _primaryGreen,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Pasar Oro-Oro Dowo · Malang',
                                        style: GoogleFonts
                                            .plusJakartaSans(
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

  // Helper Widget: Input Text Field dengan Validator
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon: suffixIcon,
        errorStyle: GoogleFonts.plusJakartaSans(
          fontSize: 11.5,
          color: Colors.red.shade700,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: _borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: _borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: _primaryGreen,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}