import 'package:flutter/material.dart';
import 'package:pr9/pages/page_car_edit.dart';
import '../services/service_api_cars.dart';
import '../models/car.dart';
import '../data/pallets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/widget_multiline_label.dart';

class CarPage extends StatefulWidget {
  final Car item;
  final Function(int) toggleFavorite;
  final Function(int) removeCar;
  final Function(BuildContext, Car) navigateToEditCarPage;

  const CarPage({
    super.key,
    required this.item,
    required this.toggleFavorite,
    required this.removeCar,
    required this.navigateToEditCarPage,
  });

  @override
  State<StatefulWidget> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  late Future<Car> futureCar;

  @override
  void initState() {
    super.initState();
    futureCar = CarsApiService().getCar(widget.item.id);
  }

  List<String> processCarName(String carName) {
    if (carName.contains('\\n')) {
      carName = carName.replaceAll('\\n', '\n');
    }

    return carName.split('\n');
  }

  @override
  Widget build(BuildContext context) {
    List<String> carNameParts = processCarName(widget.item.carName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomDarkTheme.baseColor,
        title: FutureBuilder<Car>(
          future: futureCar,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No data found.'));
            }

            final car = snapshot.data!;
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Viewing the car in list:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomDarkTheme.backgroundColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    icon: Icon(
                      car.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: car.isFavorite ? Colors.red : Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.toggleFavorite(widget.item.id);
                        futureCar = CarsApiService().getCar(widget.item.id);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.link, color: Colors.white),
            onPressed: () async {
              await launchUrl(Uri.parse(widget.item.linkRefer));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomDarkTheme.baseColor,
        onPressed: () {
          setState(() {
            widget.removeCar(widget.item.id);
          });
        },
        tooltip: "Remove car from listing",
        child: const Icon(Icons.delete_sweep_sharp),
      ),
      body: FutureBuilder<Car>(
        future: futureCar,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          }

          var car = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: SizedBox.fromSize(
                      child: Image.network(
                        car.linkImage,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
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
                const SizedBox(height: 20),
                CustomMultilineLabel.create('Price:', '\$${car.price}'),
                CustomMultilineLabel.create('Entry:', car.carEntry),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    car.carDescription,
                    style: TextStyle(
                      color: CustomDarkTheme.additionalColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomDarkTheme.baseColor,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final Car? editedCar = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCarPage(car: widget.item),
                        ),
                      );

                      if (editedCar != null) {
                        setState(() {
                          futureCar = Future.value(editedCar); // Update the Future with the new car data
                        });
                      }
                    },
                    child: const Icon(Icons.edit, color: Colors.black)
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
