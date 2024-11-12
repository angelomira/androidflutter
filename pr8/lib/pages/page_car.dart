import 'package:flutter/material.dart';
import 'package:pr8/services/service_api_cars.dart';
import '../models/car.dart';
import '../data/pallets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/widget_multiline_label.dart';

class CarPage extends StatefulWidget {
  final Car item;
  final Function(int) toggleFavorite;
  final Function(int) removeCar;

  const CarPage({
    super.key,
    required this.item,
    required this.toggleFavorite,
    required this.removeCar,
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
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data found.');
            }

            final car = snapshot.data!;
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Viewing item in car listing:',
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

          final car = snapshot.data!;

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
                      backgroundColor: CustomDarkTheme.accentColor,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(car.linkRefer))) {
                        await launchUrl(Uri.parse(car.linkRefer));
                      } else {
                        throw 'Could not launch ${car.linkRefer}';
                      }
                    },
                    child: const Text(
                      'View the listing',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
