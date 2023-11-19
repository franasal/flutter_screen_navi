import 'package:flutter/material.dart';
import 'package:navigation/constants/routes.dart';
import 'dart:async';

import 'package:navigation/widgets/widget.dart';

class AnimalDeathScreen extends StatefulWidget {
  const AnimalDeathScreen({Key? key}) : super(key: key);

  @override
  _AnimalDeathScreenState createState() => _AnimalDeathScreenState();
}

class _AnimalDeathScreenState extends State<AnimalDeathScreen> {
  AnimalDeathCounter animalDeathCounter = AnimalDeathCounter();

  @override
  void initState() {
    super.initState();

    // Start the counter update
    animalDeathCounter.startUpdating();
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
          title: const Text('Animal Death Statistics'),
          centerTitle: true,
          actions: const [
            ButtonLogin(
              route: thirdScreen,
              buttonText: "Third",
            ),
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Live Animal Death Statistics:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Display statistics for each category dynamically using GridView
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: animalsKilledPerYear.keys.length,
                itemBuilder: (context, index) {
                  final category = animalsKilledPerYear.keys.elementAt(index);
                  return LiveStatisticWidget(animalDeathCounter, category);
                },
              ),
              const SizedBox(height: 10),
              // ButtonLogin(
              //   route: startScreen,
              //   buttonText: "Start",
              // ),
              // const ButtonLogin(
              //   route: thirdScreen,
              //   buttonText: "Third",
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Stop the counter when the widget is disposed
    animalDeathCounter.stopUpdating();
    super.dispose();
  }
}

class LiveStatisticWidget extends StatefulWidget {
  final AnimalDeathCounter animalDeathCounter;
  final String category;

  const LiveStatisticWidget(
    this.animalDeathCounter,
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  _LiveStatisticWidgetState createState() => _LiveStatisticWidgetState();
}

class _LiveStatisticWidgetState extends State<LiveStatisticWidget> {
  late StreamSubscription<int> _subscription;
  int? data;

  @override
  void initState() {
    super.initState();
    _subscription = widget.animalDeathCounter
        .getCategoryStream(widget.category)
        .listen((event) {
      if (mounted) {
        setState(() {
          data = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.category,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              data == null ? 'Loading...' : '$data animals killed',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AnimalDeathCounter {
  static const updatesPerSecond = 10;
  static const secondsPerYear = 365 * 24 * 60 * 60;
  static const interval = 1000 ~/ updatesPerSecond;

  int count = 0;

  Map<String, StreamController<int>> _categoryControllers = {};

  AnimalDeathCounter() {
    for (String category in animalsKilledPerYear.keys) {
      _categoryControllers[category] = StreamController<int>.broadcast();
    }
  }

  void updateAnimalDeaths() {
    count++;
    for (String category in animalsKilledPerYear.keys) {
      final controller = _categoryControllers[category];
      if (controller != null && !controller.isClosed) {
        controller.sink.add(
          ((count *
                  (animalsKilledPerYear[category]! / secondsPerYear) /
                  updatesPerSecond))
              .round(),
        );
      }
    }
  }

  void stopUpdating() {
    for (var controller in _categoryControllers.values) {
      controller.close();
    }
    _categoryControllers.clear(); // Clear the controllers when stopping updates
  }

  void startUpdating() {
    Timer.periodic(const Duration(milliseconds: interval), (timer) {
      updateAnimalDeaths();
    });
  }

  Stream<int> getCategoryStream(String category) {
    return _categoryControllers[category]?.stream ??
        StreamController<int>.broadcast().stream;
  }
}

const Map<String, double> animalsKilledPerYear = {
  "wild_caught_fish": 970000000000,
  "chickens": 61171973510,
  "farmed_fish": 38000000000,
  "ducks": 2887594480,
  "pigs": 1451856889.38,
  "rabbits": 1171578000,
  "geese": 687147000,
  "turkeys": 618086890,
  "sheep": 536742256.33,
  "goats": 438320370.99,
  "cattle": 298799160.08,
  "rodents": 70371000,
  "other_birds": 59656000,
  //   "buffalo": 25798819,
  //   "horses": 4863367,
  //   "donkeys": 3213400,
  //   "camels": 3243266.03,
  // Add other animal categories here
};
