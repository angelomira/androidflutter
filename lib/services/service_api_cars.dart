import 'package:dio/dio.dart';
import '../models/car.dart';

class CarsApiService {
  final Dio _dio = Dio();
  final String _url = 'http://10.0.2.2:3000';

  // Cars
  Future<List<Car>> getCars() async {
    try {
      final response = await _dio.get('$_url/cars/');

      if(response.statusCode == 200) {
        List<dynamic> json = response.data;

        return json.map((car) => Car.fromJson(car)).toList();
      } else {
        throw Exception('Failed to load cars.');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load cars: ${e.message}');
    }
  }

  Future<Car> getCar(int id) async {
    try {
      final response = await _dio.get('$_url/cars/$id');

      if(response.statusCode == 200) {
        return Car.fromJson(response.data);
      } else {
        throw Exception('Failed to load car: ${response.statusMessage}');
      }
    } on DioError catch(e) {
      throw Exception('Failed to load car: ${e.message}');
    }
  }

  Future<Car> updateCar(int id, Map<String, dynamic> updatedData) async {
    try {
      final response = await _dio.put('$_url/cars/$id', data: updatedData);

      if (response.statusCode == 201) {
        return Car.fromJson(response.data['item']);
      } else {
        throw Exception('Failed to update car info: ${response.data}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to update car: ${e.message}');
    }
  }

  Future<void> deleteCar(int id) async {
    try {
      final response = await _dio.delete('$_url/cars/$id');

      if(response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete car: ${response.statusMessage}');
      }
    } on DioError catch(e) {
      throw Exception('Failed to load car: ${e.message}');
    }
  }

  Future<Car> createCar(String carName, String carEntry, String price,
      String linkImage, String linkRefer, String carDescription) async {
    try {
      final response = await _dio.post(
        '$_url/cars/',
        data: {
          'carName': carName,
          'carEntry': carEntry,
          'price': price,
          'linkImage': linkImage,
          'linkRefer': linkRefer,
          'carDescription': carDescription,
        },
      );

      if (response.statusCode == 201) {
        return Car.fromJson(response.data['item']);
      } else {
        throw Exception('Failed to create car: ${response.data}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to create car: ${e.message}');
    }
  }

  // Favorites
  Future<List<Car>> getFavorites() async {
    try {
      final response = await _dio.get('$_url/favorites/');

      if(response.statusCode == 200) {
        List<dynamic> json = response.data;

        return json.map((car) => Car.fromJson(car)).toList();
      } else {
        throw Exception('Failed to load cars.');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load cars: ${e.message}');
    }
  }

  Future<void> updateFavorite(int id) async {
    try {
      final response = await _dio.put('$_url/favorites/$id');

      if(response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to update favorite status: ${response.data}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load cars: ${e.message}');
    }
  }
}