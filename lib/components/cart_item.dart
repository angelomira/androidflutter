import 'dart:ui';

import 'package:flutter/material.dart';
import '../services/service_api_cart.dart';
import '../data/pallets.dart';

import '../models/cart.dart';

class CartItemTile extends StatefulWidget {
  final CartItem cartItem;
  final Function(int) onIncrease;
  final Function(int) onDecrease;

  const CartItemTile({
    Key? key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  _CartItemTileState createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  late Future<CartItem> futureCartItem;

  @override
  void initState() {
    super.initState();
    futureCartItem = CartApiService().getCart(widget.cartItem.car.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: CustomDarkTheme.baseColor.withOpacity(0.45),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Image.network(
                    widget.cartItem.car.linkImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"${widget.cartItem.car.carName.split('\n').join('')}"',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: CustomDarkTheme.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Price styled more prominently
                    Text(
                      '\$${widget.cartItem.car.price}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: CustomDarkTheme.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Quantity and Action Section
              FutureBuilder<CartItem>(
                  future: futureCartItem,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No listed cars.'));
                    }

                    final cartItem = snapshot.data!;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Quantity controls
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: CustomDarkTheme.accentColor),
                              onPressed: () {
                                setState(() {
                                  widget.onDecrease(widget.cartItem.car.id);
                                });
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: CustomDarkTheme.backgroundColor.withOpacity(0.9),
                              ),
                              child: Text(
                                '${cartItem.quantity}', // Display quantity here
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: CustomDarkTheme.baseColor,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: CustomDarkTheme.accentColor),
                              onPressed: () {
                                setState(() {
                                  widget.onIncrease(widget.cartItem.car.id);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
