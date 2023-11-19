import 'package:flutter/material.dart';
import 'package:navigation/animal_deaths_year.dart';
import 'package:navigation/constants/routes.dart';
import 'package:navigation/widgets/widget.dart';
import 'dart:developer' as devtools show log;

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonLogin(
              route: startScreen,
              buttonText: "Go to Start",
            ),
            ButtonLogin(
              route: thirdScreen,
              buttonText: "Go to third",
            ),
          ],
        ),
      ),
    );
  }
}
