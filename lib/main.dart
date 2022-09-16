import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/Driver.dart';
import 'storage/DriverStorage.dart';
import 'storage/CalendarRideStorage.dart';
import 'dart:developer';

void main() {
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
  final List<bool> _selectedFruits = <bool>[false, false, false];
  late Future<Driver> driver;
  late Future<CalendarRide> calendarRide;
  DateTime now = DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy');
  late String formattedDate = formatter.format(now);
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions = <Widget>[
    Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ToggleButtons(
              direction: Axis.horizontal,
              isSelected: _selectedFruits,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              onPressed: (index) =>
                  {log(index.toString()), modifyDay(index - 1)},
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              children: [
                const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_left,
                    )),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(formattedDate, style: TextStyle(fontSize: 25)),
                ),
                const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_right,
                    )),
              ],
            ),
          ),
          Center(
              child: Card(
                  child: Column(
            children: [
              ListTile(
                  leading: Icon(Icons.car_crash_rounded),
                  title: Text('Hinfahrt: Marc Baudot'),
                  subtitle: Text('Lenni Weigl, Leni Zepf, Juliette Baudot ')),
              ListTile(
                  leading: Icon(Icons.car_crash_rounded),
                  title: Text('Hinfahrt: Anke Köllnik'),
                  subtitle: Text('Lenni Weigl, Leni Zepf, Juliette Baudot ')),
              ListTile(
                  leading: Icon(Icons.backpack),
                  title: Text('Rückfahrt: Anke Köllnik'),
                  subtitle: Text('Lenni Weigl, Leni Zepf, Juliette Baudot ')),
              TextButton(
                child: Text('Änderung teilen!'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {},
              )
            ],
          ))),
          Row(
            children: [
              FutureBuilder<Driver>(
                future: driver,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.lastName);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
              Text('Hinfahrt')
            ],
          ),
        ]),
    Text(
      'Index 1: Business',
    ),
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
  void initState() {
    super.initState();
    driver = DriverStorage().fetchDriver(1);
  }

  void modifyDay(int value) async {
    log(value.toString());
    now = now.add(Duration(days: value));
    log(formatter.format(now));
    formattedDate = formatter.format(now);
    log(formattedDate);
    calendarRide = CalendarRideStorage().fetchCalendarRideById(1);
    inspect(calendarRide);
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
