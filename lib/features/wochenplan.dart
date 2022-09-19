import 'dart:developer';

import 'package:fahrgemeinschaft_app/models/CalendarRide.dart';
import 'package:fahrgemeinschaft_app/models/Driver.dart';
import 'package:fahrgemeinschaft_app/storage/CalendarRideStorage.dart';
import 'package:fahrgemeinschaft_app/storage/DriverStorage.dart';
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
                  child: Row(children: <Column>[
                Column(children: [Text('Marc Baudot')]),
                Column(
                    children: [Text('Juliette'), Text('Leni'), Text('Ilvy')]),
              ])),
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
            ]),
        TableRow(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            children: <Widget>[
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
              TableCell(child: Text('Montag')),
            ]),
      ],
    );
  }
}
