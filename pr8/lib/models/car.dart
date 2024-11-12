import 'package:flutter/cupertino.dart';

class Car extends ChangeNotifier {
  final int id;
  final String carName;
  final String carEntry;
  final String price;
  final String linkImage;
  final String linkRefer;
  final String carDescription;
  late final bool isFavorite;

  Car({required this.id, required this.carName, required this.carEntry, required this.price, required this.linkImage, required this.linkRefer, required this.carDescription, required this.isFavorite});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      carName: json['carName'],
      carEntry: json['carEntry'],
      price: json['price'],
      linkImage: json['linkImage'],
      linkRefer: json['linkRefer'],
      carDescription: json['carDescription'],
      isFavorite: bool.parse(json['isFavorite'].toString().toLowerCase())
    );
  }
}