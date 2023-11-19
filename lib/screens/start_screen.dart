import 'package:flutter/material.dart';
import 'package:navigation/constants/routes.dart';
import 'package:navigation/widgets/widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Start Screen"),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonLogin(
              route: secondScreen,
              buttonText: "Animal Deaths",
            ),
            ButtonLogin(
              route: thirdScreen,
              buttonText: "Go to Third",
            ),
          ],
        ),
      ),
    );
  }
}
