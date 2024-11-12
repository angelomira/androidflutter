import 'package:flutter/material.dart';
import 'package:pr5/components/shop_item.dart';
import 'package:pr5/data/cars.dart';
import 'package:pr5/models/car.dart';
import 'package:pr5/pages/page_car_add.dart';
import 'package:pr5/pages/page_favorites.dart';
import 'package:pr5/pages/pages_profile.dart';

import '../data/pallets.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  int columns = 2;

  void navigateToAddCarPage(BuildContext context) async {
    final Car result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddCarPage()));

    setState(() {
      carEntries.add(result);
    });
  }

  void removeCar(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: CustomDarkTheme.baseColor,
            title: Text(
                'Confirm deletion',
                style: TextStyle(color: CustomDarkTheme.backgroundColor)
            ),
            content: Text(
                'Are you sure you want to delete this car?',
                style: TextStyle(color: CustomDarkTheme.backgroundColor)
            ),
            actions: <Widget>[
              TextButton(
                child:
                  Text('Cancel', style: TextStyle(color: CustomDarkTheme.backgroundColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:
                  Text('Delete', style: TextStyle(color: CustomDarkTheme.accentColor)),
                onPressed: () {
                  setState(() {
                    carEntries.removeAt(index);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
              )
            ],
          );
        });
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
      body: carEntries.isEmpty
          ? const Center(
              child: Text("No listed cars."),
            )
          : GridView.builder(
        padding: const EdgeInsets.only(bottom: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.675,
        ),
        itemCount: carEntries.length,
        itemBuilder: (BuildContext ctx, int index) {
          return CarItem(item: carEntries[index], index: index, removeCar: removeCar);
        }
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
