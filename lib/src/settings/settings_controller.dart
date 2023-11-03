import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_controller_provider.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  String _themeMode = 'light';

  SettingsController(this._prefs) {
    _themeMode = _prefs.getString('theme') ?? 'light';
  }

  // Make SettingsService a private variable so it is not used directly.
  final SharedPreferences _prefs;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.

  // Allow Widgets to read the user's preferred ThemeMode.
  String get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  // Future<void> loadSettings() async {
  //   _themeMode = _prefs.getString('theme') ?? 'light';

  //   // Important! Inform listeners a change has occurred.
  //   notifyListeners();
  // }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(String? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _prefs.setString('theme', newThemeMode);
  }

  /// get the controller from any page of your app
  static SettingsController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<SettingsControllerProvider>()
            as SettingsControllerProvider;
    return provider.controller;
  }
}
