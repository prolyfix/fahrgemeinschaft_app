import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
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
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ToggleButtons(
                direction: Axis.horizontal,
                isSelected: _selectedFruits,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.red[400],
                onPressed: (index) =>
                    {log(index.toString()), modifyDay(index - 1)},
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                children: [
                  Icon(
                    Icons.arrow_left,
                  ),
                  Text(formattedDate),
                  Icon(
                    Icons.arrow_right,
                  )
                ],
              ),
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
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: [Icon(Icons.sunny)],
      )),
    );
  }
}
