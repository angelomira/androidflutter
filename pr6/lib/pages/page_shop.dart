import 'package:flutter/material.dart';
import 'package:pr6/pages/page_car.dart';
import 'package:provider/provider.dart';
import '../components/shop_item.dart';
import '../data/cars.dart';
import '../models/car.dart';
import '../pages/page_car_add.dart';
import '../pages/page_favorites.dart';
import '../pages/pages_profile.dart';

import '../data/pallets.dart';
import '../providers/provider_car.dart';

class CarListScreen extends StatefulWidget {
  CarListScreen({super.key});

  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  int columns = 2;

  void toggleFavorite(int index) {
    setState(() {
      Car car = carEntries[index];
      car.updateFavourite(null);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<CarProvider>(context, listen: false)
      .initCars(carEntries);
  }

  void navigateToAddCarPage(BuildContext context) async {
    final Car result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddCarPage()));

    setState(() {
      carEntries.add(result);
    });
  }

  void navigateToCarPage(BuildContext context, Car car, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarPage(
          car: car,
          index: index,
          removeCar: removeCar,
          toggleFavorite: toggleFavorite,
        ),
      ),
    );
  }

  void removeCar(int index) {
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
                    carEntries.removeAt(index);
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
            "Listed cars",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          return carProvider.carEntries.isEmpty
              ? const Center(child: Text("No listed cars."))
              : GridView.builder(
              padding: const EdgeInsets.only(bottom: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.625,
              ),
              itemCount: carProvider.carEntries.length,
              itemBuilder: (BuildContext ctx, int index) {
                return CarItem(
                    item: carProvider.carEntries[index],
                    index: index,
                    removeCar: carProvider.removeCar,
                    toggleFavorite: toggleFavorite,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomDarkTheme.additionalColor,
        onPressed: () => navigateToAddCarPage(context),
        tooltip: "List a car",
        child: const Icon(Icons.add_box_rounded),
      ),
    );
  }
}
