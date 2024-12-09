import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pr9/providers/provider_car.dart';
import 'package:pr9/providers/provider_cart.dart';
import 'package:provider/provider.dart';
import '../pages/page_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC5szfg8D_o3uUTyR6r3uDd5s9FJXRoFJY',
          appId: '1:669698412000:android:a79c3adaa72a24281c2f85',
          messagingSenderId: '',
          projectId: 'retro-cars-listing-shop'));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
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
