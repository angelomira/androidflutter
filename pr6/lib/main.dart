import 'package:flutter/material.dart';
import 'package:pr6/providers/provider_car.dart';
import 'package:pr6/providers/provider_cart.dart';
import 'package:provider/provider.dart';
import '../pages/page_home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retro-cars listing shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}