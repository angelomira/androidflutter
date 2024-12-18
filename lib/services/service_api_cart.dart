import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr9/data/profiles.dart';

import '../models/car.dart';
import '../models/cart.dart';

class CartApiService {
  final Dio _dio = Dio();
  final String _url = 'https://androidflutter.vercel.app';

  // Cart
  Future<List<CartItem>> getCarts() async {
    try {
      final response =
          await _dio.get('$_url/cart/', data: {'id_profile': PROFILE_CONST.id});

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        return data.map((json) => CartItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load carts.');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load carts: ${e.message}');
    }
  }

  Future<CartItem> getCart(int id) async {
    try {
      final response =
          await _dio.get('$_url/cart/$id', data: {'id_profile': PROFILE_CONST.id});

      if (response.statusCode == 200) {
        final cartData = response.data;

        return CartItem(
          car: Car.fromJson(cartData['Car']),
          quantity: cartData['quantity'],
        );
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load cart: ${e.message}');
    }
  }

  Future<bool> isInCart(int id) async {
    try {
      final response =
          await _dio.get('$_url/cart/$id', data: {'id_profile': PROFILE_CONST.id});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception('Failed to load cart: ${e.message}');
    }
  }

  Future<void> addToCart(int id, {int quantity = 1}) async {
    try {
      final response = await _dio.post(
        '$_url/cart',
        data: {
          "id": id,
          "id_profile": PROFILE_CONST.id,
          "quantity": quantity,
        },
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Failed to add car into the cart.');
      }
    } on DioError catch (e) {
      throw Exception('Failed to add car into the cart: ${e.message}');
    }
  }

  Future<void> increaseCartQuantity(int id) async {
    try {
      final response = await _dio
          .put('$_url/cart/increase/$id', data: {'id_profile': PROFILE_CONST.id});

      if (response.statusCode != 201) {
        throw Exception('Failed to increase cart quantity');
      } else {
        return;
      }
    } on DioError catch (e) {
      throw Exception('Failed increasing cart quantity: ${e.message}');
    }
  }

  Future<void> decreaseCartQuantity(int id) async {
    try {
      final response = await _dio
          .put('$_url/cart/decrease/$id', data: {'id_profile': PROFILE_CONST.id});

      if (response.statusCode != 201) {
        throw Exception('Failed to decrease cart quantity');
      } else {
        return;
      }
    } on DioError catch (e) {
      throw Exception('Failed decreasing cart quantity: ${e.message}');
    }
  }

  Future<void> deleteCart(int id) async {
    try {
      final response =
          await _dio.delete('$_url/cart/$id', data: {'id_profile': PROFILE_CONST.id});

      if (response.statusCode != 204) {
        throw Exception('Failed to delete cart');
      } else {
        return;
      }
    } on DioError catch (e) {
      throw Exception('Failed to delete cart: ${e.message}');
    }
  }
}
