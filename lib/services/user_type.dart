import 'package:hive_flutter/hive_flutter.dart';

class UserTypeServices {
  static final myBox = Hive.box('session');

  static Future<void> set(String value) async {
    await myBox.put('type', value);
  }

  static String type() {
    if (myBox.containsKey('type')) {
      return myBox.get('type');
    }
    return "";
  }
}
