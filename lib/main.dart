import 'package:fahrgemeinschaft_app/features/dayNavigator.dart';
import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/Driver.dart';
import 'storage/DriverStorage.dart';
import 'storage/CalendarRideStorage.dart';
import 'dart:developer';
import 'features/wochenplan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fahrgemeinschaft',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Fahrgemeinschaft'),
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
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions = <Widget>[
    DayNavigator(),
    Wochenplan(),
    Text(
      'Index 2: School',
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Kalendar',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_view_week), label: 'Wochenplan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Eigenschaften'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped));
  }
}
