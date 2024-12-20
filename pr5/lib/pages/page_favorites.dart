import 'package:flutter/material.dart';
import 'package:pr5/data/cars.dart';

import '../components/shop_favorite_item.dart';
import '../models/car.dart';

class CarFavoriteScreen extends StatefulWidget {
  const CarFavoriteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CarFavoriteScreenState();
}

class _CarFavoriteScreenState extends State<CarFavoriteScreen> {
  void removeFavorite(int index) {
    setState(() {
      carEntries[index].updateFavourite(false);  // Update the favorite status
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter out the cars that are marked as favorite
    final List<Car> favoriteCars = carEntries.where((car) => car.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Favorite Cars",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: favoriteCars.isEmpty
          ? const Center(child: Text("No favorite cars."))
          : GridView.builder(
        padding: const EdgeInsets.only(bottom: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.675,
        ),
        itemCount: favoriteCars.length,
        itemBuilder: (BuildContext ctx, int index) {
          // Find the index of the car in the main list for correct removal
          int mainIndex = carEntries.indexOf(favoriteCars[index]);
          return FavoriteCarItem(
            item: favoriteCars[index],
            index: mainIndex,
            removeCar: removeFavorite,
          );
        },
      ),
    );
  }
}
