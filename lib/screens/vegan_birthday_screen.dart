import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigation/constants/routes.dart';
import 'package:navigation/widgets/widget.dart';

void main() {
  runApp(const MyApp());
}

class VeganImpact {
  int waterSavedLiters = 0;
  int grainSavedKg = 0;
  int forestedLandSavedSqM = 0;
  int co2SavedKg = 0;
  int animalLivesSaved = 0;

  VeganImpact({
    required this.waterSavedLiters,
    required this.grainSavedKg,
    required this.forestedLandSavedSqM,
    required this.co2SavedKg,
    required this.animalLivesSaved,
  });
}

class VeganBirthdayScreen extends StatefulWidget {
  const VeganBirthdayScreen({super.key});

  @override
  VeganBirthdayScreenState createState() => VeganBirthdayScreenState();
}

class VeganBirthdayScreenState extends State<VeganBirthdayScreen> {
  DateTime? selectedDate;
  VeganImpact? veganImpact;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now()
          .subtract(const Duration(days: 36500)), // Max 100 years back
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        veganImpact = calculateVeganImpact(selectedDate!);
        _showDateSummaryDialog(context);
      });
    }
  }

  void _showDateSummaryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vegan Impact Summary'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your impact as a VeganHero/ine since ${DateFormat.yMMMMd().format(selectedDate!)}:',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('💧 ${veganImpact!.waterSavedLiters} Liters of water'),
              Text('🌽 ${veganImpact!.grainSavedKg} Kg of grain'),
              Text(
                  '🌲 ${veganImpact!.forestedLandSavedSqM} Sq.m of forested land'),
              Text('☁️ ${veganImpact!.co2SavedKg} kg CO2'),
              Text('🐄 ${veganImpact!.animalLivesSaved} Animal lives'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  VeganImpact calculateVeganImpact(DateTime birthday) {
    int veganDays = DateTime.now().difference(birthday).inDays;
    int water = (veganDays * 4.164).round();
    int grain = veganDays * 18;
    int forested = veganDays * 3;
    int co2 = veganDays * 9;
    int animals = (veganDays * 0.22).round();

    return VeganImpact(
      waterSavedLiters: water,
      grainSavedKg: grain,
      forestedLandSavedSqM: forested,
      co2SavedKg: co2,
      animalLivesSaved: animals,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(startScreen, (route) => false);
            },
          ),
          title: const Text('Vegan Impact'),
          centerTitle: true,
          actions: const [
            ButtonLogin(
              route: secondScreen,
              buttonText: buttonTextAnimal,
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Enter Your Vegan Birthday'),
              ),
            ),
            const SizedBox(height: 16),
            if (selectedDate != null && veganImpact != null)
              Column(
                children: [
                  Center(
                    child: Text(
                      'Your impact as a VeganHero/ine since ${DateFormat.yMMMMd().format(selectedDate!)}:',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //       const SizedBox(height: 8),
                  // const Text('data from https://www.5vegan.org/'),
                ],
              ),
            const Text('data from https://www.5vegan.org/'),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegan Impact App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VeganBirthdayScreen(),
    );
  }
}
