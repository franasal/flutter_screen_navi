import 'package:flutter/material.dart';
import 'package:navigation/constants/routes.dart';
import 'package:navigation/widgets/widget.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Screen"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonLogin(
              route: startScreen,
              buttonText: "Start",
            ),
            ButtonLogin(
              route: secondScreen,
              buttonText: "Animal Deaths",
            ),
          ],
        ),
      ),
    );
  }
}
