import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notification/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // MyHomePage object that was created by the App.build method
        title: Text(widget.title),
      ),
      body: Center(
        // It takes a single child and positions it in the middle of the parent.
        child: Column(
          // It takes a list of children and arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Basic
            ListTile(
              onTap: () async {
                log('Function Triggered: showBasicNotification');
                await LocalNotificationService.showBasicNotification();
              },
              leading: const Icon(Icons.notifications),
              title: const Text('Basic Notification'),
              trailing: IconButton(
                onPressed: () async {
                  await LocalNotificationService.cancelNotification(0);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ),

            // const SizedBox(height: 32,),

            ListTile(
              onTap: () async {
                log('Function Triggered: showRepeatedNotification');
                await LocalNotificationService.showRepeatedNotification();
              },
              leading: const Icon(Icons.notifications),
              title: const Text('Repeated Notification'),
              trailing: IconButton(
                onPressed: () async {
                  await LocalNotificationService.cancelNotification(1);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ),

            ListTile(
              onTap: () async {
                log('Function Triggered: showScheduledNotification');
                await LocalNotificationService.showScheduledNotification();
              },
              leading: const Icon(Icons.notifications),
              title: const Text('Scheduled Notification'),
              trailing: IconButton(
                onPressed: () async {
                  await LocalNotificationService.cancelNotification(2);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ),
            /*
            const Spacer(),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _decrementCounter, child: Text('-')),
                const SizedBox(width: 32,),
                ElevatedButton(onPressed: _resetCounter, child: Text('Reset')),
              ],
            ),
            const Spacer(),
            */
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
