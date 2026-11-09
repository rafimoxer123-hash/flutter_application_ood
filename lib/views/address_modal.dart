import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modal Bottom Sheet untuk mengubah atau memilih alamat pengiriman
void showDeliveryAddressModal(
  BuildContext context, {
  String currentAddress = 'Jl. Veteran No. 12, Malang',
  Function(String newAddress)? onAddressSelected,
}) {
  const Color primaryGreen = Color(0xFF16392A);
  const Color textColorDark = Color(0xFF1E232A);
  const Color textColorMuted = Color(0xFF78716C);
  const Color borderColor = Color(0xFFE5E2D9);

  final List<Map<String, String>> addresses = [
    {
      'label': 'Alamat Utama',
      'address': 'Jl. Veteran No. 12, Malang',
      'detail': 'Rumah pagar hitam, samping warung kelontong',
    },
    {
      'label': 'Kantor / Kampus',
      'address': 'Jl. Bandung No. 5, Klojen, Malang',
      'detail': 'Gedung Fakultas, Lt. 2',
    },
    {
      'label': 'Rumah Keluarga',
      'address': 'Jl. Ijen No. 42, Malang',
      'detail': 'Dekat bundaran Ijen',
    },
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Garis handle atas
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Judul Modal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Alamat Pengiriman',
                    style: GoogleFonts.playfairDisplay(
                      color: textColorDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close, color: textColorMuted, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Pesanan kuliner pasar akan dikirimkan ke alamat ini.',
                style: GoogleFonts.plusJakartaSans(
                  color: textColorMuted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),

              // Daftar Alamat Tersimpan
              ...addresses.map((addr) {
                final isSelected = addr['address'] == currentAddress;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFF1F8F4) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? primaryGreen : borderColor,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: isSelected
                          ? primaryGreen
                          : const Color(0xFFF3F4F6),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: isSelected ? Colors.white : textColorMuted,
                        size: 18,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          addr['label']!,
                          style: GoogleFonts.plusJakartaSans(
                            color: textColorDark,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Aktif',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          addr['address']!,
                          style: GoogleFonts.plusJakartaSans(
                            color: textColorDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          addr['detail']!,
                          style: GoogleFonts.plusJakartaSans(
                            color: textColorMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: [API Connection] Simpan preferensi alamat aktif ke server (PUT /api/v1/user/address)
                      if (onAddressSelected != null) {
                        onAddressSelected(addr['address']!);
                      }
                      Navigator.pop(ctx);
                    },
                  ),
                );
              }),

              const SizedBox(height: 8),

              // Tombol Tambah Alamat Baru
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Formulir Tambah Alamat Baru dibuka.'),
                        backgroundColor: primaryGreen,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_location_alt_outlined,
                      size: 18, color: primaryGreen),
                  label: Text(
                    'Tambah Alamat Baru',
                    style: GoogleFonts.plusJakartaSans(
                      color: primaryGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

