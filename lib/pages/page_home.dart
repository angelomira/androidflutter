import 'package:flutter/material.dart';
import '../data/profiles.dart';
import '../pages/page_cart.dart';
import '../data/pallets.dart';
import '../pages/page_favorites.dart';
import '../pages/page_shop.dart';
import '../pages/pages_profile.dart';

import '../models/profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    CarListScreen(),
    const CarFavoriteScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_search_rounded, color: CustomDarkTheme.backgroundColor), label: 'Catalogue'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded, color: CustomDarkTheme.backgroundColor), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: CustomDarkTheme.backgroundColor), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, color: CustomDarkTheme.backgroundColor), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomDarkTheme.accentColor,
        onTap: _onItemTapped,
      ),
    );
  }
}