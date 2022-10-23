import 'dart:developer';

import 'package:fahrgemeinschaft_app/features/dayNavigator.dart';
import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:fahrgemeinschaft_app/models/Driver.dart';
import 'package:fahrgemeinschaft_app/models/Ride.dart';
import 'package:fahrgemeinschaft_app/storage/CalendarRideStorage.dart';
import 'package:fahrgemeinschaft_app/storage/DriverStorage.dart';
import 'package:fahrgemeinschaft_app/utility/Api.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Wochenplan extends StatefulWidget {
  const Wochenplan({super.key});

  @override
  State<Wochenplan> createState() => _WochenplanState();
}

class _WochenplanState extends State<Wochenplan> {
  late List<Ride> rides = [];
  late Ride ride;
  Api monApi = Api();
  late List<dynamic> rawRides;
  late List<Widget> _monday_in = [];
  late List<Widget> monday_in = [];
  late Map<String, List<Widget>> weeklyD = {
    'monday_in': [],
    'monday_out': [],
    'tuesday_in': [],
    'tuesday_out': [],
    'wednesday_in': [],
    'wednesday_out': [],
    'thursday_in': [],
    'thursday_out': [],
    'friday_in': [],
    'friday_out': [],
    'saturday_in': [],
    'saturday_out': [],
    'sunday_in': [],
    'sunday_out': [],
  };
  late Map<String, List<Widget>> _weeklyD = {
    'monday_in': [],
    'monday_out': [],
    'tuesday_in': [],
    'tuesday_out': [],
    'wednesday_in': [],
    'wednesday_out': [],
    'thursday_in': [],
    'thursday_out': [],
    'friday_in': [],
    'friday_out': [],
    'saturday_in': [],
    'saturday_out': [],
    'sunday_in': [],
    'sunday_out': [],
  };

  @override
  void initState() {
    super.initState();
    monApi.setObject('rides');
    monApi.fetchApi().then((bool OK) {
      if (!monApi.isEmpty()) {
        rawRides = monApi.getData();
        rawRides.forEach((element) {
          ride = Ride.fromJson(element);
          _weeklyD[ride.weekday + '_' + ride.direction]!.add(ListTile(
              title: Row(children: [
                Text('\u25A0',
                    style: TextStyle(
                        color: HexColor.fromHex(ride.driver.family.color))),
                Text(ride.driver.firstName + ' ' + ride.driver.lastName),
              ]),
              subtitle: showPassenger(ride)));
        });
      }
      setState(() {
        monday_in = weeklyD['monday_in'] ?? [];
        weeklyD = _weeklyD;
      });
    });
  }

  RichText showPassenger(Ride ride) {
    String output = "";

    return RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: PassengerList(ride)));
  }

  List<TextSpan> PassengerList(Ride calendarRide) {
    List<TextSpan> output = [];
    calendarRide.passengers.forEach((elem) => {
          output.add(TextSpan(
              text: '\u25CF',
              style: TextStyle(color: HexColor.fromHex(elem.family.color)))),
          output.add(TextSpan(text: elem.firstName)),
          output.add(TextSpan(text: ' ')),
          output.add(TextSpan(text: elem.lastName + '\n')),
        });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeLeft,
    ]);
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
        6: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(
        style: BorderStyle.none,
        width: 0.5,
      ),
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
                child: Container(
                    child: Text(''), color: Theme.of(context).primaryColor)),
            TableCell(
                child: Container(
                    child: Text('Montag'),
                    color: Theme.of(context).primaryColor)),
            TableCell(
                child: Container(
                    child: Text('Dienstag'),
                    color: Theme.of(context).primaryColor)),
            TableCell(
                child: Container(
                    child: Text('Mittwoch'),
                    color: Theme.of(context).primaryColor)),
            TableCell(
                child: Container(
                    child: Text('Donnerstag'),
                    color: Theme.of(context).primaryColor)),
            TableCell(
                child: Container(
                    child: Text('Freitag'),
                    color: Theme.of(context).primaryColor)),
          ],
        ),
        TableRow(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            children: <Widget>[
              TableCell(child: Text('In')),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['monday_in'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['tuesday_in'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['wednesday_in'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['thursday_in'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['friday_in'] ?? []),
              ),
            ]),
        TableRow(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            children: <Widget>[
              TableCell(child: Text('Out')),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['monday_out'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['tuesday_out'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['wednesday_out'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['thursday_out'] ?? []),
              ),
              TableCell(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: weeklyD['friday_out'] ?? []),
              ),
            ]),
      ],
    );
  }
}
