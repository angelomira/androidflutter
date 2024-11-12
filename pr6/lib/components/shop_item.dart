import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pr6/models/cart.dart';
import 'package:pr6/providers/provider_cart.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../pages/page_car.dart';

import '../data/pallets.dart';

class CarItem extends StatefulWidget {
  // Changed from StatelessWidget to StatefulWidget
  final Car item;
  final int index;
  final Function(int) removeCar;
  final Function(int) toggleFavorite;

  const CarItem(
      {super.key,
      required this.item,
      required this.index,
      required this.removeCar,
      required this.toggleFavorite});

  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarPage(
              car: widget.item,
              index: widget.index,
              removeCar: widget.removeCar,
              toggleFavorite: widget.toggleFavorite,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.5),
          ),
          width: MediaQuery.sizeOf(context).width * 0.20,
          height: MediaQuery.sizeOf(context).height * 0.33,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          widget.item.carName.split('\n')[0],
                          style: TextStyle(
                            fontSize: 20, // Larger size for make
                            fontWeight: FontWeight.bold,
                            color: CustomDarkTheme.backgroundColor,
                            letterSpacing: 1.2, // Slight letter spacing
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.item.carName.split('\n')[1],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: CustomDarkTheme.accentColor,
                            letterSpacing: 1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: SizedBox.fromSize(
                      size: const Size(
                          double.infinity, 240), // Set the size explicitly
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                        child: Image.network(
                          widget.item.linkImage,
                          height: 240,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // "Add to Favorite" button with heart icon
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        widget.item.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            widget.item.isFavorite ? Colors.red : Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.toggleFavorite(widget.index);
                        });
                      },
                    ),
                  ),
                  // Price overlay
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      color: Colors.black.withOpacity(0.5),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: CustomDarkTheme.accentColor,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: '\$${widget.item.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Provider.of<CartProvider>(context, listen: false)
                            .isInCart(widget.item)
                        ? ElevatedButton(
                            onPressed: () {},
                            child: Text('In cart.', style: TextStyle(color: CustomDarkTheme.additionalColor)))
                        : ElevatedButton(
                            onPressed: () {
                              setState(() {});

                              Provider.of<CartProvider>(context, listen: false)
                                  .addToCart(widget.item);
                            },
                            child: Text('Add to Cart', style: TextStyle(color: CustomDarkTheme.additionalColor)),
                          ),
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
