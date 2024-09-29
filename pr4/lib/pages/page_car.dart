import 'package:flutter/material.dart';
import 'package:pr3/models/car.dart';
import 'package:url_launcher/url_launcher.dart';

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
            title: Center(
                child: Row(children: [
          const Text('Viewing item in car listing:',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          IconButton(
            icon: const Icon(Icons.delete_sweep_sharp),
            onPressed: () {
              widget.removeCar(widget.index);
            },
          ),
        ]))),
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
                        child: Image.network(
                      widget.car.linkImage,
                      height: 240,
                      width: 360,
                      fit: BoxFit.cover,
                    ))),
              ),
              const SizedBox(height: 20),
              Center(
                  child: Text(
                widget.car.carName,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Cost: ${widget.car.price}',
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Series: ${widget.car.carEntry}',
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.car.carDescription,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (await canLaunchUrl(widget.car.linkRefer as Uri)) {
                      await launchUrl(widget.car.linkRefer as Uri);
                    } else {
                      throw 'Could not launch ${widget.car.linkRefer}';
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
