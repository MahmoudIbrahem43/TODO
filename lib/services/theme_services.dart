import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'isDark';

  ThemeMode get Theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  bool _loadThemeFromBox() {
    return _box.read(_key) ?? false;
  }

  _saveThemeToBox(bool isDarkMood) {
    _box.write(_key, isDarkMood);
  }
}
