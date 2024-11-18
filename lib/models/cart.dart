import '../models/car.dart';

class CartItem {
  final Car car;
  final int quantity;

  CartItem({required this.car, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      car: Car.fromJson(json['Car']),
      quantity: json['quantity'] as int,
    );
  }
}


