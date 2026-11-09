import 'package:flutter/foundation.dart';

/// Model Data Pesanan Aktif untuk Order Tracking & Riwayat
class OrderItemModel {
  final String orderId;
  final String warungName;
  final String itemsSummary;
  final int totalPayment;
  final String estimatedTime;
  final String deliveryAddress;
  final String status;
  final String driverName;
  final DateTime createdAt;

  OrderItemModel({
    required this.orderId,
    required this.warungName,
    required this.itemsSummary,
    required this.totalPayment,
    required this.estimatedTime,
    required this.deliveryAddress,
    this.status = 'Driver Sedang Menuju Alamat',
    this.driverName = 'Budi (Driver)',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

/// State Management Pesanan & Statistik Akun berbasis ChangeNotifier (Singleton)
class OrderManager extends ChangeNotifier {
  static final OrderManager instance = OrderManager._internal();
  OrderManager._internal();

  // Data pesanan aktif awal (sesuai Frame 6: 2 pesanan aktif sedang diproses)
  final List<OrderItemModel> _activeOrders = [
    OrderItemModel(
      orderId: '#OOD-20261109-041',
      warungName: 'Sego Liwet Bakar Kemangi',
      itemsSummary: '2 menu · Sego Liwet Bakar Ayam',
      totalPayment: 38000,
      estimatedTime: '12 menit',
      deliveryAddress: 'Jl. Veteran No. 12, Malang',
      status: 'Driver Sedang Mengantar Pesananmu!',
      driverName: 'Budi (Driver)',
    ),
    OrderItemModel(
      orderId: '#OOD-20261109-038',
      warungName: 'Nasi Buk Hj. Supina',
      itemsSummary: '1 menu · Nasi Ayam Kampung',
      totalPayment: 33000,
      estimatedTime: '25–35 menit',
      deliveryAddress: 'Jl. Veteran No. 12, Malang',
      status: 'Warung Sedang Memasak Pesananmu',
      driverName: 'Menunggu Driver',
    ),
  ];

  int _historyCount = 18;
  int _favoriteCount = 6;

  List<OrderItemModel> get activeOrders => List.unmodifiable(_activeOrders);

  int get activeOrdersCount => _activeOrders.length;

  int get historyCount => _historyCount;

  int get favoriteCount => _favoriteCount;

  // Menambahkan pesanan baru ketika checkout tervalidasi
  void addOrder({
    required String orderId,
    required String warungName,
    required String itemsSummary,
    required int totalPayment,
    required String estimatedTime,
    required String deliveryAddress,
  }) {
    _activeOrders.insert(
      0,
      OrderItemModel(
        orderId: orderId,
        warungName: warungName,
        itemsSummary: itemsSummary,
        totalPayment: totalPayment,
        estimatedTime: estimatedTime,
        deliveryAddress: deliveryAddress,
        status: 'Warung Mulai Memasak Pesananmu',
        driverName: 'Mencari Driver Terdekat',
      ),
    );
    // TODO: [API Connection] Kirim data order ke backend (POST /api/v1/orders)
    notifyListeners();
  }

  // Menyelesaikan pesanan (pindah ke riwayat)
  void completeOrder(String orderId) {
    _activeOrders.removeWhere((order) => order.orderId == orderId);
    _historyCount++;
    // TODO: [API Connection] Update status order di backend (PATCH /api/v1/orders/{id}/complete)
    notifyListeners();
  }
}

