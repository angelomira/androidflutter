import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_item.dart';
import '../data/pallets.dart';
import '../models/cart.dart';
import '../providers/provider_cart.dart';
import '../widgets/widget_slidable.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeCar(CartProvider cartProvider, CartItem cartItem) {
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
                  setState(() {
                    cartProvider.removeFromCart(cartItem.car);

                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Shopping cart'),
      )),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return cartProvider.cartItems.isEmpty
              ? const Center(child: const Text('No items in the cart.'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: SlidableWidget(
                            child: CartItemTile(
                            cartItem: cartItem,
                            onIncrease: () {
                              cartProvider.updateQuantity(
                                  cartItem.car, cartItem.quantity + 1);
                            },
                            onDecrease: () {
                              if (cartItem.quantity > 1) {
                                cartProvider.updateQuantity(
                                    cartItem.car, cartItem.quantity - 1);
                              }
                            },
                          ),
                          onDelete: () => removeCar(cartProvider, cartItem),
                        )
                      );
                  },
                );
        },
      ),
    );
  }
}
