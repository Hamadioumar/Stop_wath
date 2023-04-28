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
  int seconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _incrementCounter());
  }

  void _incrementCounter() {
    setState(() {
      seconds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isRunning = true;

    void _startTimear() {
      timer = Timer.periodic(
          const Duration(seconds: 1), (Timer t) => _incrementCounter());
      setState(() {
        isRunning = true;
      });
    }

    void _stopTimer() {
      timer?.cancel();
      setState(() {
        isRunning = false;
      });
    }

    String _seconds() {
      if (seconds == 1) {
        return 'second';
      } else {
        return 'seconds';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$seconds ${_seconds()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isRunning ? null : _startTimear,
                  child: const Text('Start'),
                ),
                TextButton(
                  onPressed: isRunning ? _stopTimer : null,
                  child: const Text('Stop'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
