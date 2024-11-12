import 'package:flutter/material.dart';
import 'package:pr8/models/cart.dart';
import 'package:pr8/services/service_api_cars.dart';
import 'package:pr8/services/service_api_cart.dart';
import '../pages/page_car.dart';
import '../components/shop_item.dart';
import '../models/car.dart';
import '../pages/page_car_add.dart';
import '../data/pallets.dart';

class CarListScreen extends StatefulWidget {
  CarListScreen({super.key});

  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  late Future<List<Car>> carEntries;

  @override
  void initState() {
    super.initState();
    carEntries = CarsApiService().getCars();
  }

  void toggleFavorite(int id) {
    setState(() {
      CarsApiService().updateFavorite(id);
      carEntries = CarsApiService().getCars();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void navigateToAddCarPage(BuildContext context) async {
    final Car result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddCarPage()));

    setState(() {});
  }

  void navigateToCarPage(BuildContext context, Car car, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarPage(
          item: car,
          toggleFavorite: toggleFavorite,
          removeCar: removeCar,
        ),
      ),
    );
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
            "Listed cars",
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
            return const Center(child: Text('No listed cars.'));
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
                return CarItem(
                  item: cars[index],
                  index: index,
                  removeCar: removeCar,
                  toggleFavorite: toggleFavorite,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomDarkTheme.additionalColor,
        onPressed: () {
          navigateToAddCarPage(context);
        },
        tooltip: "List a car",
        child: const Icon(Icons.add_box_rounded),
      ),
    );
  }
}
