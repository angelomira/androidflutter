import 'package:flutter/material.dart';
import 'package:pr9/data/profiles.dart';
import 'package:pr9/services/service_api_orders.dart';
import '../services/service_api_cart.dart';

import '../components/cart_item.dart';
import '../data/pallets.dart';
import '../models/cart.dart';
import '../widgets/widget_slidable.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartApiService _cartApiService = CartApiService();
  late Future<List<CartItem>> cartEntries;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    setState(() {
      cartEntries = _cartApiService.getCarts();
    });
  }

  void removeCart(int id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: CustomDarkTheme.baseColor,
            title: Text('Confirm deletion',
                style: TextStyle(color: CustomDarkTheme.backgroundColor)),
            content: Text('Are you sure you want to delete this car?',
                style: TextStyle(color: CustomDarkTheme.backgroundColor)),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(color: CustomDarkTheme.backgroundColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete',
                    style: TextStyle(color: CustomDarkTheme.accentColor)),
                onPressed: () async {
                  await _cartApiService.deleteCart(id);

                  setState(() {
                    _loadCartItems();

                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        });
  }

  void increaseQuantity(int id) async {
    await CartApiService().increaseCartQuantity(id);
    setState(() {
      _loadCartItems();
    });
  }

  void decreaseQuantity(int id) async {
    await CartApiService().decreaseCartQuantity(id);
    setState(() {
      _loadCartItems();
    });
  }

  Future<void> _placeOrder() async {
    try {
      final cartItems = await cartEntries;
      final itemIds = cartItems.map((item) => item.car.id).toList();

      if (itemIds.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully!')),
        );

        await OrdersService().placeOrder();

        _loadCartItems();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cart is empty. Add items to order!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text('Shopping cart'),
      )),
      body: FutureBuilder<List<CartItem>>(
        future: cartEntries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items in the cart.'));
          }

          final carts = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: carts.length,
            itemBuilder: (context, index) {
              final cartItem = carts[index];
              return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SlidableWidget(
                    removeCart: removeCart,
                    cartItem: cartItem,
                    child: CartItemTile(
                      cartItem: cartItem,
                      onIncrease: increaseQuantity,
                      onDecrease: decreaseQuantity,
                    ),
                  ));
            },
          );
        },
      ),
      bottomNavigationBar: PROFILE_CONST.id != -1
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomDarkTheme.baseColor,
                  foregroundColor: CustomDarkTheme.accentColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _placeOrder,
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black87,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  const SnackBar(content: Text('You need to authorize to make orders!'),);
                },
                child: const Text(
                  'Order function is not avalaible.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
    );
  }
}
