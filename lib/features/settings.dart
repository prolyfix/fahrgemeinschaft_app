import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: <Widget>[
      ListTile(
        leading: Icon(Icons.map),
        title: Text('Familien'),
      ),
      ListTile(
        leading: Icon(Icons.new_releases),
        title: Text('New Planning'),
      ),
      ListTile(
          leading: Icon(Icons.logout),
          title: Text('App verlassen'),
          onTap: (() {
            secureStorage.write(key: 'refresh_token', value: null);
          })),
    ]));
  }
}
