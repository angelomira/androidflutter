import 'package:dio/dio.dart';

import '../models/profile.dart';

class ApiService {
  final Dio _dio = Dio();
  final String url = 'http://10.0.2.2:3000';

  Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String middlename,
    required DateTime dateBorn,
  }) async {
    try {
      final response = await _dio.post(
        '$url/profiles/',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'surname': surname,
          'middlename': middlename,
          'dateBorn': dateBorn.toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      return false;
    }
  }

  Future<Profile?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$url/profiles/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return Profile.fromJSON(response.data);
      }
    } on DioError catch (e) {
      print('Login error: ${e.response?.data ?? e.message}');
    }
    return null; // Returns null on failure
  }
}
