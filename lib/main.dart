import 'package:calendar_ptmk/pages/event_expanded_interface.dart/event_expanded.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pages/events_example.dart';
// Import rootBundle

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PTMK Calendar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Calendar'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TableEventsExample()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text('Expanded'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EventExpanded()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
