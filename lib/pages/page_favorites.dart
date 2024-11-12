import 'package:flutter/material.dart';
import 'package:pr9/pages/page_car_edit.dart';

import '../components/shop_favorite_item.dart';
import '../data/pallets.dart';
import '../models/car.dart';
import '../services/service_api_cars.dart';

class CarFavoriteScreen extends StatefulWidget {
  const CarFavoriteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CarFavoriteScreenState();
}

class _CarFavoriteScreenState extends State<CarFavoriteScreen> {
  late Future<List<Car>> carEntries;

  @override
  void initState() {
    super.initState();
    carEntries = CarsApiService().getFavorites();
  }

  void toggleFavorite(int id) {
    setState(() {
      CarsApiService().updateFavorite(id);
      carEntries = CarsApiService().getFavorites();
    });
  }

  void navigateToEditCarPage(BuildContext context, Car car) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCarPage(car: car)));

    setState(() {
      carEntries = CarsApiService().getFavorites();
    });
  }

  void removeCar(int id) {
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
                    CarsApiService().deleteCar(id);
                    carEntries = CarsApiService().getCars();
                    Navigator.of(context).popUntil((route) => route.isFirst);
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
        title: const Center(
          child: Text(
            "Favorite cars",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<List<Car>>(
        future: carEntries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites.'));
          }

          final cars = snapshot.data!;

          return GridView.builder(
              padding: const EdgeInsets.only(bottom: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.625,
              ),
              itemCount: cars.length,
              itemBuilder: (BuildContext ctx, int index) {
                return FavoriteCarItem(
                  item: cars[index],
                  index: index,
                  removeCar: (index) {},
                  toggleFavorite: toggleFavorite,
                  navigateToEditCarPage: navigateToEditCarPage,
                );
              });
        },
      ),
    );
  }
}
