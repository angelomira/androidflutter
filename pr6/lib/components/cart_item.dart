import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pr6/data/pallets.dart';

import '../models/cart.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemTile({
    Key? key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

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
                    cartItem.car.linkImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),

              // Car Information Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"${cartItem.car.carName.split('\n').join('')}"',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: CustomDarkTheme.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Price styled more prominently
                    Text(
                      '\$${cartItem.car.price}',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Quantity controls
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: CustomDarkTheme.accentColor),
                        onPressed: onDecrease,
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
                        onPressed: onIncrease,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
