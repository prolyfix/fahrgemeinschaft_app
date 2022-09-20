import 'dart:developer';

import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:fahrgemeinschaft_app/models/Driver.dart';
import 'package:fahrgemeinschaft_app/storage/CalendarRideStorage.dart';
import 'package:fahrgemeinschaft_app/storage/DriverStorage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fahrgemeinschaft_app/utility/Api.dart';

class DayNavigator extends StatefulWidget {
  const DayNavigator({super.key});

  @override
  State<DayNavigator> createState() => _DayNavigatorState();
}

class _DayNavigatorState extends State<DayNavigator> {
  final List<bool> _selectedFruits = <bool>[false, false, false];
  late CalendarRide calendarRide;
  DateTime now = DateTime.now();
  Api monApi = Api();
  var formatter = DateFormat('dd-MM-yyyy');
  var formatterAPI = DateFormat('yyyy-MM-dd');
  late String _formattedDate = formatter.format(now);

  @override
  void initState() {
    super.initState();
  }

  void modifyDay(int value) async {
    now = now.add(Duration(days: value));
    var _formattedDate2 = formatterAPI.format(now);
    setState(() {
      _formattedDate = formatter.format(now);
    });
    monApi.setObject('calendar_rides');
    monApi.setParams(
        {'date[before]': _formattedDate2, 'date[after]': _formattedDate2});
    debugPrint("coucou");
    monApi.fetchApi();
    debugPrint("coucou");
    if (!monApi.isEmpty()) {
      calendarRide = CalendarRide.fromJson(monApi.getData());
      inspect(calendarRide);
    }
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
              fillColor: Color.fromARGB(255, 13, 9, 9),
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
            children: [Text('Hinfahrt')],
          ),
        ]);
  }
}
