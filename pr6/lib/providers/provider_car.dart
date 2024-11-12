import 'package:flutter/cupertino.dart';

import '../models/car.dart';

class CarProvider with ChangeNotifier {
  List<Car> _carEntries = [];

  List<Car> get carEntries => _carEntries;

  void addCar(Car car) {
    _carEntries.add(car);

    notifyListeners();
  }

  void removeCar(int index) {
    _carEntries.removeAt(index);

    notifyListeners();
  }

  void initCars(List<Car> cars) {
    _carEntries = cars;

    notifyListeners();
  }
}
