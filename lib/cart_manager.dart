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

class CartManager {
  static final CartManager instance = CartManager._internal();
  CartManager._internal();

  // Daftar item di keranjang (awalnya kosong)
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  bool get isEmpty => _items.isEmpty;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  int get subtotal =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  // Menambahkan item ke keranjang
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
  }

  // Mengubah kuantitas item (+1 atau -1)
  void updateQuantity(String name, int delta) {
    final index = _items.indexWhere((item) => item.name == name);
    if (index >= 0) {
      _items[index].quantity += delta;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
    }
  }

  // Menghapus item dari keranjang
  void removeItem(String name) {
    _items.removeWhere((item) => item.name == name);
  }

  // Mengosongkan keranjang setelah transaksi selesai
  void clearCart() {
    _items.clear();
  }
}

