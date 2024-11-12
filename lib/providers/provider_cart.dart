import 'package:flutter/cupertino.dart';

import '../models/car.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Car car) {
    notifyListeners();
  }

  void removeFromCart(Car car) {
    _cartItems.removeWhere((item) => item.car == car);
    notifyListeners();
  }

  bool isInCart(Car car) {
    return _cartItems.any((item) => item.car.carEntry == car.carEntry);
  }

  void updateQuantity(Car car, int quantity) {
    notifyListeners();
  }

  int get totalItems => _cartItems.length;
}