import 'package:flutter/material.dart';
import '../services/service_api_cars.dart';
import '../data/pallets.dart';
import '../models/car.dart';
import '../widgets/widget_custom_textfield.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carEntryController = TextEditingController();
  final TextEditingController carPriceController = TextEditingController();
  final TextEditingController carLinkImageController = TextEditingController();
  final TextEditingController carLinkReferController = TextEditingController();
  final TextEditingController carDescriptionController = TextEditingController();

  void createCar() {
    String carName = carNameController.text;
    String carEntry = carEntryController.text;
    String carPrice = carPriceController.text;
    String carLinkImage = carLinkImageController.text;
    String carLinkRefer = carLinkReferController.text;
    String carDescription = carDescriptionController.text;

    if(carName.isNotEmpty && carEntry.isNotEmpty && carPrice.isNotEmpty && carLinkImage.isNotEmpty &&
       carLinkRefer.isNotEmpty && carDescription.isNotEmpty) {
      CarsApiService().createCar(carName, carEntry, carPrice, carLinkImage, carLinkRefer, carDescription);

      Navigator.pop(context, this);
    }
  }

  @override
  void dispose() {
    carNameController.dispose();
    carEntryController.dispose();
    carPriceController.dispose();
    carLinkImageController.dispose();
    carLinkReferController.dispose();
    carDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listing new car"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField.create(carNameController, "Enter car name", "Name"),
              const SizedBox(height: 16),
              CustomTextField.create(carEntryController, "Enter car entry", "Entry"),
              const SizedBox(height: 16),
              CustomTextField.create(carPriceController, "Enter car price", "Price"),
              const SizedBox(height: 16),
              CustomTextField.create(carLinkImageController, "Enter link to the preview image", "Link to the image"),
              const SizedBox(height: 16),
              CustomTextField.create(carLinkReferController, "Enter link to the listing pages", "Link to the pages"),
              const SizedBox(height: 16),
              CustomTextField.create(carDescriptionController, "Enter description about car", "Description"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: createCar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomDarkTheme.baseColor,
                  foregroundColor: CustomDarkTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(300, 50),
                ),
                child: const Text("List the car",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}