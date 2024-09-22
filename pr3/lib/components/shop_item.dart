import 'package:flutter/material.dart';
import 'package:pr3/models/car.dart';
import 'package:pr3/pages/item_page.dart';

class ShopItem extends StatelessWidget {
  final Car item;

  const ShopItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ItemPage(car: item)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.amberAccent),
            width: MediaQuery.sizeOf(context).width * 0.25,
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Column(
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        item.carName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black87),
                        textAlign: TextAlign.center,
                      )),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: SizedBox.fromSize(
                        child: Image.asset(
                      item.linkImage,
                      height: 240,
                      width: 360,
                      fit: BoxFit.cover,
                    ))),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16),
                          children: [
                        TextSpan(
                          text: item.carDescription,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ));
  }
}
