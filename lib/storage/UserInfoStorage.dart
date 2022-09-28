import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoStorage {
  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    final response = await storage.read(key: 'token');
    inspect(response);
    return ("ttt");
  }
}
