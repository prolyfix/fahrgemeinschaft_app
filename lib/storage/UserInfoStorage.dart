import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoStorage {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Future<String?> getToken() async {
    final response = await secureStorage.read(key: 'token');
    inspect(response);
    return response;
  }
}
