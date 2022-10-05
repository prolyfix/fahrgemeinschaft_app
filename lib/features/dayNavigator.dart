import 'dart:developer';

import 'package:fahrgemeinschaft_app/features/login.dart';
import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:fahrgemeinschaft_app/models/Driver.dart';
import 'package:fahrgemeinschaft_app/storage/CalendarRideStorage.dart';
import 'package:fahrgemeinschaft_app/storage/DriverStorage.dart';
import 'package:fahrgemeinschaft_app/storage/UserInfoStorage.dart';
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
  late List<dynamic> calendarRides;
  late List<ListTile> _finalView = [];
  late List<ListTile> finalView = [];
  DateTime now = DateTime.now();
  Api monApi = Api();
  UserInfoStorage userStorage = UserInfoStorage();
  var formatter = DateFormat('dd-MM-yyyy');
  var formatterAPI = DateFormat('yyyy-MM-dd');
  late String _formattedDate = formatter.format(now);
  bool isEdit = false;
  var iconDrive;
  @override
  void initState() {
    super.initState();
  }

  void modifyDay(int value) async {
    if (value == 0) {
      now = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2100)) ??
          DateTime.now();
    } else {
      now = now.add(Duration(days: value));
    }
    var test = userStorage.getToken();
    var _formattedDate2 = formatterAPI.format(now);
    setState(() {
      _formattedDate = formatter.format(now);
    });

    monApi.setObject('calendar_rides');
    monApi.setParams(
        {'date[before]': _formattedDate2, 'date[after]': _formattedDate2});
    monApi.fetchApi().then((bool OK) async {
      if (OK == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
        return;
      }
      finalView = [];
      if (!monApi.isEmpty()) {
        calendarRides = monApi.getData();
        inspect(calendarRides);
        calendarRides.forEach((element) {
          calendarRide = CalendarRide.fromJson(element);
          if (calendarRide.direction == "in") {
            iconDrive = Icon(Icons.arrow_forward);
          } else {
            iconDrive = Icon(Icons.arrow_back);
          }
          finalView.add(ListTile(
              leading: iconDrive,
              title: Row(children: [
                Text('\u25A0',
                    style: TextStyle(
                        color: HexColor.fromHex(
                            calendarRide.driver.family.color))),
                Text(calendarRide.driver.firstName +
                    ' ' +
                    calendarRide.driver.lastName),
                isEdit
                    ? Row(children: [
                        IconButton(
                            onPressed: () {}, icon: new Icon(Icons.delete)),
                        Icon(Icons.rotate_90_degrees_ccw)
                      ])
                    : Text('')
              ]),
              subtitle: showPassenger(calendarRide)));
        });
      }
      setState(() {
        _finalView = finalView;
      });
    });
  }

  RichText showPassenger(CalendarRide calendarRide) {
    String output = "";

    return RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: PassengerList(calendarRide)));
  }

  List<TextSpan> PassengerList(CalendarRide calendarRide) {
    List<TextSpan> output = [];
    calendarRide.passengers.forEach((elem) => {
          output.add(TextSpan(
              text: '\u25CF',
              style: TextStyle(color: HexColor.fromHex(elem.family.color)))),
          output.add(TextSpan(text: elem.firstName)),
          output.add(TextSpan(text: ' ')),
          output.add(TextSpan(text: elem.lastName)),
        });
    return output;
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
              ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: _finalView),
              TextButton(
                child: Text('Änderung teilen!'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    isEdit = true;
                    modifyDay(0);
                  });
                },
              )
            ],
          ))),
        ]);
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
