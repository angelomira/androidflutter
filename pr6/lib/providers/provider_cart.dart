import 'package:flutter/cupertino.dart';

import '../models/car.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Car car) {
    CartItem? existingItem =
    _cartItems.firstWhere((item) => item.car == car, orElse: () => CartItem(car: car));

    if (_cartItems.contains(existingItem)) {
      existingItem.quantity++;
    } else {
      _cartItems.add(CartItem(car: car));
    }

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
    for (var item in _cartItems) {
      if (item.car == car) {
        item.quantity = quantity;
        break;
      }
    }
    notifyListeners();
  }

  int get totalItems => _cartItems.length;
}