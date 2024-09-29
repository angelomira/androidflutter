import 'package:flutter/material.dart';
import 'package:pr3/models/car.dart';

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
      Car car = Car(carName: carName, carEntry: carEntry, price: carPrice, linkImage: carLinkImage, linkRefer: carLinkRefer, carDescription: carDescription);

      Navigator.pop(context, car);
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
              TextField(
                controller: carNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Enter car's name:",
                  labelText: "Name",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: carEntryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Enter car's entry:",
                  labelText: "Entry",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: carPriceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Enter car's price:",
                  labelText: "Price",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: carLinkImageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Enter link to car's image:",
                  labelText: "Link",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: carLinkReferController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Enter link to car's page:",
                  labelText: "Page",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: carDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Enter description for car:",
                  labelText: "Description",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: createCar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black,
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