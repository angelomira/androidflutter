import 'cart.dart';

class OrderItem {
  final int id;
  final DateTime createdAt;
  final DateTime orderedAt;
  final String status;
  final List<CartItem> carts;

  OrderItem({
    required this.id,
    required this.createdAt,
    required this.orderedAt,
    required this.status,
    required this.carts,
  });

  factory OrderItem.fromJSON(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      orderedAt: DateTime.parse(json['ordered_at'] as String),
      status: json['status'] as String? ?? 'IN ORDER',
      carts: (json['Cart'] as List<dynamic>)
          .map((cart) => CartItem.fromJson(cart as Map<String, dynamic>))
          .toList(),
    );
  }
}