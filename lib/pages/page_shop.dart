import 'package:flutter/material.dart';
import 'package:pr9/pages/page_car_edit.dart';
import '../models/cart.dart';
import '../services/service_api_cars.dart';
import '../services/service_api_cart.dart';
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
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  late List<Car> cars;

  @override
  void initState() {
    super.initState();
    carEntries = CarsApiService().getCars();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  RangeValues priceRange = const RangeValues(1, 250000);

  List<Car> filterByPrice(List<Car> cars) {
    return cars.where((car) {
      String data = car.price.substring(1);
      double price = double.parse(data.split(' ')[0].replaceAll(',', '.'));
      return price >= priceRange.start && price <= priceRange.end;
    }).toList();
  }

  String sortOption = 'Name'; // Default sort option

  List<Car> sortCars(List<Car> cars) {
    double extractPrice(String price) {
      // Remove the "$" and anything after the first space
      String cleanedPrice = price.substring(1).split(' ')[0].replaceAll(',', '');
      return double.parse(cleanedPrice);
    }

    switch (sortOption) {
      case 'Price':
        cars.sort((a, b) => extractPrice(a.price).compareTo(extractPrice(b.price)));
        break;
      case 'Entry':
        cars.sort((a, b) => a.carEntry.compareTo(b.carEntry));
        break;
      case 'Id':
        cars.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 'Name':
      default:
        cars.sort((a, b) => a.carName.compareTo(b.carName));
        break;
    }
    return cars;
  }

  List<Car> filterCars(List<Car> cars) {
    if (searchQuery.isNotEmpty) {
      return cars
          .where((car) => car.carName.toLowerCase().contains(searchQuery))
          .toList();
    } else {
      return cars;
    }
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

    setState(() {
      carEntries = CarsApiService().getCars();
    });
  }

  void navigateToCarPage(BuildContext context, Car car, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarPage(
            item: car,
            toggleFavorite: toggleFavorite,
            removeCar: removeCar,
            navigateToEditCarPage: navigateToEditCarPage),
      ),
    );
  }

  void navigateToEditCarPage(BuildContext context, Car car) async {
    final Car result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditCarPage(car: car)));

    Map<String, dynamic> updatedData = {
      'id': car.id,
      'carName': car.carName,
      'carEntry': car.carEntry,
      'price': car.price,
      'linkImage': car.linkImage,
      'linkRefer': car.linkRefer,
      'carDescription': car.carDescription,
    };

    setState(() {
      CarsApiService().updateCar(result.id, updatedData);
      carEntries = CarsApiService().getCars();
    });
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Listing of retro-cars'),)
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Filter by price and sort by:',
                style: TextStyle(
                  color: CustomDarkTheme.additionalColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 250000,
                    divisions: 25,
                    labels: RangeLabels(
                      '\$${priceRange.start.toInt()}',
                      '\$${priceRange.end.toInt()}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        priceRange = values;
                      });
                    },
                    activeColor: CustomDarkTheme.baseColor,
                    inactiveColor: CustomDarkTheme.additionalColor.withOpacity(0.5),
                  ),
                  DropdownButton<String>(
                    value: sortOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        sortOption = newValue!;
                      });
                    },
                    items: <String>['Name', 'Price', 'Entry', 'Id']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: CustomDarkTheme.baseColor,
                          ),
                        ),
                      );
                    }).toList(),
                    dropdownColor: CustomDarkTheme.backgroundColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.center,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Find cars',
                  hintStyle: TextStyle(
                    color: CustomDarkTheme.baseColor.withOpacity(0.7),
                    textBaseline: TextBaseline.ideographic,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomDarkTheme.baseColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomDarkTheme.accentColor,
                    ),
                  ),
                ),
                cursorColor: CustomDarkTheme.accentColor,
                cursorErrorColor: CustomDarkTheme.accentColor,
                style: TextStyle(color: CustomDarkTheme.baseColor),
              ),
            ],
          ),
          Expanded(
              child: FutureBuilder<List<Car>>(
                future: carEntries,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No listed cars.'));
                  } else if (filterByPrice(sortCars(filterCars(snapshot.data!)))
                      .isEmpty) {
                    return const Center(child: Text('No cars found.'));
                  }

                  cars = filterByPrice(sortCars(filterCars(snapshot.data!)));

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
                          navigateToEditCarPage: navigateToEditCarPage,
                        );
                      });
                },
              ),
          )
        ],
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
