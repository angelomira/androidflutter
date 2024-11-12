import 'package:flutter/cupertino.dart';
import 'package:pr6/data/cart.dart';
import 'package:pr6/providers/provider_cart.dart';
import 'package:provider/provider.dart';

class Car extends ChangeNotifier {
  final String carName;
  final String carEntry;
  final String price;
  final String linkImage;
  final String linkRefer;
  final String carDescription;

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  Car({required this.carName, required this.carEntry, required this.price, required this.linkImage, required this.linkRefer, required this.carDescription});

  updateFavourite(bool? status) {
    _isFavorite = status ?? !_isFavorite;

    notifyListeners();
  }

  bool isInCart(BuildContext context) {
    return Provider.of<CartProvider>(context, listen: false)
                  .isInCart(this);
  }

  addToCart(BuildContext context, Car car) {
    if(!isInCart(context)) {
      carsCart.add(car);

      notifyListeners();
    }
  }
}