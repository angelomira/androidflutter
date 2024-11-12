import 'package:flutter/material.dart';
import 'package:pr5/models/car.dart';
import 'package:pr5/widgets/widget_multline_label.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/pallets.dart';  // Make sure to import your theme

class CarPage extends StatefulWidget {
  final Car car;
  final int index;
  final Function(int) removeCar;

  const CarPage(
      {super.key,
        required this.car,
        required this.index,
        required this.removeCar});

  @override
  State<StatefulWidget> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomDarkTheme.baseColor,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Viewing item in car listing:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomDarkTheme.backgroundColor,  // Keep text white for contrast
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomDarkTheme.baseColor,
        onPressed: ()
        {
          widget.removeCar(widget.index);
        },
        tooltip: "Remove car from listing",
        child: const Icon(Icons.delete_sweep_sharp),
      ),
      body: SingleChildScrollView( // Added ScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: SizedBox.fromSize(
                  child: Image.network(
                    widget.car.linkImage,
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
                    widget.car.carName.split('\n')[0],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomDarkTheme.baseColor,
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
                  Text(
                    widget.car.carName.split('\n')[1],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CustomDarkTheme.additionalColor,
                      letterSpacing: 1.0,
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomMultilineLabel.create('Price:', '\$${widget.car.price}'),
            CustomMultilineLabel.create('Entry:', widget.car.carEntry),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                widget.car.carDescription,
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
                  if (await canLaunchUrl(Uri.parse(widget.car.linkRefer))) {
                    await launchUrl(Uri.parse(widget.car.linkRefer));
                  } else {
                    throw 'Could not launch ${widget.car.linkRefer}';
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
      ),
    );
  }
}
