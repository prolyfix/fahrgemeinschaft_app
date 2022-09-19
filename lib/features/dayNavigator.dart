import 'dart:developer';

import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:fahrgemeinschaft_app/models/Driver.dart';
import 'package:fahrgemeinschaft_app/storage/CalendarRideStorage.dart';
import 'package:fahrgemeinschaft_app/storage/DriverStorage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayNavigator extends StatefulWidget {
  const DayNavigator({super.key});

  @override
  State<DayNavigator> createState() => _DayNavigatorState();
}

class _DayNavigatorState extends State<DayNavigator> {
  final List<bool> _selectedFruits = <bool>[false, false, false];
  late Future<Driver> driver;
  late Future<CalendarRide> calendarRide;
  DateTime now = DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy');
  var formatterAPI = DateFormat('yyyy-MM-dd');
  late String _formattedDate = formatter.format(now);

  @override
  void initState() {
    super.initState();
    driver = DriverStorage().fetchDriver(1);
  }

  void modifyDay(int value) {
    now = now.add(Duration(days: value));
    var _formattedDate2 = formatterAPI.format(now);
    setState(() {
      _formattedDate = formatter.format(now);
    });
    calendarRide =
        CalendarRideStorage().fetchDriverFromDate(_formattedDate2.toString());
    inspect(calendarRide);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              onPressed: (index) => {modifyDay(index - 1)},
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
                  child:
                      Text('$_formattedDate', style: TextStyle(fontSize: 25)),
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
        ]);
  }
}
