import '../views/detail_warung_page.dart';

/// Sumber Data Tunggal (Single Source of Truth) untuk Seluruh Warung & Menu Pasar Oro-Oro Dowo
class WarungData {
  static const List<WarungModel> allWarungs = [
    // 1. Nasi Buk Hj. Supina
    WarungModel(
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
          description: 'Nasi gurih, ayam goreng kampung empuk, urap & sambal bajak',
          price: 25000,
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Nasi Pecel Komplit',
          description: 'Sayur segar, bumbu kacang medok khas Blitar & rempeyek renyah',
          price: 18000,
          imageUrl:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Es Teh Manis Melati',
          description: 'Teh melati wangi, gula tebu asli & es batu kristal',
          price: 5000,
          imageUrl:
              'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),

    // 2. Sego Liwet Bakar Kemangi
    WarungModel(
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
          description: 'Nasi liwet santan, suwiran ayam gurih, kemangi harum bumbu rempah',
          price: 25000,
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Sego Liwet Bakar Tuna Pedas',
          description: 'Nasi liwet gurih berpadu tuna suwir cabai rawit pedas mantap',
          price: 25000,
          imageUrl:
              'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Sego Liwet Bakar Teri',
          description: 'Nasi liwet dengan ikan teri gurih asin dan cabai rawit utuh',
          price: 15000,
          imageUrl:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Es Teh Manis Segar',
          description: 'Teh melati seduh segar dengan gula asli',
          price: 5000,
          imageUrl:
              'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),

    // 3. Sate Mari Kerjo (Marjo)
    WarungModel(
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
          description: '10 tusuk sate ayam lembut, bumbu kacang kental & lontong pulen',
          price: 22000,
          imageUrl:
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Sate Kambing Muda',
          description: '10 tusuk daging kambing muda empuk tanpa aroma perengus',
          price: 35000,
          imageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),

    // 4. Klepon-Ku
    WarungModel(
      name: 'Klepon-Ku',
      rating: 4.8,
      address: 'Pasar Oro-Oro Dowo',
      reviewsCount: 76,
      distance: 'Kuliner · No. 19',
      openingHours: '06.30 - 14.00',
      priceRange: 'Rp 10.000–20.000',
      category: 'Jajanan Manis',
      heroImageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=600&q=80',
      menus: [
        WarungMenuItem(
          name: 'Klepon Pandan Isi Gula Jawa',
          description: 'Kue kenyal ketan pandan isi gula aren cair meleleh isi 10 pcs',
          price: 12000,
          imageUrl:
              'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Lupis Ketan Kelapa Parut',
          description: 'Ketan segitiga pulen dibalut parutan kelapa & saus kinca aren',
          price: 15000,
          imageUrl:
              'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),

    // 5. Kopi Pasar Pak Budi
    WarungModel(
      name: 'Kopi Pasar Pak Budi',
      rating: 4.9,
      address: 'Pasar Oro-Oro Dowo',
      reviewsCount: 110,
      distance: 'Kuliner · No. 02',
      openingHours: '06.00 - 17.00',
      priceRange: 'Rp 6.000–18.000',
      category: 'Kopi & Minuman',
      heroImageUrl:
          'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=600&q=80',
      menus: [
        WarungMenuItem(
          name: 'Es Kopi Susu Aren',
          description: 'Kopi robusta Dampit racikan pasar dipadu susu segar & gula aren',
          price: 12000,
          imageUrl:
              'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Kopi Tubruk Robusta Dampit',
          description: 'Seduhan kopi hitam pekat khas lereng Gunung Semeru Malang',
          price: 6000,
          imageUrl:
              'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),

    // 6. Dawet Ayu Bu Tini
    WarungModel(
      name: 'Dawet Ayu Bu Tini',
      rating: 4.8,
      address: 'Pasar Oro-Oro Dowo',
      reviewsCount: 65,
      distance: 'Kuliner · No. 11',
      openingHours: '08.00 - 15.30',
      priceRange: 'Rp 8.000–15.000',
      category: 'Kopi & Minuman',
      heroImageUrl:
          'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=600&q=80',
      menus: [
        WarungMenuItem(
          name: 'Es Dawet Gula Aren',
          description: 'Cendol kenyal pandan suji, santan murni & juruh gula kelapa asli',
          price: 8000,
          imageUrl:
              'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=400&q=80',
        ),
        WarungMenuItem(
          name: 'Wedang Ronde Jahe Hangat',
          description: 'Bola ketan isi kacang dengan kuah jahe wangi menghangatkan badan',
          price: 10000,
          imageUrl:
              'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    ),
  ];
}

