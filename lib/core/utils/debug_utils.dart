import 'package:shared_preferences/shared_preferences.dart';

void printAllSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> keys = prefs.getKeys();

  print('SharedPreferences:');
  for (String key in keys) {
    print('Key: $key, value: ${prefs.get(key)}');
  }
}