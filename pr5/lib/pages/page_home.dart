import 'package:flutter/material.dart';
import 'package:pr5/data/pallets.dart';
import 'package:pr5/pages/page_favorites.dart';
import 'package:pr5/pages/page_shop.dart';
import 'package:pr5/pages/pages_profile.dart';

import '../models/profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const CarListScreen(),
    const CarFavoriteScreen(),
    ProfileScreen(profile: Profile.defaultProfile)
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_search_rounded), label: 'Catalogue'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomDarkTheme.accentColor,
        onTap: _onItemTapped,
      ),
    );
  }
}