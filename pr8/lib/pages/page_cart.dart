import 'package:flutter/material.dart';
import 'package:pr8/services/service_api_cart.dart';

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
  late Future<List<CartItem>> cartEntries;

  @override
  void initState() {
    super.initState();
    cartEntries = CartApiService().getCarts();
  }

  void removeCart(int id) {
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
                onPressed: () {
                  CartApiService().deleteCart(id);

                  setState(() {
                    cartEntries = CartApiService().getCarts();

                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        }
    );
  }

  void increaseQuantity(int id) async {
    await CartApiService().increaseCartQuantity(id);
    setState(() {
      cartEntries = CartApiService().getCarts();
    });
  }

  void decreaseQuantity(int id) async {
    await CartApiService().decreaseCartQuantity(id);
    setState(() {
      cartEntries = CartApiService().getCarts();
    });
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
                    child: CartItemTile(
                      cartItem: cartItem,
                      onIncrease: increaseQuantity,
                      onDecrease: decreaseQuantity,
                    ),
                    removeCart: removeCart,
                    cartItem: cartItem,
                  )
              );
            },
          );
        },
      ),
    );
  }
}
