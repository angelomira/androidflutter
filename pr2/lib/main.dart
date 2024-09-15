import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthForm());
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Авторизация',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34
                ),
              ),
              const SizedBox(height: 100), // margin bottom 100
              const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    labelText: ' Логин',
                    filled: false),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: ' Пароль',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    filled: false
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: false, onChanged: (bool? value) {}),
                  const Text(
                    'Запомнить меня',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                //https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width
                width: MediaQuery.sizeOf(context).width / 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Войти',
                    style: TextStyle(color: Colors.white, fontSize: 20, height: 2.4),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                //https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width
                width: MediaQuery.sizeOf(context).width / 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(color: Colors.blue)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Регистрация',
                    style: TextStyle(color: Colors.blue, fontSize: 20, height: 2.4),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Восстановить пароль',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}