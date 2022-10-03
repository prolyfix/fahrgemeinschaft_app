import 'dart:developer';

import 'package:fahrgemeinschaft_app/features/dayNavigator.dart';
import 'package:fahrgemeinschaft_app/main.dart';
import 'package:fahrgemeinschaft_app/utility/Api.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final Api api = Api();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  username = value;
                }

                return null;
              },
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  password = value;
                }

                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  api.setObject('login_check');
                  api.login(username, password).then((value) {
                    inspect(value);
                    secureStorage.write(key: 'refresh_token', value: value);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ),
                    );
                  });
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ), // Add TextFormFields and ElevatedButton here.
          ],
        ));
  }
}
