import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final String portion;
  final int price;
  final String imageUrl;
  final String warungName;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.portion,
    required this.price,
    required this.imageUrl,
    this.warungName = 'Warung Kuliner',
    this.quantity = 1,
  });
}

/// State Management Keranjang berbasis ChangeNotifier (Singleton)
class CartManager extends ChangeNotifier {
  static final CartManager instance = CartManager._internal();
  CartManager._internal();

  // Daftar item di keranjang (awalnya kosong sebelum pengguna memesan)
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  int get subtotal =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  // Ongkos kirim tetap jika ada pesanan (Rp8.000), Rp0 jika keranjang kosong
  int get deliveryFee => _items.isEmpty ? 0 : 8000;

  // Total bayar keseluruhan
  int get totalPayment => _items.isEmpty ? 0 : subtotal + deliveryFee;

  // Cek jumlah porsi dari menu tertentu
  int getItemQuantity(String name) {
    final index = _items.indexWhere((item) => item.name == name);
    return index >= 0 ? _items[index].quantity : 0;
  }

  // Menambahkan item ke keranjang atau memperbarui jika sudah ada
  void addItem({
    required String name,
    required int price,
    String portion = 'Porsi · siap saji',
    String imageUrl = '',
    String warungName = 'Sego Liwet Bakar Kemangi',
    int quantity = 1,
  }) {
    if (quantity <= 0) return;
    final index = _items.indexWhere((item) => item.name == name);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          portion: portion,
          price: price,
          imageUrl: imageUrl,
          warungName: warungName,
          quantity: quantity,
        ),
      );
    }
    // TODO: [API Connection] Sinkronisasi data keranjang ke endpoint backend (POST /api/v1/cart/items)
    notifyListeners();
  }

  // Mengubah kuantitas item (+1 atau -1)
  void updateQuantity(String name, int delta) {
    final index = _items.indexWhere((item) => item.name == name);
    if (index >= 0) {
      _items[index].quantity += delta;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      // TODO: [API Connection] Update item quantity ke backend (PATCH /api/v1/cart/items/{id})
      notifyListeners();
    }
  }

  // Menghapus item dari keranjang
  void removeItem(String name) {
    _items.removeWhere((item) => item.name == name);
    // TODO: [API Connection] Hapus item keranjang di backend (DELETE /api/v1/cart/items/{id})
    notifyListeners();
  }

  // Mengosongkan keranjang setelah transaksi selesai
  void clearCart() {
    _items.clear();
    // TODO: [API Connection] Bersihkan keranjang di backend (POST /api/v1/cart/clear)
    notifyListeners();
  }
}
