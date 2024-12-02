import 'package:dio/dio.dart';
import 'package:pr9/data/profiles.dart';

import '../models/orders.dart';

class OrdersService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:3000'));

  // Fetch all orders for a profile
  Future<List<OrderItem>> getOrders() async {
    try {
      final response = await _dio.get('/orders/', data: {
        'id_profile': PROFILE_CONST.id,
      });
      final List<dynamic> ordersJson = response.data;
      return ordersJson.map((json) => OrderItem.fromJSON(json)).toList();
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // Fetch a specific order by ID
  Future<OrderItem> getOrderById(int orderId) async {
    try {
      final response = await _dio.get('/orders/$orderId', data: {
        'id_profile': PROFILE_CONST.id,
      });
      return OrderItem.fromJSON(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // Place a new order
  Future<OrderItem> placeOrder() async {
    try {
      final response = await _dio.post('/orders/', data: {
        'id_profile': PROFILE_CONST.id,
      });
      return OrderItem.fromJSON(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  // Error handling for Dio exceptions
  String _handleDioError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message'] ?? 'Something went wrong.';
    }
    return e.message ?? 'Network error.';
  }
}