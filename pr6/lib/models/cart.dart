import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/car.dart';

class CartItem {
  Car car;
  int quantity;

  CartItem({required this.car, this.quantity = 1});
}


