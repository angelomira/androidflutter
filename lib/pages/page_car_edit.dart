import 'package:flutter/material.dart';

import '../data/pallets.dart';
import '../models/car.dart';
import '../services/service_api_cars.dart';
import '../widgets/widget_custom_textfield.dart';

class EditCarPage extends StatefulWidget {
  final Car car;

  const EditCarPage({super.key, required this.car});

  @override
  State<StatefulWidget> createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  late Future<Car> futureCar;

  TextEditingController carNameController = TextEditingController();
  TextEditingController carEntryController = TextEditingController();
  TextEditingController carPriceController = TextEditingController();
  TextEditingController carLinkImageController = TextEditingController();
  TextEditingController carLinkReferController = TextEditingController();
  TextEditingController carDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureCar = CarsApiService().getCar(widget.car.id);
    carNameController = TextEditingController(text: widget.car.carName);
    carEntryController = TextEditingController(text: widget.car.carEntry);
    carPriceController =
        TextEditingController(text: widget.car.price.toString());
    carLinkImageController = TextEditingController(text: widget.car.linkImage);
    carLinkReferController = TextEditingController(text: widget.car.linkRefer);
    carDescriptionController =
        TextEditingController(text: widget.car.carDescription);
  }

  Future<void> updateCar() async {
    String carName = carNameController.text;
    String carEntry = carEntryController.text;
    String carPrice = carPriceController.text;
    String carLinkImage = carLinkImageController.text;
    String carLinkRefer = carLinkReferController.text;
    String carDescription = carDescriptionController.text;

    if (carName.isNotEmpty &&
        carEntry.isNotEmpty &&
        carPrice.isNotEmpty &&
        carLinkImage.isNotEmpty &&
        carLinkRefer.isNotEmpty &&
        carDescription.isNotEmpty) {
      try {
        Map<String, dynamic> updatedData = {
          'id': widget.car.id,
          'carName': carName,
          'carEntry': carEntry,
          'price': carPrice,
          'linkImage': carLinkImage,
          'linkRefer': carLinkRefer,
          'carDescription': carDescription,
        };

        final updatedCar =
            await CarsApiService().updateCar(widget.car.id, updatedData);

        Navigator.pop(context, updatedCar);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update car: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    carNameController.dispose();
    carEntryController.dispose();
    carPriceController.dispose();
    carLinkImageController.dispose();
    carLinkReferController.dispose();
    carDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Car"),
        ),
        body: FutureBuilder<Car>(
            future: futureCar,
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No listed car.'));
              }

              final car = snapshot.data!;

              carNameController = TextEditingController(text: car.carName);
              carEntryController = TextEditingController(text: car.carEntry);
              carPriceController =
                  TextEditingController(text: car.price.toString());
              carLinkImageController =
                  TextEditingController(text: car.linkImage);
              carLinkReferController =
                  TextEditingController(text: car.linkRefer);
              carDescriptionController =
                  TextEditingController(text: car.carDescription);

              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField.create(
                        carNameController, "Enter car name", "Name"),
                    const SizedBox(height: 16),
                    CustomTextField.create(
                        carEntryController, "Enter car entry", "Entry"),
                    const SizedBox(height: 16),
                    CustomTextField.create(
                        carPriceController, "Enter car price", "Price"),
                    const SizedBox(height: 16),
                    CustomTextField.create(carLinkImageController,
                        "Enter link to the preview image", "Link to the image"),
                    const SizedBox(height: 16),
                    CustomTextField.create(carLinkReferController,
                        "Enter link to the listing pages", "Link to the pages"),
                    const SizedBox(height: 16),
                    CustomTextField.create(carDescriptionController,
                        "Enter description about car", "Description"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: updateCar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomDarkTheme.baseColor,
                        foregroundColor: CustomDarkTheme.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        minimumSize: const Size(300, 50),
                      ),
                      child: const Text(
                        "Update Car",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
            }));
  }
}
