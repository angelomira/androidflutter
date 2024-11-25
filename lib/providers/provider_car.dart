import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/service_api_cars.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];

  List<Car> get cars => _cars;

  Future<void> fetchCars() async {
    _cars = await CarsApiService().getCars();
    notifyListeners();
  }

  void toggleFavorite(int id) {
    CarsApiService().updateFavorite(id);
    fetchCars(); // Refresh the list
  }
}
