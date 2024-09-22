import 'package:flutter/material.dart';
import 'package:pr3/models/car.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemPage extends StatelessWidget {
  final Car car;

  const ItemPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text('Viewing item in car listing:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)),
        ),
        backgroundColor: Colors.amberAccent[200],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: SizedBox.fromSize(
                        child: Image.asset(
                      car.linkImage,
                      height: 240,
                      width: 360,
                      fit: BoxFit.cover,
                    ))),
              ),
              const SizedBox(height: 20),
              Center(
                  child: Text(
                car.carName,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Cost: ${car.price}',
                  style: const TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Series: ${car.carEntry}',
                  style: const TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  car.carDescription,
                  style: const TextStyle(color: Colors.black54, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (await canLaunch(car.linkRefer)) {
                      await launch(car.linkRefer);
                    } else {
                      throw 'Could not launch ${car.linkRefer}';
                    }
                  },
                  child: const Text('View the listing'),
                ),
              ),
            ],
          ),
        ));
  }
}
