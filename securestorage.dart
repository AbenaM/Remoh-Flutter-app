import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';


class SecureStorage {

  FlutterSecureStorage storage;

  FlutterSecureStorage getInstance() {
    if(this.storage == null) {
      this.storage = new FlutterSecureStorage();
    }
    return this.storage;
  }

  void write(key, value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> read(key) async {
    return await storage.read(key: key);
  }

  void delete(key, value) async {
    await storage.delete(key: key);
  }
}
