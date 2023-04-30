import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const StopWach(title: 'Flutter Demo Home Page'),
    );
  }
}

class StopWach extends StatefulWidget {
  const StopWach({super.key, required this.title});

  final String title;

  @override
  State<StopWach> createState() => _StopWachState();
}

class _StopWachState extends State<StopWach> {
  int milliseconds = 0;
  Timer? timer;
  final laps = <int>[];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(milliseconds: 1), (Timer t) => _incrementCounter());
  }

  void _incrementCounter() {
    setState(() {
      milliseconds += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isRunning = true;

    void _startTimer() {
      timer = Timer.periodic(
          const Duration(milliseconds: 100), (Timer t) => _incrementCounter());
      setState(() {
        isRunning = true;
        laps.clear();
      });
    }

    String _secondsText(int milliseconds) {
      final seconds = milliseconds / 1000;
      return '$seconds seconds';
    }

    @override
    void dispose() {
      timer?.cancel();
      super.dispose();
    }

    Widget _lapList() {
      return ListView.builder(
          itemCount: laps.length,
          itemBuilder: (BuildContext context, int index) {
            final lap = laps[index];
            return ListTile(
              title: Text('Lap ${index + 1}'),
              trailing: Text(_secondsText(lap)),
            );
          });
    }

    void _stopTimer() {
      timer?.cancel();
      setState(() {
        isRunning = false;
      });
    }

    String _milliseconds() {
      if (milliseconds == 1) {
        return 'second';
      } else {
        return 'milliseconds';
      }
    }

    void _lap() {
      setState(() {
        laps.add(milliseconds);
        milliseconds = 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Lap ${laps.length + 1}',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isRunning ? null : _startTimer,
                child: const Text('Start'),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.yellow)),
                  onPressed: isRunning ? _lap : null,
                  child: const Text('Lap')),
              TextButton(
                onPressed: isRunning ? _stopTimer : null,
                child: const Text('Stop'),
              ),
            ],
          ),
          Expanded(child: _lapList())
        ],
      ),
    );
  }
}
