// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:navigation/animal_deaths_year.dart';
import 'package:navigation/constants/routes.dart';
// import 'package:navigation/screens/second_screen.dart';
import 'package:navigation/screens/start_screen.dart';
import 'package:navigation/screens/third_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Übungsaufgabe',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: StartScreen(),
          routes: {
            startScreen: (context) => const StartScreen(),
            secondScreen: (context) => const AnimalDeathScreen(),
            thirdScreen: (context) => const ThirdScreen(),
          },
        );
      },
    );
  }
}
