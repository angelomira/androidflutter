import 'dart:ui';

import 'package:flutter/material.dart';
import '../services/service_api_cart.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../pages/page_car.dart';

import '../data/pallets.dart';

class CarItem extends StatefulWidget {
  final Car item;
  final int index;
  final Function(int) removeCar;
  final Function(int) toggleFavorite;
  final Function(BuildContext, Car) navigateToEditCarPage;

  const CarItem(
      {super.key,
      required this.item,
      required this.index,
      required this.removeCar,
      required this.toggleFavorite,
      required this.navigateToEditCarPage});

  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  late Future<bool> futureInCart;

  List<String> processCarName(String carName) {
    if (carName.contains('\\n')) {
      carName = carName.replaceAll('\\n', '\n');
    }

    return carName.split('\n');
  }

  @override
  void initState() {
    super.initState();
    futureInCart = CartApiService().isInCart(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    List<String> carNameParts = processCarName(widget.item.carName);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarPage(
              item: widget.item,
              removeCar: widget.removeCar,
              toggleFavorite: widget.toggleFavorite,
              navigateToEditCarPage: widget.navigateToEditCarPage,
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
                          carNameParts.isNotEmpty ? carNameParts[0] : '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomDarkTheme.backgroundColor,
                            letterSpacing: 1.2,
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
                        if (carNameParts.length > 1)
                          Text(
                            carNameParts[1],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: CustomDarkTheme.accentColor,
                              letterSpacing: 1.0,
                            ),
                            textAlign: TextAlign.center,
                          )
                        else
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: CustomDarkTheme.accentColor,
                              letterSpacing: 1.0,
                            ),
                            textAlign: TextAlign.center,
                          )
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
                          widget.toggleFavorite(widget.item.id);
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
                  FutureBuilder<bool>(
                    future: futureInCart,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: Text('No listed cars.'));
                      }

                      final isInCart = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isInCart
                            ? ElevatedButton(
                            onPressed: () {},
                            child: Text('In cart.', style: TextStyle(color: CustomDarkTheme.additionalColor)))
                            : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              CartApiService().addToCart(widget.item.id);
                              futureInCart = CartApiService().isInCart(widget.item.id);
                            });
                          },
                          child: Text('Add to Cart', style: TextStyle(color: CustomDarkTheme.additionalColor)),
                        ),
                      );
                    }
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
