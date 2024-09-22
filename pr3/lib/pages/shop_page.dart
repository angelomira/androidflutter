import 'package:flutter/material.dart';
import 'package:pr3/components/shop_item.dart';
import 'package:pr3/data/cars.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(title: const Center(child:
          Text('Retro-cars listing', style: TextStyle(fontWeight: FontWeight.bold))
              )
        ),

      body: ListView.builder(
        itemCount: carEntries.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ShopItem(item: carEntries[index]);
        },
      ),
    );
  }
}