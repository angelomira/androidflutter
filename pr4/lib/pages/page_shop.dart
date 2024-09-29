import 'package:flutter/material.dart';
import 'package:pr3/components/shop_item.dart';
import 'package:pr3/data/cars.dart';
import 'package:pr3/models/car.dart';
import 'package:pr3/pages/page_car_add.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
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
            backgroundColor: Colors.amberAccent,
            title: const Text('Confirm deletion'),
            content: const Text('Are you sure you want to delete this car?'),
            actions: <Widget>[
              TextButton(
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  setState(() {
                    carEntries.removeAt(index);
                  });
                  Navigator.of(context).pop();
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
              child: Text("No listed cars"),
            )
          : ListView.builder(
              itemCount: carEntries.length,
              itemBuilder: (BuildContext context, int index) {
                return CarItem(item: carEntries[index], index: index, removeCar: removeCar);
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () => navigateToAddCarPage(context),
        tooltip: "List (add) car",
        child: const Icon(Icons.add_box_rounded),
      ),
    );
  }
}
